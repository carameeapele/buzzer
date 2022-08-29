import 'package:buzzer/models/class_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ClassAdapter extends TypeAdapter<Class> {
  @override
  final int typeId = 5;

  @override
  Class read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return Class(
      id: fields[0] as String,
      title: fields[1] as String,
      day: fields[2] as String,
      type: fields[3] as String,
      startTime: fields[4] as DateTime,
      endTime: fields[5] as DateTime,
      room: fields[6] as String,
      professorEmail: fields[7] as String,
      details: fields[8] as String,
    );
  }

  void write(BinaryWriter writer, Class obj) {
    writer
      ..writeByte(9)
      ..write(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.day)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.startTime)
      ..writeByte(5)
      ..write(obj.endTime)
      ..writeByte(6)
      ..write(obj.room)
      ..writeByte(7)
      ..write(obj.professorEmail)
      ..writeByte(8)
      ..write(obj.details);
  }
}
