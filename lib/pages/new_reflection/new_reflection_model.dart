import '/flutter_flow/flutter_flow_util.dart';
import 'new_reflection_widget.dart' show NewReflectionWidget;
import 'package:flutter/material.dart';

class NewReflectionModel extends FlutterFlowModel<NewReflectionWidget> {
  ///  Local state fields for this page.

  bool showSave = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for title widget.
  FocusNode? titleFocusNode;
  TextEditingController? titleTextController;
  String? Function(BuildContext, String?)? titleTextControllerValidator;
  // State field(s) for reflections widget.
  FocusNode? reflectionsFocusNode;
  TextEditingController? reflectionsTextController;
  String? Function(BuildContext, String?)? reflectionsTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    titleFocusNode?.dispose();
    titleTextController?.dispose();

    reflectionsFocusNode?.dispose();
    reflectionsTextController?.dispose();
  }
}
