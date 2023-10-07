class Pet {
  final String id, name, imageUrl;
  bool isFavorite, isAdopt;

  Pet(
      {required this.id,
      required this.name,
      required this.imageUrl,
      this.isFavorite = false,
      this.isAdopt = false});

  Map toMap() => {
        'name': name,
        'id': id,
        'imageUrl': imageUrl,
        'isFavorite': isFavorite,
        'isAdopt': isAdopt
      };

  factory Pet.fromMap(Map map) => Pet(
        name: map['name'],
        id: map['id'],
        imageUrl: map['imageUrl'],
        isFavorite: map['isFavorite'],
        isAdopt: map['isAdopt'],
      );
}
