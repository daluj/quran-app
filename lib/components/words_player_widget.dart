import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'words_player_model.dart';
export 'words_player_model.dart';

class WordsPlayerWidget extends StatefulWidget {
  const WordsPlayerWidget({
    super.key,
    this.audioList,
  });

  final List<AudioItemStruct>? audioList;

  @override
  State<WordsPlayerWidget> createState() => _WordsPlayerWidgetState();
}

class _WordsPlayerWidgetState extends State<WordsPlayerWidget> {
  late WordsPlayerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WordsPlayerModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: custom_widgets.WordsAudioWidget(
        width: double.infinity,
        height: double.infinity,
        primaryColor: FlutterFlowTheme.of(context).secondaryText,
        secondaryColor: FlutterFlowTheme.of(context).accent2,
        errorMessage: 'Audio not found',
        audioList: widget.audioList!,
        arabicFontSize: FFAppState().arabFontSize.toDouble(),
        arabicFontFamily: 'Uthman',
        transliterationFontSize:
            FFAppState().transliterationFontSize.toDouble(),
        transliterationFontFamily: 'GFS Didot',
      ),
    );
  }
}
