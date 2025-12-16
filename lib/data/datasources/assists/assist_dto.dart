class AssistDto {
  final String id;
  final DateTime timestamp;

  AssistDto({
    required this.id,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory AssistDto.fromMap(Map<String, dynamic> map) {
    return AssistDto(
      id: map['id'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }
}

