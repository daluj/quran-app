import '/backend/sqlite/sqlite_manager.dart';
import '/components/profile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  double? progress = 0.0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - SQLite (getCollectionsByType)] action in Container widget.
  List<GetCollectionsByTypeRow>? introCollection;
  // Model for profileComponent component.
  late ProfileComponentModel profileComponentModel;

  @override
  void initState(BuildContext context) {
    profileComponentModel = createModel(context, () => ProfileComponentModel());
  }

  @override
  void dispose() {
    profileComponentModel.dispose();
  }
}
