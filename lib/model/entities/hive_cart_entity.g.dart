// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_cart_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCartEntityAdapter extends TypeAdapter<HiveCartEntity> {
  @override
  final int typeId = 3;

  @override
  HiveCartEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCartEntity(
      product: fields[0] as ProductEntity,
      quantity: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCartEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.product)
      ..writeByte(1)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCartEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
