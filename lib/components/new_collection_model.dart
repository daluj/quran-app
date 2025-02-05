import '/flutter_flow/flutter_flow_util.dart';
import 'new_collection_widget.dart' show NewCollectionWidget;
import 'package:flutter/material.dart';

class NewCollectionModel extends FlutterFlowModel<NewCollectionWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for title widget.
  FocusNode? titleFocusNode;
  TextEditingController? titleTextController;
  String? Function(BuildContext, String?)? titleTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    titleFocusNode?.dispose();
    titleTextController?.dispose();
  }
}
