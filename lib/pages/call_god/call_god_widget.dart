import '/backend/sqlite/sqlite_manager.dart';
import '/components/quran_verses_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'call_god_model.dart';
export 'call_god_model.dart';

class CallGodWidget extends StatefulWidget {
  const CallGodWidget({super.key});

  static String routeName = 'callGod';
  static String routePath = '/callGod';

  @override
  State<CallGodWidget> createState() => _CallGodWidgetState();
}

class _CallGodWidgetState extends State<CallGodWidget> {
  late CallGodModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CallGodModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 54.0,
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'HOW TO CALL GOD',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 20.0,
                  letterSpacing: 0.0,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).headlineMediumFamily),
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                FlutterFlowTheme.of(context).primary,
                FlutterFlowTheme.of(context).secondary
              ],
              stops: [0.0, 1.0],
              begin: AlignmentDirectional(0.0, -1.0),
              end: AlignmentDirectional(0, 1.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 18.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FutureBuilder<List<GetVersesFromListRow>>(
                    future: SQLiteManager.instance.getVersesFromList(
                      verses: (List<String> verses) {
                        return verses.map((item) => "'$item'").join(", ");
                      }(FFAppConstants.callGod.toList()),
                      translationCode: 'en',
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: SpinKitDoubleBounce(
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 50.0,
                            ),
                          ),
                        );
                      }
                      final listViewGetVersesFromListRowList = snapshot.data!;

                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewGetVersesFromListRowList.length,
                        separatorBuilder: (_, __) => SizedBox(height: 18.0),
                        itemBuilder: (context, listViewIndex) {
                          final listViewGetVersesFromListRow =
                              listViewGetVersesFromListRowList[listViewIndex];
                          return wrapWithModel(
                            model: _model.quranVersesModels.getModel(
                              '${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}',
                              listViewIndex,
                            ),
                            updateCallback: () => safeSetState(() {}),
                            child: QuranVersesWidget(
                              key: Key(
                                'Keyl8d_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
                              ),
                              suraId: listViewGetVersesFromListRow.surahId,
                              verseId: listViewGetVersesFromListRow.verseId,
                              translation:
                                  listViewGetVersesFromListRow.verseTranslation,
                              showDivider: true,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
