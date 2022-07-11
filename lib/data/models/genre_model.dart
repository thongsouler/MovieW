class TMDBGenre {
  final int id;
  final String name;

  TMDBGenre({required this.id, required this.name});

  factory TMDBGenre.fromJson(Map<String, dynamic> json) {
    return TMDBGenre(id: json["id"], name: json["name"]);
  }
}
