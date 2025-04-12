import '/backend/schema/structs/index.dart';
import '/components/profile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'explore_widget.dart' show ExploreWidget;
import 'package:flutter/material.dart';

class ExploreModel extends FlutterFlowModel<ExploreWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - createQuranInitialsAudioList] action in Container widget.
  List<AudioItemStruct>? audioList;
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
