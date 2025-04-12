import '/backend/sqlite/sqlite_manager.dart';
import '/components/quran_verses_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'beautiful_names_model.dart';
export 'beautiful_names_model.dart';

class BeautifulNamesWidget extends StatefulWidget {
  const BeautifulNamesWidget({super.key});

  static String routeName = 'beautifulNames';
  static String routePath = '/beautifulNames';

  @override
  State<BeautifulNamesWidget> createState() => _BeautifulNamesWidgetState();
}

class _BeautifulNamesWidgetState extends State<BeautifulNamesWidget> {
  late BeautifulNamesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BeautifulNamesModel());
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
            'BEAUTIFUL NAMES',
            style: FlutterFlowTheme.of(context).headlineSmall.override(
                  fontFamily: FlutterFlowTheme.of(context).headlineSmallFamily,
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 20.0,
                  letterSpacing: 0.0,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).headlineSmallFamily),
                ),
          ),
          actions: [
            FlutterFlowIconButton(
              borderRadius: 8.0,
              buttonSize: 60.0,
              icon: FaIcon(
                FontAwesomeIcons.quran,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24.0,
              ),
              onPressed: () async {
                if (_model.showInfo) {
                  _model.showInfo = false;
                  safeSetState(() {});
                } else {
                  _model.showInfo = true;
                  safeSetState(() {});
                }
              },
            ),
          ],
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (_model.showInfo)
                  FutureBuilder<List<GetVersesFromListRow>>(
                    future: SQLiteManager.instance.getVersesFromList(
                      translationCode: 'en',
                      verses: (List<String> verses) {
                        return verses.map((item) => "'$item'").join(", ");
                      }(FFAppConstants.beautifulNamesVerses.toList()),
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
                      final carouselGetVersesFromListRowList = snapshot.data!;

                      return Container(
                        width: double.infinity,
                        height: 150.0,
                        child: CarouselSlider.builder(
                          itemCount: carouselGetVersesFromListRowList.length,
                          itemBuilder: (context, carouselIndex, _) {
                            final carouselGetVersesFromListRow =
                                carouselGetVersesFromListRowList[carouselIndex];
                            return wrapWithModel(
                              model: _model.quranVersesModels.getModel(
                                '${carouselGetVersesFromListRow.surahId.toString()}${carouselGetVersesFromListRow.verseId.toString()}',
                                carouselIndex,
                              ),
                              updateCallback: () => safeSetState(() {}),
                              child: QuranVersesWidget(
                                key: Key(
                                  'Keycb2_${'${carouselGetVersesFromListRow.surahId.toString()}${carouselGetVersesFromListRow.verseId.toString()}'}',
                                ),
                                suraId: carouselGetVersesFromListRow.surahId,
                                verseId: carouselGetVersesFromListRow.verseId,
                                translation: carouselGetVersesFromListRow
                                    .verseTranslation,
                                showDivider: false,
                              ),
                            );
                          },
                          carouselController: _model.carouselController ??=
                              CarouselSliderController(),
                          options: CarouselOptions(
                            initialPage: max(
                                0,
                                min(
                                    0,
                                    carouselGetVersesFromListRowList.length -
                                        1)),
                            viewportFraction: 0.8,
                            disableCenter: true,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.2,
                            enableInfiniteScroll: false,
                            scrollDirection: Axis.horizontal,
                            autoPlay: false,
                            onPageChanged: (index, _) =>
                                _model.carouselCurrentIndex = index,
                          ),
                        ),
                      );
                    },
                  ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                  child: FutureBuilder<List<GetNamesByTypeRow>>(
                    future: SQLiteManager.instance.getNamesByType(
                      type: 'beautiful_names',
                      languageCode: 'en',
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
                      final listViewGetNamesByTypeRowList = snapshot.data!;

                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewGetNamesByTypeRowList.length,
                        separatorBuilder: (_, __) => SizedBox(height: 18.0),
                        itemBuilder: (context, listViewIndex) {
                          final listViewGetNamesByTypeRow =
                              listViewGetNamesByTypeRowList[listViewIndex];
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                QuranWidget.routeName,
                                queryParameters: {
                                  'surahId': serializeParam(
                                    (String verses) {
                                      return int.parse(verses.split(':')[0]);
                                    }(listViewGetNamesByTypeRow.verses),
                                    ParamType.int,
                                  ),
                                  'verseId': serializeParam(
                                    (String verses) {
                                      return int.parse(verses.split(':')[1]);
                                    }(listViewGetNamesByTypeRow.verses),
                                    ParamType.int,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 12.0, 12.0, 12.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Text(
                                              listViewGetNamesByTypeRow
                                                  .transliteration,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmallFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallFamily),
                                                      ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Text(
                                              listViewGetNamesByTypeRow
                                                  .translation,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmallFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmallFamily),
                                                      ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Flexible(
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: RichText(
                                                    textScaler:
                                                        MediaQuery.of(context)
                                                            .textScaler,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Reference: ',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily),
                                                              ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              listViewGetNamesByTypeRow
                                                                  .verses,
                                                          style: TextStyle(),
                                                        )
                                                      ],
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily),
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ].divide(SizedBox(height: 6.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ].divide(SizedBox(height: 18.0)).addToEnd(SizedBox(height: 18.0)),
            ),
          ),
        ),
      ),
    );
  }
}
