import 'package:flutter/material.dart';

class CredentialsData {
  CredentialsData({
    @required this.role,
    @required this.userId,
  });

  final String role;
  final String userId;

  factory CredentialsData.fromJson(Map<String, dynamic> json) =>
      CredentialsData(
        role: json["token"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "usserId": userId,
        "role": role,
      };
}
