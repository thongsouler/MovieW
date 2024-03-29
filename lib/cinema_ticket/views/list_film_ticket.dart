import 'package:flutter/material.dart';
import 'package:movieapp/cinema_ticket/models/Film.dart';
import 'package:movieapp/cinema_ticket/services/firestore_service.dart';
import 'package:movieapp/cinema_ticket/views/ticket_choice_screen.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';

class ListBuyTicket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.40,
          child: StreamBuilder<List<Film>>(
              // Popüler kısmının Firebase üzerinden çekilip sınıflara atılması
              // ve gösterilmesi. Burada snapshot, filmlerin içeriklerini içeren sınıfı temsil eder
              stream: FirestroeService.readFilms(),
              builder: (context, snapshot) {
                print(snapshot.connectionState);
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(), //Yükleniyor animasyonu
                  );
                }
                return snapshot.data!
                        .isNotEmpty // Eğer filmler boş değilse yani girilmiş film varsa göster
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Column(children: <Widget>[
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.28,
                                width: widthSize > 1024
                                    ? widthSize * 0.15
                                    : widthSize > 768
                                        ? widthSize * 0.2
                                        : widthSize * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(28.0),
                                    topRight: Radius.circular(28.0),
                                  ),
                                  color: const Color(0xff000000),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data![index].resim),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                        child: Text(
                                      '',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    )))),
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: widthSize > 1024
                                    ? widthSize * 0.15
                                    : widthSize > 768
                                        ? widthSize * 0.2
                                        : widthSize * 0.45,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(28.0),
                                      bottomLeft: Radius.circular(28.0),
                                    ),
                                    color: AppColor.royalBlue,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x29000000),
                                        offset: Offset(0, 6),
                                        blurRadius: 0,
                                      )
                                    ]),
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => TicketChoice(
                                                entry: snapshot.data![index])));
                                  },
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  child: Text("Đặt vé"),
                                )))
                          ]);
                        })
                    : Text('No Data'); // Filmler boşsa No Data yaz
              }),
        ));
  }
}
