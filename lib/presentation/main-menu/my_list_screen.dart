import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/presentation/blocs/watchlist/watchlist_cubit.dart';
import 'package:movieapp/presentation/journeys/favorite/favorite_screen.dart';
import 'package:movieapp/presentation/journeys/watchlist/watchlist_screen.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';

import '../../common/constants/translation_constants.dart';
import '../../common/extensions/string_extensions.dart';
import '../../di/get_it.dart';

class MyListScreen extends StatefulWidget {
  @override
  _MyListScreenState createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            TranslationConstants.mylist.t(context),
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppColor.violet,
                      AppColor.royalBlue,
                    ],
                  )),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WatchlistScreen()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.bookmark,
                    color: Colors.yellow,
                  ),
                  title: Text(
                    TranslationConstants.watchlist1.t(context),
                  ),
                  subtitle: Text(
                    TranslationConstants.watchlist2.t(context),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppColor.violet,
                      AppColor.royalBlue,
                    ],
                  )),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavoriteScreen()));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.favorite_rounded,
                    color: Colors.red,
                  ),
                  title: Text(
                    TranslationConstants.favorite1.t(context),
                  ),
                  subtitle: Text(
                    TranslationConstants.favorite2.t(context),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
