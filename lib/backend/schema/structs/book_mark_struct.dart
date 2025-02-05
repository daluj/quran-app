// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BookMarkStruct extends BaseStruct {
  BookMarkStruct({
    int? surahId,
    int? verseId,
  })  : _surahId = surahId,
        _verseId = verseId;

  // "surah_id" field.
  int? _surahId;
  int get surahId => _surahId ?? 0;
  set surahId(int? val) => _surahId = val;

  void incrementSurahId(int amount) => surahId = surahId + amount;

  bool hasSurahId() => _surahId != null;

  // "verse_id" field.
  int? _verseId;
  int get verseId => _verseId ?? 0;
  set verseId(int? val) => _verseId = val;

  void incrementVerseId(int amount) => verseId = verseId + amount;

  bool hasVerseId() => _verseId != null;

  static BookMarkStruct fromMap(Map<String, dynamic> data) => BookMarkStruct(
        surahId: castToType<int>(data['surah_id']),
        verseId: castToType<int>(data['verse_id']),
      );

  static BookMarkStruct? maybeFromMap(dynamic data) =>
      data is Map ? BookMarkStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'surah_id': _surahId,
        'verse_id': _verseId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'surah_id': serializeParam(
          _surahId,
          ParamType.int,
        ),
        'verse_id': serializeParam(
          _verseId,
          ParamType.int,
        ),
      }.withoutNulls;

  static BookMarkStruct fromSerializableMap(Map<String, dynamic> data) =>
      BookMarkStruct(
        surahId: deserializeParam(
          data['surah_id'],
          ParamType.int,
          false,
        ),
        verseId: deserializeParam(
          data['verse_id'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'BookMarkStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BookMarkStruct &&
        surahId == other.surahId &&
        verseId == other.verseId;
  }

  @override
  int get hashCode => const ListEquality().hash([surahId, verseId]);
}

BookMarkStruct createBookMarkStruct({
  int? surahId,
  int? verseId,
}) =>
    BookMarkStruct(
      surahId: surahId,
      verseId: verseId,
    );
