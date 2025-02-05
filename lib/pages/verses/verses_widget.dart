import '/backend/sqlite/sqlite_manager.dart';
import '/components/quran_verses_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'verses_model.dart';
export 'verses_model.dart';

class VersesWidget extends StatefulWidget {
  const VersesWidget({
    super.key,
    required this.surahVersesList,
  });

  final List<String>? surahVersesList;

  @override
  State<VersesWidget> createState() => _VersesWidgetState();
}

class _VersesWidgetState extends State<VersesWidget> {
  late VersesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VersesModel());
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
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          actions: const [],
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
              stops: const [0.0, 1.0],
              begin: const AlignmentDirectional(0.0, -1.0),
              end: const AlignmentDirectional(0, 1.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 18.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FutureBuilder<List<GetVersesFromListRow>>(
                    future: SQLiteManager.instance.getVersesFromList(
                      verses: (List<String> verses) {
                        return verses.map((item) => "'$item'").join(", ");
                      }(widget.surahVersesList!.toList()),
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
                        separatorBuilder: (_, __) => const SizedBox(height: 18.0),
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
                                'Key85h_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
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
