import '/components/quran_verses_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'edit_collection_widget.dart' show EditCollectionWidget;
import 'package:flutter/material.dart';

class EditCollectionModel extends FlutterFlowModel<EditCollectionWidget> {
  ///  Local state fields for this page.

  bool showSave = false;

  ///  State fields for stateful widgets in this page.

  // Models for QuranVerses dynamic component.
  late FlutterFlowDynamicModels<QuranVersesModel> quranVersesModels;
  // State field(s) for title widget.
  FocusNode? titleFocusNode;
  TextEditingController? titleTextController;
  String? Function(BuildContext, String?)? titleTextControllerValidator;

  @override
  void initState(BuildContext context) {
    quranVersesModels = FlutterFlowDynamicModels(() => QuranVersesModel());
  }

  @override
  void dispose() {
    quranVersesModels.dispose();
    titleFocusNode?.dispose();
    titleTextController?.dispose();
  }
}
