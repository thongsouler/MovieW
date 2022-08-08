import 'package:flutter/cupertino.dart';

class Kullanici {
  final String KullaniciId;
  final String Adi;

  final String mail;
  Kullanici({
    required this.KullaniciId,
    required this.Adi,
   required  this.mail,
  });
  static Kullanici fromJson(Map<String, dynamic> json) => Kullanici(
        KullaniciId: json['UserId'],
        Adi: json['Username'],
        mail: json['Mail'],
      );

  Map<String, dynamic> toMap() {
    return {
      'UserId': KullaniciId,
      'Username': Adi,
      'Mail': mail,
    };
  }
}
