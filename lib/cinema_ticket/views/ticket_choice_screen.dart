import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/cinema_ticket/components/cienma_seat.dart';
import 'package:intl/intl.dart';
import 'package:movieapp/cinema_ticket/models/status.dart';
import 'package:movieapp/cinema_ticket/models/Film.dart';
import 'package:movieapp/cinema_ticket/models/seat.dart';
import 'package:movieapp/cinema_ticket/services/firestore_service.dart';
import 'package:movieapp/cinema_ticket/views/ticket_detail_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';

class TicketChoice extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => TicketChoice(),
      );

  Film? entry;
  TicketChoice({this.entry});

  @override
  _TicketChoiceState createState() => _TicketChoiceState();
}

getCurrentDate(int i) {
  var now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day + i);
  return DateFormat('dd').format(today);
}

class _TicketChoiceState extends State<TicketChoice> {
  final BoxDecoration kRoundedFadedBorder = BoxDecoration(
      border: Border.all(color: Colors.white54, width: .5),
      borderRadius: BorderRadius.circular(15.0));
  final firestoreInstance = FirebaseFirestore.instance;
  //SEÇİLEN KOLTUKLARI GÜNÜ VE SEANSI TUTAN DEĞİŞKENLER
  List<String> savedWords = [];
  List<String> koltukIds = [];
  int fiyat = 0;
  int? selectedIndex;
  int? selectedIndex2;
  List<String> Seans = ["11:00", "14.30", "18:00", "21:00", "23:30"];
  String? secilenSeans;
  String? secilenGun;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          centerTitle: true,
          title: Text("Chọn vé"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 10),
            Center(child: Text("")),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: AppColor.royalBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  topLeft: Radius.circular(25.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  // SEÇİLEN TARİHİ TUTAN DEĞİŞKENE ATIYOR
                                });
                              },
                              child: Container(
                                width: 65.0,
                                height: 65.0,
                                decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? AppColor.vulcan
                                        : null,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(getCurrentDate(index).toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      getTarih().toUpperCase(),
                                      style: TextStyle(
                                        color: selectedIndex == index
                                            ? Colors.white54
                                            : Colors.white54,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              selectedIndex2 = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: selectedIndex2 == index
                                        ? AppColor.royalBlue
                                        : Color(0xff434852)),
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  Seans[index].toString(),
                                  style: TextStyle(
                                      color: selectedIndex2 == index
                                          ? AppColor.royalBlue
                                          : Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.tv,
                        color: Colors.blue,
                        size: 25.0,
                      ),
                      SizedBox(width: 10.0),
                      Row(
                        children: <Widget>[
                          Text(widget.entry!.filmName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: 10.0),
                        ],
                      ),
                      SizedBox(width: 5.0),
                    ],
                  ),
                  Text(
                    widget.entry!.information,
                  ),
                  Text("Phòng " + widget.entry!.room),
                ],
              ),
            ),
            if (selectedIndex != null && selectedIndex2 != null)
              Center(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: StreamBuilder<List<Koltuk>>(
                    stream: FirestroeService.readKoltuk(widget.entry!.room),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return snapshot.data!.isNotEmpty
                          ? GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 10,
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return StreamBuilder<List<Dolu>>(
                                    stream: FirestroeService.readDolu(
                                        snapshot.data![index].docId,
                                        selectedIndex.toString()),
                                    //Koltukları seçilen seansa ve tarihe göre veritabanından çekme işlemi
                                    builder: (c, sn) {
                                      bool isReserved =
                                          sn.data![selectedIndex2!].dolu;
                                      // Eğer veritabanında koltuk dolu olarak işaretlenmişse siyaha boyanması için gerekli değer
                                      String word =
                                          snapshot.data![index].SeatNo;
                                      bool isSelected =
                                          savedWords.contains(word);
                                      return sn.data!.isNotEmpty
                                          ? InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () {
                                                setState(() {
                                                  if (!isReserved) {
                                                    //EĞER KOLTUK DOLU DEĞİLSE
                                                    if (isSelected) {
                                                      savedWords.remove(word);
                                                      koltukIds.remove(snapshot
                                                          .data![index].SeatId);
                                                      fiyat -= 15;
                                                      //TIKLANAN KOLTUĞU SEÇİLEN KOLTUKLAR LİSTESİNE EKLE VE FİYATI ARTTIR
                                                      //EĞER FİLM GERİ BIRAKILIRSA LİSTEDEN ÇIKAR VE FİYATI AZALT
                                                    } else {
                                                      savedWords.add(word);
                                                      koltukIds.add(snapshot
                                                          .data![index].SeatId);
                                                      fiyat += 15;
                                                    }
                                                  } else
                                                    null;
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 5.0,
                                                    vertical: 5.0),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    15,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    15,
                                                decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? AppColor.royalBlue
                                                        //KOLTUK SEÇİLİRSE KIRMIZI YAP
                                                        : isReserved
                                                            //KOLTUK REZERVELİYSE SİYAH YAP
                                                            ? Colors.red
                                                            : null,
                                                    border: !isSelected &&
                                                            !isReserved
                                                        ? Border.all(
                                                            color: Colors.white,
                                                            width: 1.0)
                                                        : null,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0)),
                                                child: Text(
                                                  snapshot.data![index].SeatNo,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: isSelected
                                                          ? Colors.white
                                                          : Colors.white70),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ))
                                          : Text("No Data");
                                    });
                              })
                          : Text('No Data');
                    },
                  ),
                ),
              ),
            if (selectedIndex != null && selectedIndex2 != null)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                  Widget>[
                Text("Đã đặt:"),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  width: MediaQuery.of(context).size.width / 15,
                  height: MediaQuery.of(context).size.width / 15,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                Text("Đang chọn:"),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  width: MediaQuery.of(context).size.width / 15,
                  height: MediaQuery.of(context).size.width / 15,
                  decoration: BoxDecoration(
                      color: AppColor.royalBlue,
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                Text("Trống:"),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  width: MediaQuery.of(context).size.width / 15,
                  height: MediaQuery.of(context).size.width / 15,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0)),
                )
              ]),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Divider(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (fiyat > 0)
                    //EĞER KOLTUK SEÇİLDİYSE FİYAT KISMI VE SATIN AL BUTONU GÖZÜKECEKTİR
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        fiyat.toString() + ".000 Đồng",
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  if (fiyat > 0)
                    //EĞER KOLTUK SEÇİLDİYSE FİYAT KISMI VE SATIN AL BUTONU GÖZÜKECEKTİR
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      decoration: BoxDecoration(
                          color: AppColor.royalBlue,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: InkWell(
                          onTap: () {
                            //SEÇİLEN TÜM BİLGİLERİ DETAY SAYFASINA YOLLAYAN KODLAR
                            if (savedWords.length != 0) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BiletDetay(
                                        koltuklar: savedWords,
                                        fiyat: fiyat.toString(),
                                        gun: getCurrentDate(selectedIndex!)
                                            .toString(),
                                        seans:
                                            Seans[selectedIndex2!].toString(),
                                        tarih: getTarih().toString(),
                                        film: widget.entry,
                                        koltukIds: koltukIds,
                                        secilenSeans: selectedIndex2.toString(),
                                        secilenTarih: selectedIndex.toString(),
                                      )));
                            }
                          },
                          child: Text('Đặt vé',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold))),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getTarih() {
    final now = DateTime.now();

    return DateFormat.MMMM('tr_TR').format(now);
  }
}

String? replaceWhitespacesUsingRegex(String s, String replace) {
  if (s == null) {
    return null;
  }
  final pattern = RegExp('\\s+');
  return s.replaceAll(pattern, replace);
}
