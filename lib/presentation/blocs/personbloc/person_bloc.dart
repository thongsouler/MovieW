import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/data/data_sources/person_data_source.dart';
import 'package:movieapp/data/models/person.dart';
import 'package:movieapp/presentation/blocs/personbloc/person_event.dart';
import 'package:movieapp/presentation/blocs/personbloc/person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(PersonLoading());

  @override
  Stream<PersonState> mapEventToState(PersonEvent event) async* {
    if (event is PersonEventStated) {
      yield* _mapMovieEventStartedToState();
    }
  }

  Stream<PersonState> _mapMovieEventStartedToState() async* {
    final apiRepository = PersonRemoteDataSource();
    yield PersonLoading();
    try {
      print('Genrebloc called.');
      final List<Person> movies = await apiRepository.getTrendingPerson();
      yield PersonLoaded(movies);
    } catch (_) {
      yield PersonError();
    }
  }
}
