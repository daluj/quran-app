import '/flutter_flow/flutter_flow_util.dart';
import 'verse_comments_widget.dart' show VerseCommentsWidget;
import 'package:flutter/material.dart';

class VerseCommentsModel extends FlutterFlowModel<VerseCommentsWidget> {
  ///  Local state fields for this page.

  bool showSave = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for comment widget.
  FocusNode? commentFocusNode;
  TextEditingController? commentTextController;
  String? Function(BuildContext, String?)? commentTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    commentFocusNode?.dispose();
    commentTextController?.dispose();
  }
}
