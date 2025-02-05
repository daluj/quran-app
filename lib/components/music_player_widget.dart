import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'music_player_model.dart';
export 'music_player_model.dart';

class MusicPlayerWidget extends StatefulWidget {
  const MusicPlayerWidget({
    super.key,
    required this.surahId,
    int? verseId,
    this.audioUrl,
  }) : verseId = verseId ?? 0;

  final int? surahId;
  final int verseId;
  final String? audioUrl;

  @override
  State<MusicPlayerWidget> createState() => _MusicPlayerWidgetState();
}

class _MusicPlayerWidgetState extends State<MusicPlayerWidget> {
  late MusicPlayerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MusicPlayerModel());
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
                audioUrl: () {
                  if (widget.verseId > 0) {
                    return 'https://everyayah.com/data/AbdulSamad_64kbps_QuranExplorer.Com/${(int surahId) {
                      return surahId.toString().padLeft(3, '0');
                    }(widget.surahId!)}${(int verseId) {
                      return verseId.toString().padLeft(3, '0');
                    }(widget.verseId)}.mp3';
                  } else if (widget.audioUrl != null &&
                      widget.audioUrl != '') {
                    return widget.audioUrl;
                  } else {
                    return (String audioUrl, String surahId) {
                      return audioUrl.replaceAll(
                          "\${surah_id}", surahId.toString().padLeft(3, '0'));
                    }(FFAppState().reciterUrl, widget.surahId!.toString());
                  }
                }(),
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
