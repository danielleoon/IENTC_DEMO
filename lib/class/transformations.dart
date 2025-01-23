class Transformation {
  final int id;
  final String name;
  final String image;
  final String ki;
  final DateTime? deletedAt;

  Transformation({
    required this.id,
    required this.name,
    required this.image,
    required this.ki,
    this.deletedAt,
  });

  factory Transformation.fromJson(Map<String, dynamic> json) {
    return Transformation(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      ki: json['ki'].toString(),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }
}
