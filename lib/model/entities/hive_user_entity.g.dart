// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_user_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveUserEntityAdapter extends TypeAdapter<HiveUserEntity> {
  @override
  final int typeId = 0;

  @override
  HiveUserEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveUserEntity(
      email: fields[0] as String,
      password: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveUserEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveUserEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
