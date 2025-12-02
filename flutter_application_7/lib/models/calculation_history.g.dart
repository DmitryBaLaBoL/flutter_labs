// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculation_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalculationHistoryAdapter extends TypeAdapter<CalculationHistory> {
  @override
  final int typeId = 1;

  @override
  CalculationHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalculationHistory(
      type: fields[0] as String,
      input: fields[1] as String,
      result: fields[2] as String,
      timestamp: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CalculationHistory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.input)
      ..writeByte(2)
      ..write(obj.result)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculationHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
