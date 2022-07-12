import 'package:dio/dio.dart';
import 'package:movieapp/data/models/movieinfo_model.dart';

class WatchlistRemoteDataSource {
  final Dio _dio = Dio();
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'api_key=f33521953035af3fc3162fe1ac22e60c';

  //Get Watchlist
  Future<List<Movie>> getWatchlist(int accountId) async {
    try {
      final url = '$baseUrl/account/$accountId/watchlist/movies?$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
