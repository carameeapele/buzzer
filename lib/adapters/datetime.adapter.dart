import 'package:hive_flutter/hive_flutter.dart';

class DateTimeAdapter extends TypeAdapter<DateTime> {
  @override
  final typeId = 17;

  @override
  DateTime read(BinaryReader reader) {
    final micros = reader.readInt();
    return DateTime.fromMicrosecondsSinceEpoch(micros);
  }

  @override
  void write(BinaryWriter writer, DateTime obj) {
    writer.writeInt(obj.microsecondsSinceEpoch);
  }
}
