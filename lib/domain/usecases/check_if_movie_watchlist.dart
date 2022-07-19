import 'package:dartz/dartz.dart';

import '../entities/app_error.dart';
import '../entities/movie_params.dart';
import '../repositories/movie_repository.dart';
import 'usecase.dart';

class CheckIfWatchlistMovie extends UseCase<bool, MovieParams> {
  final MovieRepository movieRepository;

  CheckIfWatchlistMovie(this.movieRepository);

  @override
  Future<Either<AppError, bool>> call(MovieParams movieParams) async {
    return await movieRepository.checkIfMovieWatchlist(movieParams.id);
  }
}
