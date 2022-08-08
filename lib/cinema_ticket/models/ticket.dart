class Bilet {
  final String filmId;
  final String seans;
  final String tarih;
  final String salon;
  final String uid;
  final List koltuk;
  Bilet(
      {required this.filmId,
      required this.seans,
      required this.tarih,
      required this.uid,
      required this.koltuk,
      required this.salon});

  static Bilet fromJson(Map<String, dynamic> json) => Bilet(
      filmId: json['FilmId'] ?? "1",
      seans: json['Session'],
      tarih: json['History'],
      uid: json['uid'],
      koltuk: json['Seat'],
      salon: json['Room']);

  Map<String, dynamic> toMap() {
    return {
      'FilmId': filmId,
      'Session': seans,
      'History': tarih,
      'uid': uid,
      'Seat': koltuk,
      'Room': salon
    };
  }
}
