import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/domain/usecases/check_if_movie_watchlist.dart';
import 'package:movieapp/domain/usecases/delete_watchlist_movie.dart';
import 'package:movieapp/domain/usecases/get_watchlist_movies.dart';
import 'package:movieapp/domain/usecases/save_movie_watchlist.dart';

import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../../domain/entities/movie_params.dart';
import '../../../domain/entities/no_params.dart';


part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final SaveMovieWatchlist saveMovieWatchlist;
  final GetWatchlistMovies getWatchlistMovies;
  final DeleteWatchlistMovie deleteWatchlistMovie;
  final CheckIfWatchlistMovie checkIfWatchlistMovie;

  WatchlistCubit({
    required this.saveMovieWatchlist,
    required this.getWatchlistMovies,
    required this.deleteWatchlistMovie,
    required this.checkIfWatchlistMovie,
  }) : super(WatchlistInitial());

  void toggleWatchlistMovie(MovieEntity movieEntity, bool isWatchlist) async {
    if (isWatchlist) {
      await deleteWatchlistMovie(MovieParams(movieEntity.id));
    } else {
      await saveMovieWatchlist(movieEntity);
    }
    final response = await checkIfWatchlistMovie(MovieParams(movieEntity.id));
    emit(response.fold(
      (l) => WatchlistMoviesError(),
      (r) => IsWatchlistMovie(r),
    ));
  }

  void loadWatchlistMovie() async {
    final Either<AppError, List<MovieEntity>> response =
        await getWatchlistMovies(NoParams());

    emit(response.fold(
      (l) => WatchlistMoviesError(),
      (r) => WatchlistMoviesLoaded(r),
    ));
  }

  void deleteMovie(int movieId) async {
    await deleteWatchlistMovie(MovieParams(movieId));
    loadWatchlistMovie();
  }

  void checkIfMovieWatchlist(int movieId) async {
    final response = await checkIfWatchlistMovie(MovieParams(movieId));
    emit(response.fold(
      (l) => WatchlistMoviesError(),
      (r) => IsWatchlistMovie(r),
    ));
  }
}
