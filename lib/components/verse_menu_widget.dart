import '/backend/sqlite/sqlite_manager.dart';
import '/components/add_verse_to_collection_widget.dart';
import '/components/add_verse_to_reflections_widget.dart';
import '/components/new_collection_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'verse_menu_model.dart';
export 'verse_menu_model.dart';

class VerseMenuWidget extends StatefulWidget {
  const VerseMenuWidget({
    super.key,
    required this.verseId,
    required this.surahId,
  });

  final int? verseId;
  final int? surahId;

  @override
  State<VerseMenuWidget> createState() => _VerseMenuWidgetState();
}

class _VerseMenuWidgetState extends State<VerseMenuWidget> {
  late VerseMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VerseMenuModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              FlutterFlowTheme.of(context).primary,
              FlutterFlowTheme.of(context).tertiary
            ],
            stops: const [0.0, 1.0],
            begin: const AlignmentDirectional(0.0, -1.0),
            end: const AlignmentDirectional(0, 1.0),
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 50.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryText,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    var shouldSetState = false;
                    _model.journals =
                        await SQLiteManager.instance.getJournals();
                    shouldSetState = true;
                    if (_model.journals != null &&
                        (_model.journals)!.isNotEmpty) {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.5,
                              child: AddVerseToReflectionsWidget(
                                surahId: widget.surahId!,
                                verseId: widget.verseId!,
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));

                      if (shouldSetState) safeSetState(() {});
                      return;
                    } else {
                      context.pushNamed('newReflection');

                      if (shouldSetState) safeSetState(() {});
                      return;
                    }

                    if (shouldSetState) safeSetState(() {});
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.event_note_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                      Expanded(
                        child: Text(
                          'Add verse to Reflections',
                          style: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyLargeFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyLargeFamily),
                              ),
                        ),
                      ),
                    ].divide(const SizedBox(width: 12.0)),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    var shouldSetState = false;
                    _model.collections =
                        await SQLiteManager.instance.getCollectionsByType(
                      type: 'user',
                    );
                    shouldSetState = true;
                    if (_model.collections != null &&
                        (_model.collections)!.isNotEmpty) {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.5,
                              child: AddVerseToCollectionWidget(
                                surahId: widget.surahId!,
                                verseId: widget.verseId!,
                                type: 'user',
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));

                      if (shouldSetState) safeSetState(() {});
                      return;
                    } else {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.36,
                              child: const NewCollectionWidget(
                                type: 'user',
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));

                      if (shouldSetState) safeSetState(() {});
                      return;
                    }

                    if (shouldSetState) safeSetState(() {});
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.grid_view_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                      Expanded(
                        child: Text(
                          'Add verse to Collections',
                          style: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyLargeFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyLargeFamily),
                              ),
                        ),
                      ),
                    ].divide(const SizedBox(width: 12.0)),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    var shouldSetState = false;
                    _model.duas =
                        await SQLiteManager.instance.getCollectionsByType(
                      type: 'duas',
                    );
                    shouldSetState = true;
                    if (_model.duas != null && (_model.duas)!.isNotEmpty) {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.5,
                              child: AddVerseToCollectionWidget(
                                surahId: widget.surahId!,
                                verseId: widget.verseId!,
                                type: 'duas',
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));

                      if (shouldSetState) safeSetState(() {});
                      return;
                    } else {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.36,
                              child: const NewCollectionWidget(
                                type: 'duas',
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));

                      if (shouldSetState) safeSetState(() {});
                      return;
                    }

                    if (shouldSetState) safeSetState(() {});
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.pray,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                      Expanded(
                        child: Text(
                          'Add verse to Prayers',
                          style: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyLargeFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyLargeFamily),
                              ),
                        ),
                      ),
                    ].divide(const SizedBox(width: 12.0)),
                  ),
                ),
              ].divide(const SizedBox(height: 20.0)).addToEnd(const SizedBox(height: 18.0)),
            ),
          ),
        ),
      ),
    );
  }
}
