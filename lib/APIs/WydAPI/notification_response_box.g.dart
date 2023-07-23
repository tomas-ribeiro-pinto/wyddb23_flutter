// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationResponseBoxAdapter
    extends TypeAdapter<NotificationResponseBox> {
  @override
  final int typeId = 1;

  @override
  NotificationResponseBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationResponseBox()
      ..endpoint = fields[0] as String
      ..notifications = fields[1] as String
      ..timestamp = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, NotificationResponseBox obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.endpoint)
      ..writeByte(1)
      ..write(obj.notifications)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationResponseBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
