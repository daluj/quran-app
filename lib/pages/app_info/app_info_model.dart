import '/flutter_flow/flutter_flow_util.dart';
import 'app_info_widget.dart' show AppInfoWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class AppInfoModel extends FlutterFlowModel<AppInfoWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController1;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    expandableExpandableController1.dispose();
    expandableExpandableController2.dispose();
  }
}
