import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../blocs/theme/theme_cubit.dart';
import '../../themes/theme_color.dart';

import '../../../common/constants/size_constants.dart';
import '../../../common/extensions/size_extensions.dart';
import '../../../domain/entities/movie_detail_entity.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../blocs/favorite/favorite_cubit.dart';

class MovieDetailAppBar extends StatefulWidget {
  final MovieDetailEntity movieDetailEntity;

  const MovieDetailAppBar({
    Key? key,
    required this.movieDetailEntity,
  }) : super(key: key);

  @override
  _MovieDetailAppBarState createState() => _MovieDetailAppBarState();
}

class _MovieDetailAppBarState extends State<MovieDetailAppBar> {
  String username = "";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference bookmarkMovies =
      FirebaseFirestore.instance.collection('bookmark_movies');

  void getUsername() async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    setState(() {
      username = authenticationBox.get('id');
      print(username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: context.read<ThemeCubit>().state == Themes.dark
                ? Colors.white
                : AppColor.vulcan,
            size: Sizes.dimen_12.h,
          ),
        ),
        Container(
          child: Column(
            children: [
              BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, state) {
                  if (state is IsFavoriteMovie) {
                    return GestureDetector(
                      onTap: () => BlocProvider.of<FavoriteCubit>(context)
                          .toggleFavoriteMovie(
                        MovieEntity.fromMovieDetailEntity(
                            widget.movieDetailEntity),
                        state.isMovieFavorite,
                      ),
                      child: Icon(
                        state.isMovieFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: context.read<ThemeCubit>().state == Themes.dark
                            ? Colors.white
                            : AppColor.vulcan,
                        size: Sizes.dimen_12.h,
                      ),
                    );
                  } else {
                    return Icon(
                      Icons.favorite_border,
                      color: context.read<ThemeCubit>().state == Themes.dark
                          ? Colors.white
                          : AppColor.vulcan,
                      size: Sizes.dimen_12.h,
                    );
                  }
                },
              ),
              //Thêm vào WatchList
              BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, state) {
                  if (state is IsFavoriteMovie) {
                    return GestureDetector(
                      onTap: () {
                        getUsername();
                        print('Click bookmark button');
                        addBookmark();
                      },
                      child: Icon(
                        state.isMovieFavorite
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: context.read<ThemeCubit>().state == Themes.dark
                            ? Colors.white
                            : AppColor.vulcan,
                        size: Sizes.dimen_12.h,
                      ),
                    );
                  } else {
                    return Icon(
                      Icons.bookmark_border,
                      color: context.read<ThemeCubit>().state == Themes.dark
                          ? Colors.white
                          : AppColor.vulcan,
                      size: Sizes.dimen_12.h,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> addBookmark() {
    // Call the user's CollectionReference to add a new user
    return bookmarkMovies
        .doc(username)
        .set({
          'movie-id': widget.movieDetailEntity.id, // John Doe
          // 42
        })
        .then((value) => print("Add Bookmark"))
        .catchError((error) => print("Failed to add bookmark: $error"));
  }
}
