import 'package:hive/hive.dart';

import '../tables/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<void> saveMovie(MovieTable movieTable);
  Future<List<MovieTable>> getMovies();
  Future<void> deleteMovie(int movieId);
  Future<bool> checkIfMovieFavorite(int movieId);
  //watchlist
  Future<void> saveMovieWatchlist(MovieTable movieTable);
  Future<List<MovieTable>> getMoviesWatchlist();
  Future<void> deleteMovieWatchlist(int movieId);
  Future<bool> checkIfMovieWatchlist(int movieId);
}

class MovieLocalDataSourceImpl extends MovieLocalDataSource {
  @override
  Future<bool> checkIfMovieFavorite(int movieId) async {
    final movieBox = await Hive.openBox('movieBox');
    return movieBox.containsKey(movieId);
  }

  @override
  Future<void> deleteMovie(int movieId) async {
    final movieBox = await Hive.openBox('movieBox');
    await movieBox.delete(movieId);
  }

  @override
  Future<List<MovieTable>> getMovies() async {
    final movieBox = await Hive.openBox('movieBox');
    final movieIds = movieBox.keys;
    List<MovieTable> movies = [];
    movieIds.forEach((movieId) {
      final movie = movieBox.get(movieId);
      if (movie != null) {
        movies.add(movieBox.get(movieId));
      }
    });
    return movies;
  }

  @override
  Future<void> saveMovie(MovieTable movieTable) async {
    final movieBox = await Hive.openBox('movieBox');
    await movieBox.put(movieTable.id, movieTable);
  }

  //watchlist
  @override
  Future<bool> checkIfMovieWatchlist(int movieId) async {
    final movieBox = await Hive.openBox('watchlistBox');
    return movieBox.containsKey(movieId);
  }

  @override
  Future<void> deleteMovieWatchlist(int movieId) async {
    final movieBox = await Hive.openBox('watchlistBox');
    await movieBox.delete(movieId);
  }

  @override
  Future<List<MovieTable>> getMoviesWatchlist() async {
    final movieBox = await Hive.openBox('watchlistBox');
    final movieIds = movieBox.keys;
    List<MovieTable> movies = [];
    movieIds.forEach((movieId) {
      final movie = movieBox.get(movieId);
      if (movie != null) {
        movies.add(movieBox.get(movieId));
      }
    });
    return movies;
  }

  @override
  Future<void> saveMovieWatchlist(MovieTable movieTable) async {
    final movieBox = await Hive.openBox('watchlistBox');
    await movieBox.put(movieTable.id, movieTable);
  }
}
