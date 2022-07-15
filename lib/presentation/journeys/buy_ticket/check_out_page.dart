import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/data/core/api_constants.dart';
import 'package:movieapp/presentation/main-menu/main_home_screen.dart';
import 'package:movieapp/presentation/widgets/app_dialog.dart';
import 'package:movieapp/presentation/widgets/button.dart';
import '../../../common/constants/size_constants.dart';
import '../../../common/extensions/size_extensions.dart';

class CheckOutPage extends StatefulWidget {
  final String title;
  final int total;
  final String path;
  final String date;
  const CheckOutPage(
      {Key? key,
      required this.title,
      required this.total,
      required this.path,
      required this.date})
      : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: Sizes.dimen_12.h,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MainHomeScreen()),
                          ModalRoute.withName('/'));
                    },
                    child: Icon(
                      Icons.home,
                      color: Colors.white,
                      size: Sizes.dimen_12.h,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.white, width: 1))),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
                      ),
                      elevation: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
                        child: CachedNetworkImage(
                          imageUrl:
                              '${ApiConstants.BASE_IMAGE_URL}${widget.path}',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            buildPriceTag('ID Order', '22081996'),
            buildPriceTag('Cinema', 'Rạp chiếu phim Quốc gia'),
            buildPriceTag('Date & Time', widget.date),
            buildPriceTag('Seat Number', 'D7,D8,D9'),
            buildPriceTag('Price', "45.000"),
            buildPriceTag('Total', widget.total.toString()),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.white, width: 1))),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Wallet',
                    // style: TxtStyle.heading4Light,
                  ),
                  Text(
                    '200.000 VND',
                    // style: TxtStyle.heading4
                    // .copyWith(color: GradientPalette.lightBlue1),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Button(
                onPressed: () {
                  _showDialog(context);
                },
                text: TranslationConstants.buyticket,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppDialog(
        title: TranslationConstants.checkout,
        description: TranslationConstants.success,
        buttonText: TranslationConstants.okay,
        image: Image.asset(
          'assets/pngs/check.png',
          height: Sizes.dimen_32.h,
        ),
      ),
    ).then((value) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => MainHomeScreen()),
        ModalRoute.withName('/')));
  }

  Container buildPriceTag(String content, String price) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            content,
            // style: TxtStyle.heading4Light,
          ),
          Text(
            price,
            // style: TxtStyle.heading4,
          ),
        ],
      ),
    );
  }
}

class MovieInfoWidget extends StatelessWidget {
  const MovieInfoWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          width: size.width,
          child: const Text(
            'Ralph Break the Internet',
            // style: TxtStyle.heading3Medium,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          width: size.width,
          child: const Text(
            'Action & adventure, Comedy',
            // style: TxtStyle.heading4Light,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          width: size.width,
          child: const Text(
            '1h41min',
            // style: TxtStyle.heading4Light,
          ),
        )
      ],
    ));
  }
}
