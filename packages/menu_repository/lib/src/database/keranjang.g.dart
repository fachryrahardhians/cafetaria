// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keranjang.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KeranjangAdapter extends TypeAdapter<Keranjang> {
  @override
  final int typeId = 0;

  @override
  Keranjang read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Keranjang(
      menuId: fields[0] as String?,
      merchantId: fields[1] as String?,
      name: fields[2] as String?,
      autoResetStock: fields[3] as bool?,
      categoryId: fields[4] as String?,
      desc: fields[5] as String?,
      image: fields[6] as String?,
      isPreOrder: fields[7] as bool?,
      isRecomended: fields[8] as bool?,
      price: fields[9] as int?,
      resetTime: fields[10] as String?,
      resetType: fields[11] as String?,
      rulepreordermenuId: fields[12] as String?,
      stock: fields[13] as int?,
      tags: (fields[14] as List?)?.cast<String>(),
      quantity: fields[15] as int,
      totalPrice: fields[16] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Keranjang obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.menuId)
      ..writeByte(1)
      ..write(obj.merchantId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.autoResetStock)
      ..writeByte(4)
      ..write(obj.categoryId)
      ..writeByte(5)
      ..write(obj.desc)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.isPreOrder)
      ..writeByte(8)
      ..write(obj.isRecomended)
      ..writeByte(9)
      ..write(obj.price)
      ..writeByte(10)
      ..write(obj.resetTime)
      ..writeByte(11)
      ..write(obj.resetType)
      ..writeByte(12)
      ..write(obj.rulepreordermenuId)
      ..writeByte(13)
      ..write(obj.stock)
      ..writeByte(14)
      ..write(obj.tags)
      ..writeByte(15)
      ..write(obj.quantity)
      ..writeByte(16)
      ..write(obj.totalPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is KeranjangAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
