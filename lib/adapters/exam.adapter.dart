import 'package:buzzer/models/exam_model.dart';
import 'package:hive_flutter/adapters.dart';

class ExamAdapter extends TypeAdapter<Exam> {
  @override
  final int typeId = 3;

  @override
  Exam read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exam(
        id: fields[0],
        title: fields[1],
        date: fields[2],
        category: fields[3],
        details: fields[4]);
  }

  @override
  void write(BinaryWriter writer, Exam obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.details);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
