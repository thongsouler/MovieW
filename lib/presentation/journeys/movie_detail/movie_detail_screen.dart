import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/presentation/blocs/watchlist/watchlist_cubit.dart';
import '../../../common/constants/size_constants.dart';
import '../../../common/constants/translation_constants.dart';
import '../../../common/extensions/size_extensions.dart';
import '../../../common/extensions/string_extensions.dart';
import '../../../di/get_it.dart';
import '../../blocs/cast/cast_cubit.dart';
import '../../blocs/favorite/favorite_cubit.dart';
import '../../blocs/movie_detail/movie_detail_cubit.dart';
import '../../blocs/videos/videos_cubit.dart';
import 'big_poster.dart';
import 'cast_widget.dart';
import 'movie_detail_arguments.dart';
import 'videos_widget.dart';
import 'package:intl/intl.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguments movieDetailArguments;

  const MovieDetailScreen({
    Key? key,
    required this.movieDetailArguments,
  }) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailCubit _movieDetailCubit;
  late CastCubit _castCubit;
  late VideosCubit _videosCubit;
  late FavoriteCubit _favoriteCubit;
  late WatchlistCubit _watchlistCubit;

  @override
  void initState() {
    super.initState();
    _movieDetailCubit = getItInstance<MovieDetailCubit>();
    _castCubit = _movieDetailCubit.castBloc;
    _videosCubit = _movieDetailCubit.videosCubit;
    _favoriteCubit = _movieDetailCubit.favoriteCubit;
    _watchlistCubit = _movieDetailCubit.watchlistCubit;
    _movieDetailCubit.loadMovieDetail(widget.movieDetailArguments.movieId);
  }

  @override
  void dispose() {
    _movieDetailCubit.close();
    _castCubit.close();
    _videosCubit.close();
    _favoriteCubit.close();
    _watchlistCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _movieDetailCubit),
          BlocProvider.value(value: _castCubit),
          BlocProvider.value(value: _videosCubit),
          BlocProvider.value(value: _favoriteCubit),
          BlocProvider.value(value: _watchlistCubit),
        ],
        child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              final movieDetail = state.movieDetailEntity;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BigPoster(
                      movie: movieDetail,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.dimen_16.w,
                        vertical: Sizes.dimen_8.h,
                      ),
                      child: Column(
                        children: [
                          Text(
                            movieDetail.overview ?? '',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("Budget",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  subtitle: Text(
                                      (NumberFormat.simpleCurrency()
                                          .format((movieDetail.budget ?? ""))),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("Revenue",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  subtitle: Text(
                                      (NumberFormat.simpleCurrency()
                                          .format(movieDetail.revenue ?? "")),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    VideosWidget(videosCubit: _videosCubit),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
                      child: Text(
                        TranslationConstants.cast.t(context),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    CastWidget(),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 30.0, right: 30),
                    //   child: Button(
                    //     onPressed: () {
                    //       // Navigator.push(
                    //       //     context,
                    //       //     MaterialPageRoute(
                    //       //         builder: (context) => BuyTicket(
                    //       //             movieDetail.title,
                    //       //             movieDetail.posterPath)));
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => BuyTicket(
                    //                     movieDetail.title,
                    //                     movieDetail.posterPath,
                    //                   )));
                    //     },
                    //     text: TranslationConstants.buyticket,
                    //   ),
                    // )
                  ],
                ),
              );
            } else if (state is MovieDetailError) {
              return Container();
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
