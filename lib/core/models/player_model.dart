class PlayerModel {
  final String name;
  final int number;
  final String? password;

  PlayerModel({
    required this.name,
    required this.number,
    this.password,
  });

  PlayerModel copyWith({
    String? name,
    int? number,
    String? password,
  }) {
    return PlayerModel(
      name: name ?? this.name,
      number: number ?? this.number,
      password: password ?? this.password,
    );
  }
}
