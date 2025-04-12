import '/backend/schema/enums/enums.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/components/empty_results_widget.dart';
import '/components/goal_prayer_entry_widget.dart';
import '/components/quran_verses_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'goals_and_prayers_model.dart';
export 'goals_and_prayers_model.dart';

class GoalsAndPrayersWidget extends StatefulWidget {
  const GoalsAndPrayersWidget({super.key});

  static String routeName = 'goalsAndPrayers';
  static String routePath = '/goalsAndPrayers';

  @override
  State<GoalsAndPrayersWidget> createState() => _GoalsAndPrayersWidgetState();
}

class _GoalsAndPrayersWidgetState extends State<GoalsAndPrayersWidget> {
  late GoalsAndPrayersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GoalsAndPrayersModel());
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              enableDrag: false,
              context: context,
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.6,
                      child: GoalPrayerEntryWidget(),
                    ),
                  ),
                );
              },
            ).then((value) => safeSetState(() {}));
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 8.0,
          child: Icon(
            Icons.add_rounded,
            color: FlutterFlowTheme.of(context).info,
            size: 24.0,
          ),
        ),
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
                      }(FFAppConstants.goals.toList()),
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
                                  'Keyktq_${'${carouselGetVersesFromListRow.surahId.toString()}${carouselGetVersesFromListRow.verseId.toString()}'}',
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
                FlutterFlowChoiceChips(
                  options: GoalPrayer.values
                      .map((e) => e.name)
                      .toList()
                      .map((label) => ChipData(label))
                      .toList(),
                  onChanged: (val) => safeSetState(
                      () => _model.choiceChipsValue = val?.firstOrNull),
                  selectedChipStyle: ChipStyle(
                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                    iconColor: FlutterFlowTheme.of(context).info,
                    iconSize: 16.0,
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  unselectedChipStyle: ChipStyle(
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                    iconColor: FlutterFlowTheme.of(context).secondaryText,
                    iconSize: 16.0,
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  chipSpacing: 8.0,
                  rowSpacing: 8.0,
                  multiselect: false,
                  initialized: _model.choiceChipsValue != null,
                  alignment: WrapAlignment.start,
                  controller: _model.choiceChipsValueController ??=
                      FormFieldController<List<String>>(
                    [GoalPrayer.goal.name],
                  ),
                  wrapped: true,
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 60.0),
                  child: FutureBuilder<List<GetGoalsPrayersRow>>(
                    future: SQLiteManager.instance.getGoalsPrayers(
                      type: _model.choiceChipsValue!,
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
                      final listViewGetGoalsPrayersRowList = snapshot.data!;
                      if (listViewGetGoalsPrayersRowList.isEmpty) {
                        return EmptyResultsWidget(
                          message: 'No data to show',
                        );
                      }

                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewGetGoalsPrayersRowList.length,
                        separatorBuilder: (_, __) => SizedBox(height: 18.0),
                        itemBuilder: (context, listViewIndex) {
                          final listViewGetGoalsPrayersRow =
                              listViewGetGoalsPrayersRowList[listViewIndex];
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            listViewGetGoalsPrayersRow.title,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
                                                ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Text(
                                          listViewGetGoalsPrayersRow
                                              .description,
                                          textAlign: TextAlign.justify,
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                fontFamily: 'GFS Didot',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts:
                                                    GoogleFonts.asMap()
                                                        .containsKey(
                                                            'GFS Didot'),
                                              ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              var confirmDialogResponse =
                                                  await showDialog<bool>(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return AlertDialog(
                                                            title:
                                                                Text('Delete'),
                                                            content: Text(
                                                                'Are you sure you want to delete this?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext,
                                                                        false),
                                                                child:
                                                                    Text('No'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext,
                                                                        true),
                                                                child:
                                                                    Text('Yes'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ) ??
                                                      false;
                                              if (confirmDialogResponse) {
                                                await SQLiteManager.instance
                                                    .deleteGoalPrayer(
                                                  id: listViewGetGoalsPrayersRow
                                                      .id,
                                                );

                                                safeSetState(() {});
                                                return;
                                              } else {
                                                return;
                                              }
                                            },
                                            child: FaIcon(
                                              FontAwesomeIcons.trashAlt,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]
                                        .divide(SizedBox(height: 12.0))
                                        .around(SizedBox(height: 12.0)),
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: 0.8,
                                child: Divider(
                                  thickness: 0.5,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                            ],
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
