import '/flutter_flow/flutter_flow_util.dart';
import 'comment_entry_widget.dart' show CommentEntryWidget;
import 'package:flutter/material.dart';

class CommentEntryModel extends FlutterFlowModel<CommentEntryWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();
  }
}
