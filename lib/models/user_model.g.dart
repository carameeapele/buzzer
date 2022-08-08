// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BuzzUserAdapter extends TypeAdapter<BuzzUser> {
  @override
  final int typeId = 0;

  @override
  BuzzUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BuzzUser(
      userId: fields[0] as String,
    )
      ..name = fields[1] as String
      ..email = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, BuzzUser obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuzzUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
