import '/backend/sqlite/sqlite_manager.dart';
import '/components/quran_verses_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'quranic_salat_model.dart';
export 'quranic_salat_model.dart';

class QuranicSalatWidget extends StatefulWidget {
  const QuranicSalatWidget({super.key});

  static String routeName = 'quranicSalat';
  static String routePath = '/quranicSalat';

  @override
  State<QuranicSalatWidget> createState() => _QuranicSalatWidgetState();
}

class _QuranicSalatWidgetState extends State<QuranicSalatWidget> {
  late QuranicSalatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuranicSalatModel());

    _model.expandableExpandableController1 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController2 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController3 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController4 =
        ExpandableController(initialExpanded: false);
    _model.expandableExpandableController5 =
        ExpandableController(initialExpanded: false);
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
          title: Text(
            'QURANIC SALAT',
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
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 18.0, 12.0, 0.0),
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                0,
                0,
                0,
                30.0,
              ),
              scrollDirection: Axis.vertical,
              children: [
                ExpandableNotifier(
                  controller: _model.expandableExpandableController1,
                  child: ExpandablePanel(
                    header: Text(
                      'TIMES',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleLargeFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleLargeFamily),
                          ),
                    ),
                    collapsed: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'show more',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                      ],
                    ),
                    expanded: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'SALAT FAJR (DAWN)',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFFF4AF0F),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        FutureBuilder<List<GetVersesFromListRow>>(
                          future: SQLiteManager.instance.getVersesFromList(
                            verses: (List<String> verses) {
                              return verses.map((item) => "'$item'").join(", ");
                            }(FFAppConstants.salatFajrVerses.toList()),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final listViewGetVersesFromListRowList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewGetVersesFromListRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGetVersesFromListRow =
                                    listViewGetVersesFromListRowList[
                                        listViewIndex];
                                return wrapWithModel(
                                  model: _model.quranVersesModels1.getModel(
                                    '${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}',
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: QuranVersesWidget(
                                    key: Key(
                                      'Key7ec_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
                                    ),
                                    suraId:
                                        listViewGetVersesFromListRow.surahId,
                                    verseId:
                                        listViewGetVersesFromListRow.verseId,
                                    translation: listViewGetVersesFromListRow
                                        .verseTranslation,
                                    showDivider: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'SALAT WUSTAA (MIDDLE)',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFFF4AF0F),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        FutureBuilder<List<GetVersesFromListRow>>(
                          future: SQLiteManager.instance.getVersesFromList(
                            verses: (List<String> verses) {
                              return verses.map((item) => "'$item'").join(", ");
                            }(FFAppConstants.salatWustaVerses.toList()),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final listViewGetVersesFromListRowList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewGetVersesFromListRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGetVersesFromListRow =
                                    listViewGetVersesFromListRowList[
                                        listViewIndex];
                                return wrapWithModel(
                                  model: _model.quranVersesModels2.getModel(
                                    '${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}',
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: QuranVersesWidget(
                                    key: Key(
                                      'Keyozv_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
                                    ),
                                    suraId:
                                        listViewGetVersesFromListRow.surahId,
                                    verseId:
                                        listViewGetVersesFromListRow.verseId,
                                    translation: listViewGetVersesFromListRow
                                        .verseTranslation,
                                    showDivider: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'SALAT ISHA (NIGHT)',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFFF4AF0F),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        FutureBuilder<List<GetVersesFromListRow>>(
                          future: SQLiteManager.instance.getVersesFromList(
                            verses: (List<String> verses) {
                              return verses.map((item) => "'$item'").join(", ");
                            }(FFAppConstants.salatIshaVerses.toList()),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final listViewGetVersesFromListRowList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewGetVersesFromListRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGetVersesFromListRow =
                                    listViewGetVersesFromListRowList[
                                        listViewIndex];
                                return wrapWithModel(
                                  model: _model.quranVersesModels3.getModel(
                                    '${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}',
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: QuranVersesWidget(
                                    key: Key(
                                      'Key53g_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
                                    ),
                                    suraId:
                                        listViewGetVersesFromListRow.surahId,
                                    verseId:
                                        listViewGetVersesFromListRow.verseId,
                                    translation: listViewGetVersesFromListRow
                                        .verseTranslation,
                                    showDivider: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ]
                          .divide(SizedBox(height: 12.0))
                          .addToStart(SizedBox(height: 8.0))
                          .addToEnd(SizedBox(height: 8.0)),
                    ),
                    theme: ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      hasIcon: true,
                      iconColor: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                ),
                ExpandableNotifier(
                  controller: _model.expandableExpandableController2,
                  child: ExpandablePanel(
                    header: Text(
                      'BEFORE SALAT',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleLargeFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleLargeFamily),
                          ),
                    ),
                    collapsed: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'show more',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                      ],
                    ),
                    expanded: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'ABLUTION',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFFF4AF0F),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        FutureBuilder<List<GetVersesFromListRow>>(
                          future: SQLiteManager.instance.getVersesFromList(
                            verses: (List<String> verses) {
                              return verses.map((item) => "'$item'").join(", ");
                            }(FFAppConstants.ablutionVerses.toList()),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final listViewGetVersesFromListRowList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewGetVersesFromListRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGetVersesFromListRow =
                                    listViewGetVersesFromListRowList[
                                        listViewIndex];
                                return wrapWithModel(
                                  model: _model.quranVersesModels4.getModel(
                                    '${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}',
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: QuranVersesWidget(
                                    key: Key(
                                      'Keyxuc_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
                                    ),
                                    suraId:
                                        listViewGetVersesFromListRow.surahId,
                                    verseId:
                                        listViewGetVersesFromListRow.verseId,
                                    translation: listViewGetVersesFromListRow
                                        .verseTranslation,
                                    showDivider: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'FACE QIBLA',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFFF4AF0F),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        FutureBuilder<List<GetVersesFromListRow>>(
                          future: SQLiteManager.instance.getVersesFromList(
                            verses: (List<String> verses) {
                              return verses.map((item) => "'$item'").join(", ");
                            }(FFAppConstants.faceQiblaVerses.toList()),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final listViewGetVersesFromListRowList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewGetVersesFromListRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGetVersesFromListRow =
                                    listViewGetVersesFromListRowList[
                                        listViewIndex];
                                return wrapWithModel(
                                  model: _model.quranVersesModels5.getModel(
                                    '${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}',
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: QuranVersesWidget(
                                    key: Key(
                                      'Key2eg_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
                                    ),
                                    suraId:
                                        listViewGetVersesFromListRow.surahId,
                                    verseId:
                                        listViewGetVersesFromListRow.verseId,
                                    translation: listViewGetVersesFromListRow
                                        .verseTranslation,
                                    showDivider: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'STAND HUMBLY BEFORE GOD',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFFF4AF0F),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        FutureBuilder<List<GetVersesFromListRow>>(
                          future: SQLiteManager.instance.getVersesFromList(
                            verses: (List<String> verses) {
                              return verses.map((item) => "'$item'").join(", ");
                            }(FFAppConstants.humbleVerses.toList()),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final listViewGetVersesFromListRowList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewGetVersesFromListRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGetVersesFromListRow =
                                    listViewGetVersesFromListRowList[
                                        listViewIndex];
                                return wrapWithModel(
                                  model: _model.quranVersesModels6.getModel(
                                    '${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}',
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: QuranVersesWidget(
                                    key: Key(
                                      'Key5gq_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
                                    ),
                                    suraId:
                                        listViewGetVersesFromListRow.surahId,
                                    verseId:
                                        listViewGetVersesFromListRow.verseId,
                                    translation: listViewGetVersesFromListRow
                                        .verseTranslation,
                                    showDivider: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'DON\'T APPROACH SALAT LAZILY',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFFF4AF0F),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        FutureBuilder<List<GetVersesFromListRow>>(
                          future: SQLiteManager.instance.getVersesFromList(
                            verses: (List<String> verses) {
                              return verses.map((item) => "'$item'").join(", ");
                            }(FFAppConstants.lazilyVerses.toList()),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final listViewGetVersesFromListRowList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewGetVersesFromListRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGetVersesFromListRow =
                                    listViewGetVersesFromListRowList[
                                        listViewIndex];
                                return wrapWithModel(
                                  model: _model.quranVersesModels7.getModel(
                                    '${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}',
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: QuranVersesWidget(
                                    key: Key(
                                      'Keygps_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
                                    ),
                                    suraId:
                                        listViewGetVersesFromListRow.surahId,
                                    verseId:
                                        listViewGetVersesFromListRow.verseId,
                                    translation: listViewGetVersesFromListRow
                                        .verseTranslation,
                                    showDivider: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'TAKE REFUGE IN GOD',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFFF4AF0F),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        FutureBuilder<List<GetVersesFromListRow>>(
                          future: SQLiteManager.instance.getVersesFromList(
                            verses: (List<String> verses) {
                              return verses.map((item) => "'$item'").join(", ");
                            }(FFAppConstants.takeRefugeVerses.toList()),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final listViewGetVersesFromListRowList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewGetVersesFromListRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGetVersesFromListRow =
                                    listViewGetVersesFromListRowList[
                                        listViewIndex];
                                return wrapWithModel(
                                  model: _model.quranVersesModels8.getModel(
                                    '${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}',
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: QuranVersesWidget(
                                    key: Key(
                                      'Key72k_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
                                    ),
                                    suraId:
                                        listViewGetVersesFromListRow.surahId,
                                    verseId:
                                        listViewGetVersesFromListRow.verseId,
                                    translation: listViewGetVersesFromListRow
                                        .verseTranslation,
                                    showDivider: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ]
                          .divide(SizedBox(height: 12.0))
                          .addToStart(SizedBox(height: 8.0))
                          .addToEnd(SizedBox(height: 8.0)),
                    ),
                    theme: ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      hasIcon: true,
                      iconColor: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                ),
                ExpandableNotifier(
                  controller: _model.expandableExpandableController3,
                  child: ExpandablePanel(
                    header: Text(
                      'BEGINNING SALAT',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleLargeFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleLargeFamily),
                          ),
                    ),
                    collapsed: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'show more',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                      ],
                    ),
                    expanded: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'CALL UPON GOD',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFFF4AF0F),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        FutureBuilder<List<GetVersesFromListRow>>(
                          future: SQLiteManager.instance.getVersesFromList(
                            verses: (List<String> verses) {
                              return verses.map((item) => "'$item'").join(", ");
                            }(FFAppConstants.callUponGodVerses.toList()),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final listViewGetVersesFromListRowList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewGetVersesFromListRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGetVersesFromListRow =
                                    listViewGetVersesFromListRowList[
                                        listViewIndex];
                                return wrapWithModel(
                                  model: _model.quranVersesModels9.getModel(
                                    '${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}',
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: QuranVersesWidget(
                                    key: Key(
                                      'Key8io_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
                                    ),
                                    suraId:
                                        listViewGetVersesFromListRow.surahId,
                                    verseId:
                                        listViewGetVersesFromListRow.verseId,
                                    translation: listViewGetVersesFromListRow
                                        .verseTranslation,
                                    showDivider: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'EXAMPLE',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFFF4AF0F),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        FutureBuilder<List<GetVersesFromListRow>>(
                          future: SQLiteManager.instance.getVersesFromList(
                            verses: (List<String> verses) {
                              return verses.map((item) => "'$item'").join(", ");
                            }(FFAppConstants.exampleCallUponGod.toList()),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final listViewGetVersesFromListRowList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewGetVersesFromListRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGetVersesFromListRow =
                                    listViewGetVersesFromListRowList[
                                        listViewIndex];
                                return wrapWithModel(
                                  model: _model.quranVersesModels10.getModel(
                                    '${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}',
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: QuranVersesWidget(
                                    key: Key(
                                      'Keyrfc_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
                                    ),
                                    suraId:
                                        listViewGetVersesFromListRow.surahId,
                                    verseId:
                                        listViewGetVersesFromListRow.verseId,
                                    translation: listViewGetVersesFromListRow
                                        .verseTranslation,
                                    showDivider: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ]
                          .divide(SizedBox(height: 12.0))
                          .addToStart(SizedBox(height: 8.0))
                          .addToEnd(SizedBox(height: 8.0)),
                    ),
                    theme: ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      hasIcon: true,
                      iconColor: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                ),
                ExpandableNotifier(
                  controller: _model.expandableExpandableController4,
                  child: ExpandablePanel(
                    header: Text(
                      'DURING SALAT',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleLargeFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleLargeFamily),
                          ),
                    ),
                    collapsed: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'show more',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                      ],
                    ),
                    expanded: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'COMMEMORATE GOD ALONE',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFFF4AF0F),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        FutureBuilder<List<GetVersesFromListRow>>(
                          future: SQLiteManager.instance.getVersesFromList(
                            verses: (List<String> verses) {
                              return verses.map((item) => "'$item'").join(", ");
                            }(FFAppConstants.commemorateGodVerses.toList()),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final listViewGetVersesFromListRowList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewGetVersesFromListRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGetVersesFromListRow =
                                    listViewGetVersesFromListRowList[
                                        listViewIndex];
                                return wrapWithModel(
                                  model: _model.quranVersesModels11.getModel(
                                    '${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}',
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: QuranVersesWidget(
                                    key: Key(
                                      'Key2cv_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
                                    ),
                                    suraId:
                                        listViewGetVersesFromListRow.surahId,
                                    verseId:
                                        listViewGetVersesFromListRow.verseId,
                                    translation: listViewGetVersesFromListRow
                                        .verseTranslation,
                                    showDivider: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'STAND, BOW & PROSTRARE',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFFF4AF0F),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        FutureBuilder<List<GetVersesFromListRow>>(
                          future: SQLiteManager.instance.getVersesFromList(
                            verses: (List<String> verses) {
                              return verses.map((item) => "'$item'").join(", ");
                            }(FFAppConstants.standBowProstrateVerses.toList()),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final listViewGetVersesFromListRowList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewGetVersesFromListRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGetVersesFromListRow =
                                    listViewGetVersesFromListRowList[
                                        listViewIndex];
                                return wrapWithModel(
                                  model: _model.quranVersesModels12.getModel(
                                    '${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}',
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: QuranVersesWidget(
                                    key: Key(
                                      'Keym8l_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
                                    ),
                                    suraId:
                                        listViewGetVersesFromListRow.surahId,
                                    verseId:
                                        listViewGetVersesFromListRow.verseId,
                                    translation: listViewGetVersesFromListRow
                                        .verseTranslation,
                                    showDivider: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'EXAMPLE COMMEMORATION VERSES',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xFFF4AF0F),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        FutureBuilder<List<GetVersesFromListRow>>(
                          future: SQLiteManager.instance.getVersesFromList(
                            verses: (List<String> verses) {
                              return verses.map((item) => "'$item'").join(", ");
                            }(FFAppConstants.exampleCommemorateGodVerses
                                .toList()),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final listViewGetVersesFromListRowList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewGetVersesFromListRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGetVersesFromListRow =
                                    listViewGetVersesFromListRowList[
                                        listViewIndex];
                                return wrapWithModel(
                                  model: _model.quranVersesModels13.getModel(
                                    '${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}',
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: QuranVersesWidget(
                                    key: Key(
                                      'Keyh48_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
                                    ),
                                    suraId:
                                        listViewGetVersesFromListRow.surahId,
                                    verseId:
                                        listViewGetVersesFromListRow.verseId,
                                    translation: listViewGetVersesFromListRow
                                        .verseTranslation,
                                    showDivider: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ]
                          .divide(SizedBox(height: 12.0))
                          .addToStart(SizedBox(height: 8.0))
                          .addToEnd(SizedBox(height: 8.0)),
                    ),
                    theme: ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      hasIcon: true,
                      iconColor: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                ),
                ExpandableNotifier(
                  controller: _model.expandableExpandableController5,
                  child: ExpandablePanel(
                    header: Text(
                      'END SALAT',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleLargeFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleLargeFamily),
                          ),
                    ),
                    collapsed: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'show more',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                      ],
                    ),
                    expanded: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<List<GetVersesFromListRow>>(
                          future: SQLiteManager.instance.getVersesFromList(
                            verses: (List<String> verses) {
                              return verses.map((item) => "'$item'").join(", ");
                            }(FFAppConstants.endSalat.toList()),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            final listViewGetVersesFromListRowList =
                                snapshot.data!;

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewGetVersesFromListRowList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGetVersesFromListRow =
                                    listViewGetVersesFromListRowList[
                                        listViewIndex];
                                return wrapWithModel(
                                  model: _model.quranVersesModels14.getModel(
                                    '${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}',
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: QuranVersesWidget(
                                    key: Key(
                                      'Keyir4_${'${listViewGetVersesFromListRow.surahId.toString()}${listViewGetVersesFromListRow.verseId.toString()}'}',
                                    ),
                                    suraId:
                                        listViewGetVersesFromListRow.surahId,
                                    verseId:
                                        listViewGetVersesFromListRow.verseId,
                                    translation: listViewGetVersesFromListRow
                                        .verseTranslation,
                                    showDivider: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ]
                          .divide(SizedBox(height: 12.0))
                          .addToStart(SizedBox(height: 8.0))
                          .addToEnd(SizedBox(height: 8.0)),
                    ),
                    theme: ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      hasIcon: true,
                      iconColor: FlutterFlowTheme.of(context).secondaryText,
                    ),
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
