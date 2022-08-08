import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/cinema_ticket/models/ticket.dart';
import 'package:movieapp/cinema_ticket/services/firestore_service.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';

class MyTicketScreen extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String getCurrentUser() {
    final User user = firebaseAuth.currentUser!;
    final uid = user.uid;
    return uid;
  } //GİRİŞ YAPMIŞ KULLANICININ BİLGİLERİNİN ALINMASI FONKSİYONU

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: AppColor.vulcan,
          elevation: 3.0,
          centerTitle: true,
          title: Text("Vé của tôi"),
        ),
      ),
      body: StreamBuilder<List<Bilet>>(
          stream: FirestroeService.readBilet(getCurrentUser()),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapshot.data!.isNotEmpty
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.pink[700],
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: ExpansionTile(
                                  title: Text(
                                    snapshot.data![index].filmId,
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios,
                                      color: Colors.white),
                                  leading: Icon(
                                    Icons.theaters,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index].tarih +
                                        " " +
                                        snapshot.data![index].seans,
                                    style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  children: <Widget>[
                                    Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                    ),
                                    SizedBox(height: 25),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          width: widthSize * 0.3,
                                          height: heightSize * 0.07,
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "Suất chiếu",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xff30475e),
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data![index].tarih +
                                              " " +
                                              snapshot.data![index].seans,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          width: widthSize * 0.25,
                                          height: heightSize * 0.07,
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "Phòng",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xff30475e),
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Phòng" +
                                              " " +
                                              snapshot.data![index].salon,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 25),
                                    Text(
                                      "Ghế",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(
                                      color: Colors.white,
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(7),
                                        height: heightSize * 0.1,
                                        alignment: Alignment.center,
                                        child: ListView.builder(
                                            //shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: snapshot
                                                .data![index].koltuk.length,
                                            itemBuilder: (context, ind) {
                                              return Padding(
                                                padding: EdgeInsets.all(7),
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff222831),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                          snapshot.data![index]
                                                              .koltuk[ind],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 2,
                            indent: 45,
                            endIndent: 45,
                          ),
                        ],
                      );
                    })
                : Container(
                    color: Color(0xffF4F3F9),
                    width: widthSize * 1,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.info,
                          color: Colors.lightBlueAccent,
                          size: 80,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Biletiniz Bulunmuyor",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Geri Dön"),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xffFF7E7E),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
          }),
      backgroundColor: AppColor.vulcan,
    );
  }
}
