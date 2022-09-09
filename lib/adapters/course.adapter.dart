import 'package:buzzer/models/course_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 9;

  @override
  Course read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return Course(
      id: fields[0] as String,
      title: fields[1] as String,
      day: fields[2] as String,
      type: fields[3] as String,
      startTime: fields[4] as DateTime,
      endTime: fields[5] as DateTime,
      room: fields[6] as String,
      professorEmail: fields[7] as String,
      details: fields[8] as String,
      week: fields[9] as int,
      building: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
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
      ..write(obj.details)
      ..writeByte(9)
      ..write(obj.week)
      ..writeByte(10)
      ..write(obj.building);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
