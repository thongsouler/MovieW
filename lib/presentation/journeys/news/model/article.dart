class Articles {
  final String title;
  final String description;
  final String url;
  final String author;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Articles(
      {required this.title,
      required this.description,
      required this.url,
      required this.author,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? "",
      author: json['author'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'] ?? "",
      content: json['content'] ?? "",
    );
  }
}
