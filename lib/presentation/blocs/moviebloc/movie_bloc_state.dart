import 'package:equatable/equatable.dart';
import 'package:movieapp/data/models/movieinfo_model.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movieList;
  const MovieLoaded(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class MovieError extends MovieState {}
