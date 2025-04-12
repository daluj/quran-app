import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'quran_verses_model.dart';
export 'quran_verses_model.dart';

class QuranVersesWidget extends StatefulWidget {
  const QuranVersesWidget({
    super.key,
    int? suraId,
    int? verseId,
    required this.translation,
    bool? showDivider,
  })  : this.suraId = suraId ?? 0,
        this.verseId = verseId ?? 0,
        this.showDivider = showDivider ?? true;

  final int suraId;
  final int verseId;
  final String? translation;
  final bool showDivider;

  @override
  State<QuranVersesWidget> createState() => _QuranVersesWidgetState();
}

class _QuranVersesWidgetState extends State<QuranVersesWidget> {
  late QuranVersesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuranVersesModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 9.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Surah ',
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).accent2,
                                ),
                              ),
                              TextSpan(
                                text: widget.suraId.toString(),
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).accent2,
                                ),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .headlineSmallFamily),
                                ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional(1.0, 0.0),
                        child: RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Verse ',
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).accent2,
                                ),
                              ),
                              TextSpan(
                                text: widget.verseId.toString(),
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).accent2,
                                ),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .headlineSmallFamily),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 9.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.pushNamed(
                      QuranWidget.routeName,
                      queryParameters: {
                        'surahId': serializeParam(
                          widget.suraId,
                          ParamType.int,
                        ),
                        'verseId': serializeParam(
                          widget.verseId,
                          ParamType.int,
                        ),
                      }.withoutNulls,
                    );
                  },
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 48.0,
                    ),
                    decoration: BoxDecoration(),
                    child: Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Text(
                          valueOrDefault<String>(
                            widget.translation,
                            '\"\"',
                          ),
                          textAlign: TextAlign.justify,
                          style: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                fontFamily: 'GFS Didot',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize:
                                    FFAppState().translationFontSize.toDouble(),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                                useGoogleFonts: GoogleFonts.asMap()
                                    .containsKey('GFS Didot'),
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.showDivider)
                Opacity(
                  opacity: 0.8,
                  child: Divider(
                    thickness: 0.5,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
            ].divide(SizedBox(height: 9.0)),
          ),
        ),
      ),
    );
  }
}
