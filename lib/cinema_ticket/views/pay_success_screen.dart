import 'package:flutter/material.dart';
import 'package:movieapp/presentation/main-menu/main_home_screen.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';

import 'my_ticket_screen.dart';

class basarili extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.vulcan,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.verified,
            color: Colors.green,
            size: 80,
          ),
          SizedBox(height: 10),
          Text(
            "Đặt vé hoàn tất",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          ),
          SizedBox(height: 10),
          Text(
            "Vui lòng đến rạp trước giờ phim chiếu. Bạn có thể kiểm tra vé của mình trên tab Vé của tôi....",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MainHomeScreen()));
            },
            child: Text("Trang chủ"),
            style: ElevatedButton.styleFrom(
                primary: AppColor.royalBlue,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                textStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
