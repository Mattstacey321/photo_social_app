import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/index.dart';
import '../../src/enum/index.dart';
import '../../src/loading_indicator/loading_indicator.dart';
import 'startup_controller.dart';

class StartUpScreen extends StatefulWidget {
  @override
  _StartUpScreenState createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> with TickerProviderStateMixin {
  StartUpController controller;
  AnimationController _animationController;
  Animation _animation;
  @override
  void initState() {
    controller = Get.find<StartUpController>();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Center(
          child: ObxValue(
            (status) => status.value == ServerStatus.checking
                ? FadeTransition(
                    opacity: _animation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoadingIndicator.startUpLoading(),
                        SizedBox(height: 15),
                        Text("Check server...")
                      ],
                    ),
                  )
                : status.value == ServerStatus.offline
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            onPress: () {
                              controller.checkAgain();
                            },
                            tooltip: "Recheck server",
                            iconColor: Colors.red,
                            icon: EvaIcons.refresh,
                            radius: 1000,
                            height: 50,
                            width: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Server Offline",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomButton(
                            onPress: null,
                            iconColor: Colors.green,
                            height: 60,
                            width: 60,
                            icon: EvaIcons.checkmarkCircle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Checking complete",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
            controller.isServerOnline,
          ),
        ),
      ),
    );
  }
}
