import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/cinema_ticket/models/Film.dart';
import 'package:movieapp/cinema_ticket/services/firestore_service.dart';
import 'package:movieapp/cinema_ticket/views/film_cinema_detail_screen.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';
//import 'package:sinemabilet/views/anaekran.dart';

class Cinema extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => Cinema(),
      );
  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    // final CollectionReference collectionReference =
    //     FirebaseFirestore.instance.collection('Sinema');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Đang công chiếu"),
      ),
      body: StreamBuilder<List<Film>>(
          // Filmlerin Firebase üzerinden çekilip sınıflara atılmasıve gösterilmesi.
          // Burada snapshot, filmlerin içeriklerini içeren sınıfı temsil eder
          stream: FirestroeService.readFilms(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapshot.data!.isNotEmpty
                ? ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          InkWell(
                              onTap: () {
                                //Tıklanan filmin detaylarına gidiş fonksiyonu
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CinemaDetail(
                                        entry: snapshot.data![index])));
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Card(
                                      color: Color(0xffffffff),
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Row(children: <Widget>[
                                        Container(
                                          decoration: new BoxDecoration(
                                            color: AppColor.royalBlue,
                                            borderRadius: new BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(10),
                                                bottomLeft:
                                                    const Radius.circular(10)),
                                          ),
                                          height: heightSize * 0.17,
                                          width: widthSize * 0.04,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 100.0,
                                            height: 100.0,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(snapshot
                                                    .data![index].resim),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            width: widthSize * 0.5,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    snapshot
                                                        .data![index].filmName,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 24),
                                                  ),
                                                  Text(
                                                    snapshot.data![index]
                                                        .information,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  )
                                                ])),
                                        Row(children: <Widget>[
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 24,
                                            color: Colors.black,
                                          )
                                        ])
                                      ]))))
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
    );
  }
}
