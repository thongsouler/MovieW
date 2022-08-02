import 'article.dart';

class Post {
  List<Articles> articles;

  Post({required this.articles});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      articles: (json['articles'] as List).map((value) => new Articles.fromJson(value)).toList(),
    );
  }
}