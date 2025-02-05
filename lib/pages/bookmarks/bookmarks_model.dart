import '/components/quran_verses_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bookmarks_widget.dart' show BookmarksWidget;
import 'package:flutter/material.dart';

class BookmarksModel extends FlutterFlowModel<BookmarksWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for QuranVerses dynamic component.
  late FlutterFlowDynamicModels<QuranVersesModel> quranVersesModels;

  @override
  void initState(BuildContext context) {
    quranVersesModels = FlutterFlowDynamicModels(() => QuranVersesModel());
  }

  @override
  void dispose() {
    quranVersesModels.dispose();
  }
}
