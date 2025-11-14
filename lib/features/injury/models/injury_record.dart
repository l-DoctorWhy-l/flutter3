class InjuryRecord {
  final bool isInjured;
  final DateTime timestamp;

  InjuryRecord({
    required this.isInjured,
    required this.timestamp,
  });

  String get statusText => isInjured ? 'Травмирован' : 'Здоров';
  
  String get fullTimestamp => timestamp.toString();
}
