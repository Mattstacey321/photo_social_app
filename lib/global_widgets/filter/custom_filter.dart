import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class CustomFilter extends StatefulWidget {
  final Function onTap;
  CustomFilter({@required this.onTap});

  @override
  _CustomFilterState createState() => _CustomFilterState();
}

class _CustomFilterState extends State<CustomFilter>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _animationController1;
  Animation<double> _animation;
  Animation<double> _animation2;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animationController1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animation2 = Tween(begin: 0.0, end: 1.0).animate(_animationController1)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(onTap: () {
        return widget.onTap();
      }, child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            constraints: constraints,
            child: Stack(
              children: [
                ScaleTransition(
                  scale: _animation2,
                  alignment: Alignment.topRight,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    height: 60 + 60 * _animation.value,
                    width: 90 + 90 * _animation2.value,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          blurRadius: 0.5,
                          spreadRadius: 1,
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(1, 2))
                    ]),
                  ),
                ),
                /*Transform.scale(
                  origin: Offset(0, 1),
                  scale: _animation2.value,
                  alignment: Alignment.topRight,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    height: 40 + 40 * _animation.value,
                    width: 90 + 90 * _animation2.value,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          blurRadius: 0.5,
                          spreadRadius: 1,
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(1, 2))
                    ]),
                  ),
                ),*/
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  height: 40,
                  width: 90 +
                      90 *
                          (_animationController1.isCompleted
                              ? _animation2.value
                              : 0.0),
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 90,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          EvaIcons.arrowIosDownwardOutline,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Newst")
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.grey.withOpacity(0.2),
                      //borderRadius: BorderRadius.circular(radius),
                      onTap: () {
                        if (_animationController1.isCompleted) {
                          setState(() {
                            _animationController1.reverse().then(
                                (value) => _animationController.reverse());
                          });
                        } else {
                          setState(() {
                            _animationController.forward();
                            _animationController1.forward();
                            //.then((value) => _animationController1.forward());
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
