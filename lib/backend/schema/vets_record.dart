import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'vets_record.g.dart';

abstract class VetsRecord implements Built<VetsRecord, VetsRecordBuilder> {
  static Serializer<VetsRecord> get serializer => _$vetsRecordSerializer;

  @nullable
  LatLng get coords;

  @nullable
  String get name;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(VetsRecordBuilder builder) =>
      builder..name = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('vets');

  static Stream<VetsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  VetsRecord._();
  factory VetsRecord([void Function(VetsRecordBuilder) updates]) = _$VetsRecord;

  static VetsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createVetsRecordData({
  LatLng coords,
  String name,
}) =>
    serializers.toFirestore(
        VetsRecord.serializer,
        VetsRecord((v) => v
          ..coords = coords
          ..name = name));
