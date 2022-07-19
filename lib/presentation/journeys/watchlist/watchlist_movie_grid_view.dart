import 'package:flutter/material.dart';
import 'package:movieapp/presentation/journeys/watchlist/watchlist_movie_card_widget.dart';

import '../../../common/constants/size_constants.dart';
import '../../../common/extensions/size_extensions.dart';
import '../../../domain/entities/movie_entity.dart';


class WatchlistMovieGridView extends StatelessWidget {
  final List<MovieEntity> movies;

  const WatchlistMovieGridView({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: movies.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: Sizes.dimen_16.w,
        ),
        itemBuilder: (context, index) {
          return WatchlistMovieCardWidget(
            movie: movies[index],
          );
        },
      ),
    );
  }
}
