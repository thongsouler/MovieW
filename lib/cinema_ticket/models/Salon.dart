import 'dart:convert';

import 'package:flutter/cupertino.dart';

class room {
  final int SalonId;
  final String SalonNo;
  room({
    required this.SalonId,
    required this.SalonNo,
  });

  Map<String, dynamic> toMap() {
    return {
      'SalonId': SalonId,
      'SalonNo': SalonNo,
    };
  }

  factory room.fromMap(Map<String, dynamic> map) {
    return room(
      SalonId: map['SalonId'],
      SalonNo: map['SalonNo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory room.fromJson(String source) => room.fromMap(json.decode(source));
}
