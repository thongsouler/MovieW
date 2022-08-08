import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Koltuk {
  final String SeatId;
  final String SeatNo;
  final String Room;
  final bool IsFull;
  final String docId;
  Koltuk({
    required this.SeatId,
   required  this.SeatNo,
   required  this.Room,
   required  this.IsFull,
   required  this.docId,
  });

  static Koltuk fromJson(Map<String, dynamic> json) => Koltuk(
      SeatId: json['SeatId'],
      SeatNo: json['SeatNo'],
      Room: json['Room'],
      IsFull: json['IsFull'],
      docId: json['docId']);

  Map<String, dynamic> toMap() {
    return {
      'SeatId': SeatId,
      'Room': Room,
      'SeatNo': SeatNo,
      'IsFull': IsFull,
      'docId': docId
    };
  }
}
