// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KelimeAdapter extends TypeAdapter<Kelime> {
  @override
  final int typeId = 2;

  @override
  Kelime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kelime(
      id: fields[0] as int,
      deyimid: fields[1] as int,
      osmanlica: fields[2] as String,
      text: fields[3] as String,
      team: fields[4] as int,
      mana: (fields[5] as List)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Kelime obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.deyimid)
      ..writeByte(2)
      ..write(obj.osmanlica)
      ..writeByte(3)
      ..write(obj.text)
      ..writeByte(4)
      ..write(obj.team)
      ..writeByte(5)
      ..write(obj.mana);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KelimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ManaAdapter extends TypeAdapter<Mana> {
  @override
  final int typeId = 3;

  @override
  Mana read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mana(
      id: fields[0] as String,
      text: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Mana obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ManaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SozlukAdapter extends TypeAdapter<Sozluk> {
  @override
  final int typeId = 1;

  @override
  Sozluk read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sozluk(
      kelime: (fields[0] as List)?.cast<Kelime>(),
      mana: (fields[1] as List)?.cast<Mana>(),
    );
  }

  @override
  void write(BinaryWriter writer, Sozluk obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.kelime)
      ..writeByte(1)
      ..write(obj.mana);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SozlukAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
