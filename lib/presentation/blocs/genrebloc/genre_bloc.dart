import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/data/data_sources/genre_remote_source.dart';
import 'package:movieapp/data/models/genre_model.dart';

import 'genre_event.dart';
import 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreLoading());

  @override
  Stream<GenreState> mapEventToState(GenreEvent event) async* {
    if (event is GenreEventStarted) {
      yield* _mapMovieEventStateToState();
    }
  }

  Stream<GenreState> _mapMovieEventStateToState() async* {
    final service = GenreRemoteDataSource();
    yield GenreLoading();
    try {
      List<TMDBGenre> genreList = await service.getGenreList();

      yield GenreLoaded(genreList);
    } on Exception catch (e) {
      print(e);
      yield GenreError();
    }
  }
}
