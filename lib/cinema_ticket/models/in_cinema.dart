import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Vizyon {
  final String VizyonId;
  final String Tarih;
  final String filmId;
  final String SalonId;
  Vizyon({
    required this.VizyonId,
    required this.Tarih,
    required this.filmId,
    required this.SalonId,
  });

  Map<String, dynamic> toMap() {
    return {
      'VizyonId': VizyonId,
      'Tarih': Tarih,
      'filmId': filmId,
      'SalonId': SalonId,
    };
  }

  factory Vizyon.fromMap(Map<String, dynamic> map) {
    return Vizyon(
      VizyonId: map['VizyonId'],
      Tarih: map['Tarih'],
      filmId: map['filmId'],
      SalonId: map['SalonId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Vizyon.fromJson(String source) => Vizyon.fromMap(json.decode(source));
}
