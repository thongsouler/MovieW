class Dolu {
  final bool dolu;

  Dolu({required this.dolu});

  static Dolu fromJson(Map<String, dynamic> json) => Dolu(dolu: json['IsFull']);

  Map<String, dynamic> toMap() {
    return {'Doluluk': dolu};
  }
}
