class PlayerModel {
  final String name;
  final int number;

  PlayerModel({
    required this.name,
    required this.number,
  });

  PlayerModel copyWith({
    String? name,
    int? number,
  }) {
    return PlayerModel(
      name: name ?? this.name,
      number: number ?? this.number,
    );
  }
}
