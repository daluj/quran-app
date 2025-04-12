// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuranInitialStruct extends BaseStruct {
  QuranInitialStruct({
    int? surahId,
    int? verseId,
    int? positionId,
  })  : _surahId = surahId,
        _verseId = verseId,
        _positionId = positionId;

  // "surahId" field.
  int? _surahId;
  int get surahId => _surahId ?? 0;
  set surahId(int? val) => _surahId = val;

  void incrementSurahId(int amount) => surahId = surahId + amount;

  bool hasSurahId() => _surahId != null;

  // "verseId" field.
  int? _verseId;
  int get verseId => _verseId ?? 0;
  set verseId(int? val) => _verseId = val;

  void incrementVerseId(int amount) => verseId = verseId + amount;

  bool hasVerseId() => _verseId != null;

  // "positionId" field.
  int? _positionId;
  int get positionId => _positionId ?? 0;
  set positionId(int? val) => _positionId = val;

  void incrementPositionId(int amount) => positionId = positionId + amount;

  bool hasPositionId() => _positionId != null;

  static QuranInitialStruct fromMap(Map<String, dynamic> data) =>
      QuranInitialStruct(
        surahId: castToType<int>(data['surahId']),
        verseId: castToType<int>(data['verseId']),
        positionId: castToType<int>(data['positionId']),
      );

  static QuranInitialStruct? maybeFromMap(dynamic data) => data is Map
      ? QuranInitialStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'surahId': _surahId,
        'verseId': _verseId,
        'positionId': _positionId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'surahId': serializeParam(
          _surahId,
          ParamType.int,
        ),
        'verseId': serializeParam(
          _verseId,
          ParamType.int,
        ),
        'positionId': serializeParam(
          _positionId,
          ParamType.int,
        ),
      }.withoutNulls;

  static QuranInitialStruct fromSerializableMap(Map<String, dynamic> data) =>
      QuranInitialStruct(
        surahId: deserializeParam(
          data['surahId'],
          ParamType.int,
          false,
        ),
        verseId: deserializeParam(
          data['verseId'],
          ParamType.int,
          false,
        ),
        positionId: deserializeParam(
          data['positionId'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'QuranInitialStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is QuranInitialStruct &&
        surahId == other.surahId &&
        verseId == other.verseId &&
        positionId == other.positionId;
  }

  @override
  int get hashCode => const ListEquality().hash([surahId, verseId, positionId]);
}

QuranInitialStruct createQuranInitialStruct({
  int? surahId,
  int? verseId,
  int? positionId,
}) =>
    QuranInitialStruct(
      surahId: surahId,
      verseId: verseId,
      positionId: positionId,
    );
