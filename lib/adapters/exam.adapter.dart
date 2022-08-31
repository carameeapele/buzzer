import 'package:buzzer/models/exam_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExamAdapter extends TypeAdapter<Exam> {
  @override
  final int typeId = 6;

  @override
  Exam read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return Exam(
      id: fields[0] as String,
      title: fields[1] as String,
      date: fields[2] as DateTime,
      time: fields[3] as DateTime,
      category: fields[4] as String,
      details: fields[5] as String,
      room: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Exam obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.details)
      ..writeByte(6)
      ..write(obj.room);
  }
}
