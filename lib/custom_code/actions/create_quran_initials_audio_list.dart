// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<AudioItemStruct>> createQuranInitialsAudioList(
    List<QuranInitialStruct> quranInitials) async {
  // Add your function code here!
  final String? wbwAudioUrl = FFAppConstants.wbwAudioUrl;

  if (wbwAudioUrl == null || wbwAudioUrl.isEmpty) {
    throw Exception('wbwAudioUrl Project Constant is not defined.');
  }

  List<AudioItemStruct> audioList = [];

  for (var initial in quranInitials) {
    final int? surahId = initial.surahId;
    final int? verseId = initial.verseId;
    final int? positionId = initial.positionId;

    if (surahId == null || verseId == null || positionId == null) {
      continue;
    }

    // Query SQLite for the specific word entry
    final db = await SQLiteManager.instance.database;

    final rows = await db.rawQuery(
      '''
  SELECT surah_id, verse_id, position_id, ar, transliteration
  FROM words
  WHERE surah_id = ? AND verse_id = ? AND position_id = ?
  ''',
      [surahId, verseId, positionId],
    );

    if (rows.isEmpty) continue;

    final row = rows.first;
    final String? arabicText = row['ar'] as String?;
    final String? transliteration = row['transliteration'] as String?;

    if (arabicText != null && transliteration != null) {
      final String audioUrl = wbwAudioUrl
          .replaceAll("\${surah_id}", surahId.toString())
          .replaceAll("\${surah_id0}", surahId.toString().padLeft(3, '0'))
          .replaceAll("\${verse_id}", verseId.toString().padLeft(3, '0'))
          .replaceAll("\${position_id}", positionId.toString().padLeft(3, '0'));

      audioList.add(AudioItemStruct(
        audioUrl: audioUrl,
        arabicText: arabicText,
        transliteration: transliteration,
        surahId: surahId.toString(),
        verseId: verseId.toString(),
        positionId: positionId.toString(),
      ));
    }
  }

  return audioList;
}
