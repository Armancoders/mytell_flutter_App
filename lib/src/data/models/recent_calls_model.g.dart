// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_calls_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentCallsModelAdapter extends TypeAdapter<RecentCallsModel> {
  @override
  final int typeId = 0;

  @override
  RecentCallsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentCallsModel(
      callee: fields[0] as dynamic,
      caller: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, RecentCallsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.callee)
      ..writeByte(1)
      ..write(obj.caller);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentCallsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
