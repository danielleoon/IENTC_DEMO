class CharactersDB {
  final int id;
  final String name;
  final String ki;
  final String maxKi;
  final String race;
  final String gender;
  final String description;
  final String image;
  final String affiliation;
  final DateTime? deletedAt;

  CharactersDB({
    required this.id,
    required this.name,
    required this.ki,
    required this.maxKi,
    required this.race,
    required this.gender,
    required this.description,
    required this.image,
    required this.affiliation,
    this.deletedAt,
  });

  factory CharactersDB.fromJson(Map<String, dynamic> json) {
    return CharactersDB(
      id: json['id'] as int,
      name: json['name'] as String,
      ki: json['ki'].toString(),
      maxKi: json['maxKi'].toString(),
      race: json['race'] as String,
      gender: json['gender'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      affiliation: json['affiliation'] as String,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }
}
