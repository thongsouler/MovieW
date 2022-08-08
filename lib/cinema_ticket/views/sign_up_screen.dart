import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/cinema_ticket/services/auth_service.dart';

class Kayit extends StatefulWidget {
  @override
  _KayitState createState() => _KayitState();
}

class _KayitState extends State<Kayit> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController isimController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String getCurrentUser() {
    final User user = firebaseAuth.currentUser!;
    final uid = user.uid;
    return uid;
  }

  String? getCurrentMail() {
    final User user = firebaseAuth.currentUser!;
    final uid = user.email;
    return uid;
  }

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
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                Center(
                  child: Text("Đăng ký",
                      style: TextStyle(fontSize: 34, color: Colors.white)),
                ),
                SizedBox(height: 30),
                Container(
                  width: widthSize * 0.75,
                  height: heightSize * 0.5,
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
                                controller: isimController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Họ và tên',
                                    labelStyle:
                                        TextStyle(color: AppColor.royalBlue)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    final snackBar = SnackBar(
                                        content:
                                            Text('Vui lòng không để trống.'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
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
                                    border: InputBorder.none,
                                    labelText: 'E-Mail',
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
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Mật khẩu',
                                            labelStyle: TextStyle(
                                                color: AppColor.royalBlue)),
                                      ))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 45,
                            width: widthSize * 0.4,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(21.0),
                                ),
                                primary: AppColor.royalBlue,
                              ),
                              onPressed: () {
                                if (emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty &&
                                    isimController.text.isNotEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(new SnackBar(
                                    duration: new Duration(seconds: 4),
                                    content: new Row(
                                      children: <Widget>[
                                        new CircularProgressIndicator(),
                                        new Text("Hoàn tất đăng ký....")
                                      ],
                                    ),
                                  ));
                                  loginAction().whenComplete(() {
                                    var newDocRef = FirebaseFirestore.instance
                                        .collection('Users');
                                    newDocRef.add({
                                      'Username': isimController.text.trim(),
                                      'UserId': getCurrentUser(),
                                      'Mail': getCurrentMail(),
                                    });
                                  }).then(
                                      (value) => Navigator.of(context).pop());
                                } else {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Lỗi'),
                                      content: const Text(
                                          'Email và Mật khẩu không được để trống'),
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
                              child: Text(
                                'Đăng ký ngay',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Đăng ký tài khoản ngay để sử dụng ứng dụng Tra cứu phim và đặt vé TLU Moview App",
                    style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                    textAlign: TextAlign.center,
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
    return context.read<AuthenticationService>().signUp(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
  }
}
