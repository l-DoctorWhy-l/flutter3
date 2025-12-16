class InjuryDto {
  final bool isInjured;
  final DateTime timestamp;

  InjuryDto({
    required this.isInjured,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'is_injured': isInjured ? 1 : 0,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory InjuryDto.fromMap(Map<String, dynamic> map) {
    return InjuryDto(
      isInjured: map['is_injured'] == 1,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }
}
