class PointDto {
  final int value;
  final DateTime timestamp;

  PointDto({
    required this.value,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory PointDto.fromMap(Map<String, dynamic> map) {
    return PointDto(
      value: map['value'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }
}
