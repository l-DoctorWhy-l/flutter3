class PlayerDto {
  final String name;
  final int number;
  final String? password;

  PlayerDto({
    required this.name,
    required this.number,
    this.password,
  });
  
  PlayerDto copyWith({String? name, int? number, String? password}) {
    return PlayerDto(
      name: name ?? this.name, 
      number: number ?? this.number,
      password: password ?? this.password,
    );
  }
}
