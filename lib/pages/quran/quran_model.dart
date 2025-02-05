import '/flutter_flow/flutter_flow_util.dart';
import 'quran_widget.dart' show QuranWidget;
import 'package:flutter/material.dart';

class QuranModel extends FlutterFlowModel<QuranWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for surah_search widget.
  FocusNode? surahSearchFocusNode;
  TextEditingController? surahSearchTextController;
  String? Function(BuildContext, String?)? surahSearchTextControllerValidator;
  // State field(s) for verse_number widget.
  FocusNode? verseNumberFocusNode;
  TextEditingController? verseNumberTextController;
  String? Function(BuildContext, String?)? verseNumberTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    surahSearchFocusNode?.dispose();
    surahSearchTextController?.dispose();

    verseNumberFocusNode?.dispose();
    verseNumberTextController?.dispose();
  }
}
