import 'dart:ui';

import 'package:axilo/common/methods/common_methods.dart';

class Vehicle {
  final String id;
  final String userID;
  final String name;
  final String type;
  final String plate;
  final Color assetColor;

  Vehicle(
      {required this.id,
      required this.userID,
      required this.name,
      required this.type,
      required this.plate,
      required this.assetColor});

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
      id: json['id'],
      userID: json['user_id'],
      name: json['name'],
      type: json['type'],
      plate: json['plate'],
      assetColor: CommonMethods.getRandomCarColor());

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userID,
        "name": name,
        "type": type,
        "plate": plate,
      };
}
