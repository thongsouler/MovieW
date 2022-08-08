import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movieapp/cinema_ticket/models/ticket.dart';
import 'package:movieapp/cinema_ticket/models/status.dart';
import 'package:movieapp/cinema_ticket/models/Film.dart';
import 'package:movieapp/cinema_ticket/models/seat.dart';
import 'package:movieapp/cinema_ticket/models/user.dart';

class FirestroeService {
//FİREBASE'DEN FİLMLERİ OKUYUP SINIFLARA ATILMASI BACK-END KODLARI
  static Stream<List<Film>> readFilms() => FirebaseFirestore.instance
      .collection('Film')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Film.fromJson(doc.data())).toList());

//FİREBASE'DEN KOLTUKLARI OKUYUP SINIFLARA ATILMASI BACK-END KODLARI
  static Stream<List<Koltuk>> readKoltuk(String SalonId) =>
      FirebaseFirestore.instance
          .collection('Seats') //Koltuk
          .where('Room', isEqualTo: SalonId) // Group theo rap phim
          .orderBy('SeatNo') //Sap xep theo cho ngoi
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Koltuk.fromJson(doc.data())).toList());

//FİREBASE'DEN KOLTUKLARIN DOLU OLUP OLMADIĞININ SINIFLARA ATILMASI BACK-END KODLARI
  static Stream<List<Dolu>> readDolu(String KoltukId, String tarih) =>
      FirebaseFirestore.instance
          .collection('Seats')
          .doc(KoltukId)
          .collection('History') // Tarih
          .doc(tarih)
          .collection('Session') //Seans
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Dolu.fromJson(doc.data())).toList());

//FİREBASE'DEN BİLETLERİN OKUNUP SINIFLARA ATILMASI BACK-END KODLARI
//READING TICKETS FROM FIREBASE AND DRIVING TO CLASS BACK-END CODES
  static Stream<List<Bilet>> readBilet(String uid) => FirebaseFirestore.instance
      .collection('Ticket')
      .where('uid',
          isEqualTo: uid) // GİRİŞ YAPAN KULLANICININ BİLETLERİNİ GETİR
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Bilet.fromJson(doc.data())).toList());

//FİREBASE'DEN KULLANICININ BİLGİLERİNİN OKUNUP SINIFLARA ATILMASI BACK-END KODLARI
  static Stream<List<Kullanici>> readKullanici(String uid) => FirebaseFirestore
      .instance
      .collection('Users')
      .where('UserId',
          isEqualTo: uid) // GİRİŞ YAPAN KULLANICININ BİLETLERİNİ GETİR
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Kullanici.fromJson(doc.data())).toList());

//BİLET BAŞARIYLA ALINIRSA BİLET OLUŞTURMA BACK-END KDLARI,
// DAHA SONRA OKUMAK ÜZERE FİREBASE'E BİLET BİLGİLERİNİ EKLİYOR
  static Future<void> addItem({
    String? userUid,
    String? seans,
    String? tarih,
    String? biletId,
    String? filmId,
    List<String>? koltuk,
    String? salon,
  }) async {
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection('Ticket').doc();
    Map<String, dynamic> data = <String, dynamic>{
      "TicketId": biletId,
      "Session": seans,
      "History": tarih,
      "FilmId": filmId,
      "uid": userUid,
      "Seat": koltuk,
      "Room": salon
    };
    await documentReferencer
        .set(data)
        .whenComplete(() => print("Bilet Eklendi"))
        .catchError((e) => print(e));
  }
}
