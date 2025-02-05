import '/flutter_flow/flutter_flow_util.dart';
import 'glossary_widget.dart' show GlossaryWidget;
import 'package:flutter/material.dart';

class GlossaryModel extends FlutterFlowModel<GlossaryWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for glossary_search widget.
  FocusNode? glossarySearchFocusNode;
  TextEditingController? glossarySearchTextController;
  String? Function(BuildContext, String?)?
      glossarySearchTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    glossarySearchFocusNode?.dispose();
    glossarySearchTextController?.dispose();
  }
}
