import 'package:dio/dio.dart';
import 'package:movieapp/data/models/account_model.dart';
import 'package:movieapp/data/models/movieinfo_model.dart';

class AccountRemoteDataSource {
  final Dio _dio = Dio();
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'api_key=f33521953035af3fc3162fe1ac22e60c';

  //Get Watchlist
  Future<AccountInfo> getAccountInfo(String sessionId) async {
    try {
      final url = '$baseUrl/account?$apiKey&session_id=$sessionId';
      final response = await _dio.get(url);
      var accountInfo = AccountInfo.fromJson(response.data);
      return accountInfo;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
