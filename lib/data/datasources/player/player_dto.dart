class PlayerDto {
  final String name;
  final int number;

  PlayerDto({
    required this.name,
    required this.number,
  });
  
  PlayerDto copyWith({String? name, int? number}) {
    return PlayerDto(name: name ?? this.name, number: number ?? this.number);
  }
}
