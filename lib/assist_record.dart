import 'package:flutter/material.dart';

class AssistRecord {
  final DateTime timestamp;
  final Key key;

  AssistRecord({
    required this.timestamp,
    required this.key,
  });

  String get fullTimestamp => timestamp.toString();
}