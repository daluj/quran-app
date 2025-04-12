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

Future<List<AudioItemStruct>> createAudioList(List<GetWordsRow> sqlRows) async {
  // Add your function code here!
  // Access the Project Constant 'wbwAudioUrl' from FFAppState
  final String? wbwAudioUrl = FFAppConstants.wbwAudioUrl;

  // Ensure the Project Constant is not null
  if (wbwAudioUrl == null || wbwAudioUrl.isEmpty) {
    throw Exception('wbwAudioUrl Project Constant is not defined.');
  }

  // Initialize an empty list to store AudioItemStruct objects
  List<AudioItemStruct> audioList = [];

  // Loop through each SQLite row
  for (var row in sqlRows) {
    // Extract values from the row
    final int? surahId = row.surahId; // Replace with your actual field name
    final int? verseId = row.verseId; // Replace with your actual field name
    final int? positionId =
        row.positionId; // Replace with your actual field name
    final String? arabicText = row.ar; // Replace with your actual field name
    final String? transliteration =
        row.transliteration; // Replace with your actual field name

    // Ensure all required fields are non-null
    if (surahId != null &&
        verseId != null &&
        positionId != null &&
        arabicText != null &&
        transliteration != null) {
      // Build the audioUrl
      final String audioUrl = wbwAudioUrl
          .replaceAll("\${surah_id}", surahId.toString())
          .replaceAll("\${surah_id0}", surahId.toString().padLeft(3, '0'))
          .replaceAll("\${verse_id}", verseId.toString().padLeft(3, '0'))
          .replaceAll("\${position_id}", positionId.toString().padLeft(3, '0'));

      // Create an AudioItemStruct and add it to the list
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

  // Return the populated list of AudioItemStruct objects
  return audioList;
}
