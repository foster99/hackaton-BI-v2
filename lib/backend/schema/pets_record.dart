import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'pets_record.g.dart';

abstract class PetsRecord implements Built<PetsRecord, PetsRecordBuilder> {
  static Serializer<PetsRecord> get serializer => _$petsRecordSerializer;

  @nullable
  String get name;

  @nullable
  String get uid;

  @nullable
  String get type;

  @nullable
  String get breed;

  @nullable
  BuiltList<String> get vaccines;

  @nullable
  BuiltList<String> get interventions;

  @nullable
  DateTime get birth;

  @nullable
  DocumentReference get petOwner;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(PetsRecordBuilder builder) => builder
    ..name = ''
    ..uid = ''
    ..type = ''
    ..breed = ''
    ..vaccines = ListBuilder()
    ..interventions = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('pets');

  static Stream<PetsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  PetsRecord._();
  factory PetsRecord([void Function(PetsRecordBuilder) updates]) = _$PetsRecord;

  static PetsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createPetsRecordData({
  String name,
  String uid,
  String type,
  String breed,
  DateTime birth,
  DocumentReference petOwner,
}) =>
    serializers.toFirestore(
        PetsRecord.serializer,
        PetsRecord((p) => p
          ..name = name
          ..uid = uid
          ..type = type
          ..breed = breed
          ..vaccines = null
          ..interventions = null
          ..birth = birth
          ..petOwner = petOwner));
