import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TimeOfDayAdapter extends TypeAdapter<TimeOfDay> {
  @override
  final typeId = 18;

  TimeOfDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return TimeOfDay(
      hour: fields[0],
      minute: fields[2],
    );
  }

  void write(BinaryWriter writer, TimeOfDay obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.hour)
      ..writeByte(1)
      ..write(obj.minute);
  }
}
