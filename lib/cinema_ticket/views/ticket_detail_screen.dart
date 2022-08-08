import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movieapp/cinema_ticket/models/Film.dart';
import 'package:movieapp/cinema_ticket/services/firestore_service.dart';
import 'package:movieapp/cinema_ticket/views/pay_success_screen.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';
import 'package:uuid/uuid.dart';

class BiletDetay extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => BiletDetay(),
      );
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String getCurrentUser() {
    //GİRİŞ YAPAN KULLANICI BİLGİLERİNİ ALIYOR, BİLET BU KİŞİNİN HESABINA VERİLECEK
    final User user = firebaseAuth.currentUser!;
    final uid = user.uid;
    return uid;
  }

  List<String>? koltuklar;
  String? seans;
  String? gun;
  String? fiyat;
  String? tarih;
  Film? film;
  List<String>? koltukIds;
  String? secilenTarih;
  String? secilenSeans;

  BiletDetay({
    //YAPICI METOTLAR, BİLGİLER KOLTUK SEÇİMİ SAYFASINDAN BURAYA YOLLANDI
    this.koltuklar,
    this.seans,
    this.gun,
    this.fiyat,
    this.tarih,
    this.film,
    this.koltukIds,
    this.secilenTarih,
    this.secilenSeans,
  });
  final firestoreInstance = FirebaseFirestore.instance;
  void onSeenMessages() async {
    // EĞER SEÇİLEN KOLTUKLAR BAŞARI İLE ALINIRSA
    // KOLTUKLARI DOLU HALE GETİRECEK VERİTABANI KODLARININ BULUNDUĞU FONKSİYON
    CollectionReference ref = FirebaseFirestore.instance.collection('Seats');
    for (var i = 0; i < koltukIds!.length; i++) {
      QuerySnapshot eventsQuery =
          await ref.where('SeatId', isEqualTo: koltukIds![i]).get();
      eventsQuery.docs.forEach((msgDoc) {
        msgDoc.reference
            .collection('History')
            .doc(secilenTarih)
            .collection('Session')
            .doc(secilenSeans)
            .set({'IsFull': true});
      });
    }
  }

  getTarih() {
    final now = DateTime.now();
    return DateFormat.MMMM('tr_TR').format(now);
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          centerTitle: true,
          title: Text("Chi tiết vé"),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.pink[700],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: heightSize * 0.08,
                      child: Column(children: <Widget>[
                        Text(
                          "Film",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          film!.filmName,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ]),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: heightSize * 0.08,
                      child: Column(children: <Widget>[
                        Text(
                          "Ngày",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          gun! + " " + tarih!,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ]),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: heightSize * 0.08,
                      child: Column(children: <Widget>[
                        Text(
                          "Phòng",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          film!.room,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ]),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: heightSize * 0.08,
                      child: Column(children: <Widget>[
                        Text(
                          "Suất chiếu",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          seans!,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ]),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: heightSize * 0.1,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Ghế",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(height: 5),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: koltuklar!.length,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 5.0),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                15,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                15,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Text(
                                          koltuklar![index],
                                          textAlign: TextAlign.center,
                                        )),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(height: 50),
                  ElevatedButton.icon(
                    icon:
                        Icon(Icons.done_outline_outlined, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(21.0),
                      ),
                      primary: AppColor.royalBlue,
                    ),
                    onPressed: () async {
                      await FirestroeService.addItem(
                              //FİREBASE'E VERİ EKLEME
                              seans: seans,
                              tarih: gun! + " " + getTarih(),
                              biletId: Uuid().v1(),
                              filmId: film!.filmName,
                              koltuk: koltuklar,
                              userUid: getCurrentUser(),
                              salon: film!.room)
                          .then((result) {
                        print("thành công");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => basarili()));
                        //İŞLEM BAŞARILI İSE BAŞARILI SAYFASINA YÖNLENDİR
                      }).onError((error, stackTrace) {
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                          duration: new Duration(seconds: 4),
                          content: new Row(
                            children: <Widget>[
                              Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                              Text("Đã có lỗi xảy ra. Xin vui lòng thử lại.")
                            ], // İŞLEM BAŞARISIZ OLURSA HATA OLUŞTU KISMI ÇIKAR
                          ),
                        ));
                      });
                      onSeenMessages(); // KOLTUKLARI DOLU HALE GETİRME FONKİSYONU ÇAĞRILIYOR
                    },
                    label: Text(
                      'Thanh toán',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
