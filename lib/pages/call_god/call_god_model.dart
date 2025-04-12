import '/components/quran_verses_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'call_god_widget.dart' show CallGodWidget;
import 'package:flutter/material.dart';

class CallGodModel extends FlutterFlowModel<CallGodWidget> {
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
