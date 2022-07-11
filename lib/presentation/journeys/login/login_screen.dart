import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../../../common/constants/size_constants.dart';
import '../../../common/extensions/size_extensions.dart';
import '../../widgets/logo.dart';
import 'login_form.dart';

class LoginScreen extends StatefulWidget {
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_32.h),
              child: Logo(
                key: const ValueKey('logo_key'),
                height: Sizes.dimen_12.h,
              ),
            ),
            Expanded(
              child: LoginForm(
                key: const ValueKey('login_form_key'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
