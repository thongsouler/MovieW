import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/presentation/main-menu/main_home_screen.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';

import 'package:provider/provider.dart';
import 'package:movieapp/cinema_ticket/services/auth_service.dart';
import 'package:movieapp/cinema_ticket/views/sign_up_screen.dart';

class giris extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => giris(),
      );
  @override
  _girisState createState() => _girisState();
}

class _girisState extends State<giris> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool goster = true;
  bool _load = false;
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.vulcan,
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            //Sayfayı kapsayan widget
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Image.asset(
                  "assets/pngs/my_logo.png",
                  width: 300,
                )),
                // SizedBox(height: 30),
                Container(
                  width: widthSize * 0.75,
                  height: heightSize * 0.55,
                  child: Form(
                    child: Column(
                      key: _formKey,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: new BorderRadius.circular(19.0),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 5),
                              child: TextFormField(
                                style: TextStyle(color: Colors.purpleAccent),
                                controller: emailController,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    labelText: 'Tên đăng nhập',
                                    labelStyle:
                                        TextStyle(color: AppColor.royalBlue)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Stack(
                            alignment: const Alignment(0, 0),
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        new BorderRadius.circular(19.0),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 15, right: 15, top: 5),
                                      child: TextFormField(
                                        style: TextStyle(
                                            color: Colors.purpleAccent),
                                        controller: passwordController,
                                        obscureText: goster,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Mật khẩu',
                                            labelStyle: TextStyle(
                                                color: AppColor.royalBlue)),
                                      ))),
                              Positioned(
                                  right: 15,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        //Göster butonu
                                        goster == true
                                            ? goster = false
                                            : goster = true;
                                        setState(() {});
                                      },
                                      child: Text('Hiện')))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 45,
                            width: widthSize * 0.3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(21.0),
                                ),
                                primary: Colors.redAccent,
                              ),
                              onPressed: () {
                                if (emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(new SnackBar(
                                    duration: new Duration(seconds: 4),
                                    content: new Row(
                                      children: <Widget>[
                                        new CircularProgressIndicator(),
                                        new Text(" Đang đăng nhập")
                                      ],
                                    ),
                                  ));
                                  // loginAction().whenComplete(() {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             MainHomeScreen()));
                                  // });
                                  loginAction().then((value) {
                                    print(value);
                                    if (value == "Signed in") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainHomeScreen()));
                                    } else {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Lỗi'),
                                          content: Text(value),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  });
                                } else {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Lỗi'),
                                      content: const Text(
                                          'Các trường không được để trống'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                              child: Text('Đăng nhập',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text("Chưa có tài khoản, đăng ký ngay?",
                            style: TextStyle(color: Colors.white)),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              height: 45,
                              width: widthSize * 0.4,
                              child: ElevatedButton(
                                // Kayıt ol butonu
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(21.0),
                                    ),
                                    primary: AppColor.royalBlue),
                                onPressed: () {
                                  // Kayıt ol sayfası yönlendirmesi - Sign up page redirect
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Kayit()));
                                },
                                child: Text(
                                  'Đăng ký',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> loginAction() async {
    await new Future.delayed(const Duration(seconds: 2));
    return context.read<AuthenticationService>().signIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
  }
}
