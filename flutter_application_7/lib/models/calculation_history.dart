import 'package:hive/hive.dart';

part "calculation_history.g.dart";

@HiveType(typeId: 1)
class CalculationHistory {
  @HiveField(0)
  final String type;
  
  @HiveField(1)
  final String input;
  
  @HiveField(2)
  final String result;
  
  @HiveField(3)
  final DateTime timestamp;

  CalculationHistory({
    required this.type,
    required this.input,
    required this.result,
    required this.timestamp,
  });
}