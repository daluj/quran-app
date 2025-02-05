import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'verse_menu_widget.dart' show VerseMenuWidget;
import 'package:flutter/material.dart';

class VerseMenuModel extends FlutterFlowModel<VerseMenuWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - SQLite (getJournals)] action in Row widget.
  List<GetJournalsRow>? journals;
  // Stores action output result for [Backend Call - SQLite (getCollectionsByType)] action in Row widget.
  List<GetCollectionsByTypeRow>? collections;
  // Stores action output result for [Backend Call - SQLite (getCollectionsByType)] action in Row widget.
  List<GetCollectionsByTypeRow>? duas;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
