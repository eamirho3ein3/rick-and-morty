class Character {
  final String image;
  final String title;
  final LifeStatus status;
  final String species;
  final String gender;

  Character(
      {required this.image,
      required this.title,
      required this.status,
      required this.species,
      required this.gender});

  static Character fromJson(Map<String, dynamic> json) {
    return Character(
      image: json["image"] as String,
      title: json["name"] as String,
      status: json["status"] as String == 'Alive'
          ? LifeStatus.Alive
          : json["status"] as String == 'Dead'
              ? LifeStatus.Dead
              : LifeStatus.Unknown,
      species: json["species"] as String,
      gender: json["gender"] as String,
    );
  }
}

enum LifeStatus { Alive, Dead, Unknown }
