import 'package:flutter/material.dart';
import 'package:movieapp/cinema_ticket/models/Film.dart';
import 'package:movieapp/cinema_ticket/views/list_film_ticket.dart';
import 'package:movieapp/cinema_ticket/views/ticket_choice_screen.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';

class CinemaDetail extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => CinemaDetail(),
      );
  Film? entry;
  CinemaDetail({this.entry});
  //Chi tiet phim
  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          centerTitle: true,
          title: Text("Chi tiết Film"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.network(entry!.resim,
                  width: widthSize * 0.75,
                  height: heightSize * 0.6,
                  fit: BoxFit.fill),
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: new BoxDecoration(
                color: AppColor.royalBlue,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15)),
              ),
              height: heightSize * 0.07,
              width: widthSize * 1,
              child: Text(
                entry!.filmName,
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                color: AppColor.vulcan,
                child: Column(children: <Widget>[
                  SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.info,
                        size: 26,
                      ),
                      SizedBox(width: 10),
                      Text(
                        entry!.information,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                      thickness: 5,
                      endIndent: widthSize * 0.85,
                      color: AppColor.royalBlue),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Icon(Icons.theater_comedy, size: 26),
                      SizedBox(width: 10),
                      Flexible(
                          child: Text("Phòng" + " " + entry!.room,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)))
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                      thickness: 5,
                      endIndent: widthSize * 0.85,
                      color: AppColor.royalBlue),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Icon(Icons.timer, size: 26),
                      SizedBox(width: 10),
                      Flexible(
                          child: Text(entry!.duration + " " + "Phút",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)))
                    ],
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TicketChoice(entry: entry)));
                    },
                    child: Text("Đặt vé"),
                    style: ElevatedButton.styleFrom(
                        primary: AppColor.royalBlue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        textStyle: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 30),
                  Divider(
                    thickness: 3,
                    color: AppColor.royalBlue,
                  ),
                  Text(
                    "Phim phổ biến",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  ListBuyTicket(),
                ])),
          ],
        ),
      ),
      backgroundColor: AppColor.vulcan,
    );
  }
}
