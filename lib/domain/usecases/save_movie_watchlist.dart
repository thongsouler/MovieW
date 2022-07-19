import 'package:dartz/dartz.dart';

import '../entities/app_error.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';
import 'usecase.dart';

class SaveMovieWatchlist extends UseCase<void, MovieEntity> {
  final MovieRepository movieRepository;

  SaveMovieWatchlist(this.movieRepository);

  @override
  Future<Either<AppError, void>> call(MovieEntity params) async {
    return await movieRepository.saveMovieWatchlist(params);
  }
}
