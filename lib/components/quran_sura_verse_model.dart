import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'quran_sura_verse_widget.dart' show QuranSuraVerseWidget;
import 'package:flutter/material.dart';

class QuranSuraVerseModel extends FlutterFlowModel<QuranSuraVerseWidget> {
  ///  Local state fields for this component.

  bool hasBookMark = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - SQLite (getWords)] action in Container widget.
  List<GetWordsRow>? words;
  // Stores action output result for [Custom Action - createAudioList] action in Container widget.
  List<AudioItemStruct>? audioList;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
