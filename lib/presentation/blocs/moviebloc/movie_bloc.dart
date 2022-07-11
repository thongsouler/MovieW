import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/data/data_sources/genre_remote_source.dart';
import 'package:movieapp/data/models/movieinfo_model.dart';

import 'movie_bloc_event.dart';
import 'movie_bloc_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieLoading());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieEventStarted) {
      yield* _mapMovieEventStateToState(event.movieId, event.query);
    }
  }

  Stream<MovieState> _mapMovieEventStateToState(
      int movieId, String query) async* {
    final service = GenreRemoteDataSource();
    yield MovieLoading();
    try {
      List<Movie> movieList;
      if (movieId == 0) {
        print("Now Playing Movie" + movieId.toString());
        movieList = await service.getNowPlayingMovie();
      } else {
        print("Get Movie by Genre" + movieId.toString());
        movieList = await service.getMovieByGenre(movieId);
      }

      yield MovieLoaded(movieList);
    } on Exception catch (e) {
      print(e);
      yield MovieError();
    }
  }
}
