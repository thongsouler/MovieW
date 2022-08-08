import 'dart:convert';

import 'package:flutter/material.dart';

class Sinema {
  final String SinemaId;
  final String SinemaAdi;
  final String Telefon;
  final String Adres;
  final String information;
  final String resim;
  Sinema({
    required this.SinemaId,
    required this.SinemaAdi,
    required this.Telefon,
    required this.Adres,
    required this.information,
    required this.resim,
  });

  static Sinema fromJson(Map<String, dynamic> json) => Sinema(
      Adres: json['Adres'],
      SinemaAdi: json['SinemaAdi'],
      SinemaId: json['SinemaId'],
      Telefon: json['Telefon'],
      information: json['information'],
      resim: json['resim']);

  Map<String, dynamic> toMap() {
    return {
      'Telefon': Telefon,
      'Adres': Adres,
      'SinemaId': SinemaId,
      'SinemaAdi': SinemaAdi,
      'information': information,
      'resim': resim
    };
  }
}
