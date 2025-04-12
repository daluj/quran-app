// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AudioItemStruct extends BaseStruct {
  AudioItemStruct({
    String? arabicText,
    String? transliteration,
    String? audioUrl,
    String? surahId,
    String? verseId,
    String? positionId,
  })  : _arabicText = arabicText,
        _transliteration = transliteration,
        _audioUrl = audioUrl,
        _surahId = surahId,
        _verseId = verseId,
        _positionId = positionId;

  // "arabicText" field.
  String? _arabicText;
  String get arabicText => _arabicText ?? '';
  set arabicText(String? val) => _arabicText = val;

  bool hasArabicText() => _arabicText != null;

  // "transliteration" field.
  String? _transliteration;
  String get transliteration => _transliteration ?? '';
  set transliteration(String? val) => _transliteration = val;

  bool hasTransliteration() => _transliteration != null;

  // "audioUrl" field.
  String? _audioUrl;
  String get audioUrl => _audioUrl ?? '';
  set audioUrl(String? val) => _audioUrl = val;

  bool hasAudioUrl() => _audioUrl != null;

  // "surahId" field.
  String? _surahId;
  String get surahId => _surahId ?? '';
  set surahId(String? val) => _surahId = val;

  bool hasSurahId() => _surahId != null;

  // "verseId" field.
  String? _verseId;
  String get verseId => _verseId ?? '';
  set verseId(String? val) => _verseId = val;

  bool hasVerseId() => _verseId != null;

  // "positionId" field.
  String? _positionId;
  String get positionId => _positionId ?? '';
  set positionId(String? val) => _positionId = val;

  bool hasPositionId() => _positionId != null;

  static AudioItemStruct fromMap(Map<String, dynamic> data) => AudioItemStruct(
        arabicText: data['arabicText'] as String?,
        transliteration: data['transliteration'] as String?,
        audioUrl: data['audioUrl'] as String?,
        surahId: data['surahId'] as String?,
        verseId: data['verseId'] as String?,
        positionId: data['positionId'] as String?,
      );

  static AudioItemStruct? maybeFromMap(dynamic data) => data is Map
      ? AudioItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'arabicText': _arabicText,
        'transliteration': _transliteration,
        'audioUrl': _audioUrl,
        'surahId': _surahId,
        'verseId': _verseId,
        'positionId': _positionId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'arabicText': serializeParam(
          _arabicText,
          ParamType.String,
        ),
        'transliteration': serializeParam(
          _transliteration,
          ParamType.String,
        ),
        'audioUrl': serializeParam(
          _audioUrl,
          ParamType.String,
        ),
        'surahId': serializeParam(
          _surahId,
          ParamType.String,
        ),
        'verseId': serializeParam(
          _verseId,
          ParamType.String,
        ),
        'positionId': serializeParam(
          _positionId,
          ParamType.String,
        ),
      }.withoutNulls;

  static AudioItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      AudioItemStruct(
        arabicText: deserializeParam(
          data['arabicText'],
          ParamType.String,
          false,
        ),
        transliteration: deserializeParam(
          data['transliteration'],
          ParamType.String,
          false,
        ),
        audioUrl: deserializeParam(
          data['audioUrl'],
          ParamType.String,
          false,
        ),
        surahId: deserializeParam(
          data['surahId'],
          ParamType.String,
          false,
        ),
        verseId: deserializeParam(
          data['verseId'],
          ParamType.String,
          false,
        ),
        positionId: deserializeParam(
          data['positionId'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AudioItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AudioItemStruct &&
        arabicText == other.arabicText &&
        transliteration == other.transliteration &&
        audioUrl == other.audioUrl &&
        surahId == other.surahId &&
        verseId == other.verseId &&
        positionId == other.positionId;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [arabicText, transliteration, audioUrl, surahId, verseId, positionId]);
}

AudioItemStruct createAudioItemStruct({
  String? arabicText,
  String? transliteration,
  String? audioUrl,
  String? surahId,
  String? verseId,
  String? positionId,
}) =>
    AudioItemStruct(
      arabicText: arabicText,
      transliteration: transliteration,
      audioUrl: audioUrl,
      surahId: surahId,
      verseId: verseId,
      positionId: positionId,
    );
