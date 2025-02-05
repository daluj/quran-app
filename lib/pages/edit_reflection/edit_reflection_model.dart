import '/components/quran_verses_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'edit_reflection_widget.dart' show EditReflectionWidget;
import 'package:flutter/material.dart';

class EditReflectionModel extends FlutterFlowModel<EditReflectionWidget> {
  ///  Local state fields for this page.

  bool showSave = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for reflections widget.
  FocusNode? reflectionsFocusNode;
  TextEditingController? reflectionsTextController;
  String? Function(BuildContext, String?)? reflectionsTextControllerValidator;
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
    reflectionsFocusNode?.dispose();
    reflectionsTextController?.dispose();

    quranVersesModels.dispose();
    titleFocusNode?.dispose();
    titleTextController?.dispose();
  }
}
