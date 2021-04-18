import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum LoadingState { idle, loading, success, error }

class LoadingButton extends StatefulWidget {
  final LoadingButtonController controller;

  /// The vertical extent of the button.
  final double height;

  /// The horiztonal extent of the button.
  final double width;

  /// The callback that is called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// The initial widget
  final Widget initialWidget;

  /// The success widget
  final Widget successWidget;

  /// The success widget
  final Widget errorWidget;

  final bool value;

  final Color buttonColor;

  final Gradient gradient;

  final double radius;

  /// Whether to trigger the animation on the tap event
  final bool animateOnTap;

  const LoadingButton({
    @required this.controller,
    @required this.height,
    @required this.width,
    this.onPressed,
    @required this.initialWidget,
    Widget successWidget,
    Widget errorWidget,
    this.animateOnTap = true,
    this.value = false,
    this.buttonColor = Colors.indigo,
    this.gradient,
    this.radius = 15,
  })  : successWidget = const Icon(EvaIcons.checkmark),
        errorWidget = const Icon(EvaIcons.close);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> with TickerProviderStateMixin {
  AnimationController _buttonController;
  AnimationController _checkButtonControler;

  Animation _squeezeAnimation;
  Animation _bounceAnimation;

  final _state = BehaviorSubject<LoadingState>.seeded(LoadingState.idle);

  @override
  void initState() {
    super.initState();
    _buttonController = new AnimationController(duration: Duration(milliseconds: 250), vsync: this);

    _checkButtonControler =
        new AnimationController(duration: new Duration(milliseconds: 1000), vsync: this);

    _bounceAnimation = Tween<double>(begin: 0, end: widget.height)
        .animate(new CurvedAnimation(parent: _checkButtonControler, curve: Curves.elasticOut));

    _bounceAnimation.addListener(() {
      setState(() {});
    });

    _squeezeAnimation = Tween<double>(begin: widget.width, end: widget.height)
        .animate(new CurvedAnimation(parent: _buttonController, curve: Curves.fastOutSlowIn));

    _squeezeAnimation.addListener(() {
      setState(() {});
    });

    _squeezeAnimation.addStatusListener((state) {
      if (state == AnimationStatus.completed && widget.animateOnTap) {
        widget.onPressed();
      }
    });

    widget.controller._addListeners(_start, _stop, _success, _error, _reset, _idle);
  }

  @override
  void dispose() {
    _buttonController.dispose();
    _checkButtonControler.dispose();
    _state.close();
    super.dispose();
  }

  _btnPressed() async {
    if (widget.animateOnTap) {
      _start();
    } else {
      widget.onPressed();
    }
  }

 // get _loadingState => _state.value;

  _start() {
    _state.sink.add(LoadingState.loading);
    _buttonController.forward();
  }

  _stop() {
    _state.sink.add(LoadingState.idle);
    _buttonController.reverse();
  }

  _success() {
    _state.sink.add(LoadingState.success);
    _checkButtonControler.forward();
  }

  _error() {
    _state.sink.add(LoadingState.error);
    Future.delayed(Duration(seconds: 1), () => _reset());

    _checkButtonControler.forward();
  }

  _reset() {
    _state.sink.add(LoadingState.idle);
    _buttonController.reverse();
    _checkButtonControler.reset();
  }

  _idle() {
    _state.sink.add(LoadingState.idle);
  }

  @override
  Widget build(BuildContext context) {
    var _loader = SizedBox(
      height: widget.height * 0.45,
      width: widget.height * 0.45,
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white), strokeWidth: 2),
    );

    var childStream = StreamBuilder(
      stream: _state,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: snapshot.data == LoadingState.loading ? _loader : widget.initialWidget);
      },
    );

    var _uncheck = InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        _start();
      },
      child: widget.successWidget,
    );

    var _check = _bounceAnimation.value > 20 ? widget.successWidget : null;

    var _cross = _bounceAnimation.value > 20 ? widget.errorWidget : null;

    var _btn = InkWell(
      borderRadius: BorderRadius.circular(widget.radius),
      child: Container(height: widget.height, width: widget.width, child: childStream),
      onTap: widget.onPressed == null ? null : _btnPressed,
    );

    return Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color:
              widget.onPressed == null ? widget.buttonColor.withOpacity(0.2) : widget.buttonColor,
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        child: Center(
            child: _state.value == LoadingState.idle && widget.value
                ? _uncheck
                : _state.value == LoadingState.error
                    ? _cross
                    : _state.value == LoadingState.success
                        ? _check
                        : _btn));
  }
}

class LoadingButtonController {
  VoidCallback _startListener;
  VoidCallback _stopListener;
  VoidCallback _successListener;
  VoidCallback _errorListener;
  VoidCallback _resetListener;
  VoidCallback _idleListener;
  VoidCallback _loadingState;
  _addListeners(
      //LoadingState loadingState,
      VoidCallback startListener,
      VoidCallback stopListener,
      VoidCallback successListener,
      VoidCallback errorListener,
      VoidCallback resetListener,
      VoidCallback idleListener) {
    //this._loadingState = loadingState as VoidCallback ;
    this._idleListener = idleListener;
    this._startListener = startListener;
    this._stopListener = stopListener;
    this._successListener = successListener;
    this._errorListener = errorListener;
    this._resetListener = resetListener;
  }

  get loadingState => _loadingState;

  start() {
    _startListener();
  }

  stop() {
    _stopListener();
  }

  success() {
    _successListener();
  }

  error() {
    _errorListener();
  }

  reset() {
    _resetListener();
  }

  idle() {
    _idleListener();
  }
}
