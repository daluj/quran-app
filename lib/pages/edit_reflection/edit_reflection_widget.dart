import '/backend/sqlite/sqlite_manager.dart';
import '/components/empty_results_widget.dart';
import '/components/quran_verses_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_reflection_model.dart';
export 'edit_reflection_model.dart';

class EditReflectionWidget extends StatefulWidget {
  const EditReflectionWidget({
    super.key,
    required this.journal,
  });

  final GetJournalsRow? journal;

  static String routeName = 'editReflection';
  static String routePath = '/editReflection';

  @override
  State<EditReflectionWidget> createState() => _EditReflectionWidgetState();
}

class _EditReflectionWidgetState extends State<EditReflectionWidget> {
  late EditReflectionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditReflectionModel());

    _model.reflectionsFocusNode ??= FocusNode();

    _model.titleTextController ??=
        TextEditingController(text: widget.journal?.title);
    _model.titleFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GetJournalReflectionsRow>>(
      future: SQLiteManager.instance.getJournalReflections(
        id: widget.journal!.id,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitDoubleBounce(
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 50.0,
                ),
              ),
            ),
          );
        }
        final editReflectionGetJournalReflectionsRowList = snapshot.data!;

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
              title: TextFormField(
                controller: _model.titleTextController,
                focusNode: _model.titleFocusNode,
                autofocus: false,
                readOnly: !_model.showSave,
                obscureText: false,
                decoration: InputDecoration(
                  isDense: true,
                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).labelMediumFamily),
                      ),
                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).labelMediumFamily),
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: _model.showSave,
                  fillColor: FlutterFlowTheme.of(context).tertiary,
                ),
                style: FlutterFlowTheme.of(context).labelLarge.override(
                      fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).labelLargeFamily),
                    ),
                textAlign: TextAlign.justify,
                maxLength: 25,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                buildCounter: (context,
                        {required currentLength,
                        required isFocused,
                        maxLength}) =>
                    null,
                cursorColor: FlutterFlowTheme.of(context).primaryText,
                validator:
                    _model.titleTextControllerValidator.asValidator(context),
              ),
              actions: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (_model.showSave)
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.showSave = false;
                            safeSetState(() {});
                            safeSetState(() {
                              _model.titleTextController?.text =
                                  widget.journal!.title;
                            });
                            safeSetState(() {
                              _model.reflectionsTextController?.text =
                                  editReflectionGetJournalReflectionsRowList
                                      .firstOrNull!.reflections!;
                            });
                          },
                          child: Icon(
                            Icons.close,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                      Stack(
                        children: [
                          if (_model.showSave)
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                if (_model.titleTextController.text != '') {
                                  await SQLiteManager.instance
                                      .updateJournalTitle(
                                    id: widget.journal!.id,
                                    title: _model.titleTextController.text,
                                  );
                                  if (_model.reflectionsTextController.text !=
                                          '') {
                                    await SQLiteManager.instance
                                        .updateJournalReflections(
                                      id: widget.journal!.id,
                                      reflections:
                                          _model.reflectionsTextController.text,
                                    );
                                  }
                                  _model.showSave = false;
                                  safeSetState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Entry saved successfully',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                                  );
                                  return;
                                } else {
                                  return;
                                }
                              },
                              child: FaIcon(
                                FontAwesomeIcons.solidSave,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                            ),
                          if (!_model.showSave)
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.showSave = true;
                                safeSetState(() {});
                              },
                              child: FaIcon(
                                FontAwesomeIcons.edit,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                            ),
                        ],
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Delete Entry'),
                                    content: Text(
                                        'Are you sure you want to delete this entry?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, false),
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, true),
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  );
                                },
                              ) ??
                              false;
                          if (confirmDialogResponse) {
                            await SQLiteManager.instance.deleteJournalEntry(
                              id: widget.journal!.id,
                            );
                            context.safePop();
                            return;
                          } else {
                            return;
                          }
                        },
                        child: FaIcon(
                          FontAwesomeIcons.trashAlt,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                      ),
                    ].divide(SizedBox(width: 9.0)),
                  ),
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
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 60.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(1.0, 0.0),
                        child: RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: dateTimeFormat(
                                  "yMMMd",
                                  functions.unixTimeStamp(
                                      widget.journal!.entryDate),
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineMediumFamily,
                                      color:
                                          FlutterFlowTheme.of(context).accent2,
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .headlineMediumFamily),
                                    ),
                              ),
                              TextSpan(
                                text: ' at ',
                                style: TextStyle(),
                              ),
                              TextSpan(
                                text: dateTimeFormat(
                                  "Hm",
                                  functions.unixTimeStamp(
                                      widget.journal!.entryDate),
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                ),
                                style: TextStyle(),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineMediumFamily,
                                  color: FlutterFlowTheme.of(context).accent2,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .headlineMediumFamily),
                                ),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _model.reflectionsTextController ??=
                            TextEditingController(
                          text: editReflectionGetJournalReflectionsRowList
                              .firstOrNull?.reflections,
                        ),
                        focusNode: _model.reflectionsFocusNode,
                        autofocus: false,
                        readOnly: !_model.showSave,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                color: FlutterFlowTheme.of(context).accent2,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .labelMediumFamily),
                              ),
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                color: FlutterFlowTheme.of(context).accent2,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .labelMediumFamily),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: _model.showSave,
                          fillColor: FlutterFlowTheme.of(context).tertiary,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: FlutterFlowTheme.of(context).accent2,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                        maxLines: null,
                        minLines: 4,
                        maxLength: 500,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                maxLength}) =>
                            null,
                        cursorColor: FlutterFlowTheme.of(context).accent2,
                        validator: _model.reflectionsTextControllerValidator
                            .asValidator(context),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: FutureBuilder<List<GetJournalVersesRow>>(
                            future: SQLiteManager.instance.getJournalVerses(
                              journalId: widget.journal!.id,
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
                              final listViewGetJournalVersesRowList =
                                  snapshot.data!;
                              if (listViewGetJournalVersesRowList.isEmpty) {
                                return Center(
                                  child: EmptyResultsWidget(
                                    message:
                                        'Verses added to this reflection will appear here.',
                                    title: 'Waiting for Verses',
                                  ),
                                );
                              }

                              return ListView.separated(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    listViewGetJournalVersesRowList.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 18.0),
                                itemBuilder: (context, listViewIndex) {
                                  final listViewGetJournalVersesRow =
                                      listViewGetJournalVersesRowList[
                                          listViewIndex];
                                  return Stack(
                                    alignment: AlignmentDirectional(1.0, 1.0),
                                    children: [
                                      wrapWithModel(
                                        model:
                                            _model.quranVersesModels.getModel(
                                          listViewGetJournalVersesRow.id
                                              .toString(),
                                          listViewIndex,
                                        ),
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: QuranVersesWidget(
                                          key: Key(
                                            'Keyh38_${listViewGetJournalVersesRow.id.toString()}',
                                          ),
                                          suraId: listViewGetJournalVersesRow
                                              .surahId,
                                          verseId: listViewGetJournalVersesRow
                                              .verseId,
                                          translation:
                                              listViewGetJournalVersesRow
                                                  .verseTranslation,
                                          showDivider: true,
                                        ),
                                      ),
                                      if (_model.showSave)
                                        Align(
                                          alignment:
                                              AlignmentDirectional(1.0, 1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 16.0, 12.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                var confirmDialogResponse =
                                                    await showDialog<bool>(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Delete Verse'),
                                                              content: Text(
                                                                  'Are you sure you want to delete this verse?'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext,
                                                                          false),
                                                                  child: Text(
                                                                      'No'),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext,
                                                                          true),
                                                                  child: Text(
                                                                      'Yes'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ) ??
                                                        false;
                                                if (confirmDialogResponse) {
                                                  await SQLiteManager.instance
                                                      .deleteJournalVerse(
                                                    id: listViewGetJournalVersesRow
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
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 12.0))
                        .around(SizedBox(height: 12.0)),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
