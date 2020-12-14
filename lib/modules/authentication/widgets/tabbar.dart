import 'package:flutter/material.dart';

class AuthenticationTabBar extends StatelessWidget {
  final TabController tabController;
  AuthenticationTabBar({@required this.tabController});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: Container(
        width: 200,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: TabBar(
            controller: tabController,
            //indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 1,
            labelPadding: EdgeInsets.symmetric(horizontal: 2.0),
            indicator: UnderlineTabIndicator(
              insets: EdgeInsets.symmetric(horizontal: 80),
            ),
            tabs: [
              Container(
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  "Login",
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  "Register",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
