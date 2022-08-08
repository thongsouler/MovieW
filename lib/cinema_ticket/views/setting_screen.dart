import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/cinema_ticket/models/user.dart';
import 'package:movieapp/cinema_ticket/services/auth_service.dart';
import 'package:movieapp/cinema_ticket/views/login_screen.dart';
import 'package:movieapp/presentation/journeys/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:movieapp/cinema_ticket/services/firestore_service.dart';
import 'package:movieapp/cinema_ticket/views/my_ticket_screen.dart';

class SettingScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SettingScreen(),
      );

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String getCurrentUser() {
    final User user = firebaseAuth.currentUser!;
    final uid = user.uid;
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(40.0),
      //   child: AppBar(
      //     backgroundColor: Color(0xff434852),
      //     elevation: 3.0,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.only(
      //         bottomRight: Radius.circular(30.0),
      //         bottomLeft: Radius.circular(30.0),
      //       ),
      //     ),
      //     centerTitle: true,
      //     title: Text("Profile"),
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(15),
              height: heightSize * 0.10,
              width: double.infinity,
              child: StreamBuilder<List<Kullanici>>(
                  stream: FirestroeService.readKullanici(getCurrentUser()),
                  builder: (context, snapshot) {
                    return Text(
                      "Xin chào " +
                          (snapshot.hasData ? snapshot.data![0].Adi : ""),
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    );
                  }),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xffFF7E7E),
              ),
            ),
            SizedBox(height: 30),
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.confirmation_num),
                  trailing: Icon(Icons.chevron_right),
                  title: Text('Vé của tôi'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyTicketScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Đăng xuất'),
                  onTap: () {
                    // context.read<AuthenticationService>().signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => giris()),
                        (route) => false);
                  },
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
