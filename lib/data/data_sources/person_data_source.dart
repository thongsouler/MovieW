import 'package:dio/dio.dart';
import 'package:movieapp/data/models/person.dart';

class PersonRemoteDataSource {
  final Dio _dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'api_key=f33521953035af3fc3162fe1ac22e60c';

  Future<List<Person>> getTrendingPerson() async {
    try {
      final response = await _dio.get('$baseUrl/trending/person/week?$apiKey');
      var persons = response.data['results'] as List;
      List<Person> personList = persons.map((p) => Person.fromJson(p)).toList();
      return personList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
