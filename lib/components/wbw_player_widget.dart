import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'wbw_player_model.dart';
export 'wbw_player_model.dart';

class WbwPlayerWidget extends StatefulWidget {
  const WbwPlayerWidget({
    super.key,
    this.audioUrl,
  });

  final String? audioUrl;

  @override
  State<WbwPlayerWidget> createState() => _WbwPlayerWidgetState();
}

class _WbwPlayerWidgetState extends State<WbwPlayerWidget> {
  late WbwPlayerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WbwPlayerModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).alternate,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: custom_widgets.AudioWidget(
                width: double.infinity,
                height: double.infinity,
                audioUrl: widget.audioUrl,
                primaryColor: FlutterFlowTheme.of(context).secondaryText,
                secondaryColor: FlutterFlowTheme.of(context).secondary,
                errorMessage: 'Audio not found',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
