import 'package:flutter/cupertino.dart';

class Film {
  final String filmId;
  final String filmName;
  final String information;
  final String resim;
  final String room;
  final String duration;
  Film(
      {required this.filmId,
      required this.filmName,
      required this.information,
      required this.resim,
      required this.room,
      required this.duration});

  static Film fromJson(Map<String, dynamic> json) => Film(
        filmId: json['filmId'],
        filmName: json['filmName'],
        information: json['information'],
        resim: json['resim'],
        room: json['room'],
        duration: json['duration'] ?? "100",
      );

  Map<String, dynamic> toMap() {
    return {
      'filmId': filmId,
      'filmName': filmName,
      'information': information,
      'resim': resim,
      'room': room,
      'duration': duration
    };
  }
}
