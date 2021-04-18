import 'package:flutter/material.dart';

class RouteModel {
  String page;
  int nestedKey;
  List<String> routes;
  bool locked;
  RouteModel({
    @required this.page,
    @required this.nestedKey,
    @required this.routes,
    this.locked = false,
  });

  RouteModel copyWith({String page, int nestedKey, List<String> routes, bool locked}) {
    return RouteModel(
        page: page ?? this.page,
        nestedKey: nestedKey ?? this.nestedKey,
        routes: routes ?? this.routes,
        locked: locked ?? this.locked);
  }
}