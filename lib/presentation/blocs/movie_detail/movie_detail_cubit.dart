import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieapp/presentation/blocs/watchlist/watchlist_cubit.dart';

import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/movie_detail_entity.dart';
import '../../../domain/entities/movie_params.dart';
import '../../../domain/usecases/get_movie_detail.dart';
import '../cast/cast_cubit.dart';
import '../favorite/favorite_cubit.dart';
import '../loading/loading_cubit.dart';
import '../videos/videos_cubit.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final CastCubit castBloc;
  final VideosCubit videosCubit;
  final FavoriteCubit favoriteCubit;
  final LoadingCubit loadingCubit;
  final WatchlistCubit watchlistCubit;

  MovieDetailCubit({
    required this.getMovieDetail,
    required this.castBloc,
    required this.videosCubit,
    required this.favoriteCubit,
    required this.watchlistCubit,
    required this.loadingCubit,
  }) : super(MovieDetailInitial());

  void loadMovieDetail(int movieId) async {
    loadingCubit.show();
    final Either<AppError, MovieDetailEntity> eitherResponse =
        await getMovieDetail(
      MovieParams(movieId),
    );

    emit(eitherResponse.fold(
      (l) => MovieDetailError(),
      (r) => MovieDetailLoaded(r),
    ));

    favoriteCubit.checkIfMovieFavorite(movieId);
    watchlistCubit.checkIfMovieWatchlist(movieId);
    castBloc.loadCast(movieId);
    videosCubit.loadVideos(movieId);
    loadingCubit.hide();
  }
}
