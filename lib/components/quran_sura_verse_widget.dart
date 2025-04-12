import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/components/verse_menu_widget.dart';
import '/components/words_player_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'quran_sura_verse_model.dart';
export 'quran_sura_verse_model.dart';

class QuranSuraVerseWidget extends StatefulWidget {
  const QuranSuraVerseWidget({
    super.key,
    int? suraId,
    int? verseId,
    required this.translation,
    int? commentCount,
    required this.hasBookMark,
    required this.bookmarkCollectionId,
    required this.ar,
  })  : this.suraId = suraId ?? 0,
        this.verseId = verseId ?? 0,
        this.commentCount = commentCount ?? 0;

  final int suraId;
  final int verseId;
  final String? translation;
  final int commentCount;
  final int? hasBookMark;
  final int? bookmarkCollectionId;
  final String? ar;

  @override
  State<QuranSuraVerseWidget> createState() => _QuranSuraVerseWidgetState();
}

class _QuranSuraVerseWidgetState extends State<QuranSuraVerseWidget> {
  late QuranSuraVerseModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuranSuraVerseModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.hasBookMark = widget.hasBookMark == 1 ? true : false;
    });
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (!FFAppState().readingMode)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (widget.verseId > 0)
                        Align(
                          alignment: AlignmentDirectional(1.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (widget.verseId > 0) {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.36,
                                        child: VerseMenuWidget(
                                          verseId: widget.verseId,
                                          surahId: widget.suraId,
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));

                                return;
                              } else {
                                return;
                              }
                            },
                            child: Container(
                              width: 48.0,
                              height: 48.0,
                              decoration: BoxDecoration(),
                              child: Align(
                                alignment: AlignmentDirectional(1.0, 0.0),
                                child: Icon(
                                  Icons.menu_rounded,
                                  color: FlutterFlowTheme.of(context).verseIcon,
                                  size: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                if (FFAppState().showArabicText &&
                    ('${(widget.ar!).trim()}' != ''))
                  Align(
                    alignment: AlignmentDirectional(1.0, 0.0),
                    child: Text(
                      widget.ar!,
                      textAlign: TextAlign.end,
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily: 'Uthman',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: FFAppState().arabFontSize.toDouble(),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Uthman'),
                            lineHeight: 1.5,
                          ),
                    ),
                  ),
                if (FFAppState().showTranslation &&
                    FFAppState().showArabicText &&
                    (widget.translation != null && widget.translation != ''))
                  SizedBox(
                    width: 50.0,
                    child: Divider(
                      thickness: 0.5,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                if ((widget.translation != null &&
                        widget.translation != '') &&
                    FFAppState().showTranslation)
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      valueOrDefault<String>(
                        widget.translation,
                        '\"\"',
                      ),
                      textAlign: TextAlign.justify,
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            fontFamily: 'GFS Didot',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize:
                                FFAppState().translationFontSize.toDouble(),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('GFS Didot'),
                          ),
                    ),
                  ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if ((widget.verseId > 0) && !FFAppState().readingMode)
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  VerseCommentsWidget.routeName,
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
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType:
                                          PageTransitionType.bottomToTop,
                                    ),
                                  },
                                );
                              },
                              child: Container(
                                height: 40.0,
                                constraints: BoxConstraints(
                                  minWidth: 24.0,
                                ),
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.comment,
                                        color: FlutterFlowTheme.of(context)
                                            .verseIcon,
                                        size: 14.0,
                                      ),
                                    ),
                                    Text(
                                      widget.commentCount.toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .verseIcon,
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily),
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 6.0)),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  FFAppState().lastRead = BookMarkStruct(
                                    surahId: widget.suraId,
                                    verseId: widget.verseId,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Verse saved to Last Read',
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
                                },
                                child: Container(
                                  width: 48.0,
                                  height: 48.0,
                                  decoration: BoxDecoration(),
                                  child: Icon(
                                    Icons.menu_book_rounded,
                                    color:
                                        FlutterFlowTheme.of(context).verseIcon,
                                    size: 14.0,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  FFAppState().lastRecitation = BookMarkStruct(
                                    surahId: widget.suraId,
                                    verseId: widget.verseId,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Verse saved to Last Recitation',
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
                                },
                                child: Container(
                                  width: 48.0,
                                  height: 48.0,
                                  decoration: BoxDecoration(),
                                  child: Icon(
                                    Icons.mic_none,
                                    color:
                                        FlutterFlowTheme.of(context).verseIcon,
                                    size: 14.0,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 48.0,
                              height: 48.0,
                              child: Stack(
                                children: [
                                  if (!_model.hasBookMark)
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          await SQLiteManager.instance
                                              .addVerseCollection(
                                            collectionId:
                                                widget.bookmarkCollectionId!,
                                            surahId: widget.suraId,
                                            verseId: widget.verseId,
                                          );
                                          _model.hasBookMark = true;
                                          safeSetState(() {});
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Verse added to Saved Verses',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 48.0,
                                          height: 48.0,
                                          decoration: BoxDecoration(),
                                          child: Icon(
                                            Icons.bookmark_border,
                                            color: FlutterFlowTheme.of(context)
                                                .verseIcon,
                                            size: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (_model.hasBookMark)
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          await SQLiteManager.instance
                                              .deleteBookmark(
                                            collectionId:
                                                widget.bookmarkCollectionId!,
                                            surahId: widget.suraId,
                                            verseId: widget.verseId,
                                          );
                                          _model.hasBookMark = false;
                                          safeSetState(() {});
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Verse deleted from Saved Verses',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 48.0,
                                          height: 48.0,
                                          decoration: BoxDecoration(),
                                          child: Icon(
                                            Icons.bookmark,
                                            color: FlutterFlowTheme.of(context)
                                                .verseIcon,
                                            size: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.words =
                                      await SQLiteManager.instance.getWords(
                                    surahId: widget.suraId,
                                    verseId: widget.verseId,
                                  );
                                  _model.audioList =
                                      await actions.createAudioList(
                                    _model.words!.toList(),
                                  );
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: Container(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.45,
                                          child: WordsPlayerWidget(
                                            audioList: _model.audioList,
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));

                                  safeSetState(() {});
                                },
                                child: Container(
                                  width: 48.0,
                                  height: 48.0,
                                  decoration: BoxDecoration(),
                                  child: Icon(
                                    Icons.play_arrow,
                                    color:
                                        FlutterFlowTheme.of(context).verseIcon,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if ((widget.verseId > 0) && FFAppState().readingMode)
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                FFAppState().lastRead = BookMarkStruct(
                                  surahId: widget.suraId,
                                  verseId: widget.verseId,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Verse saved to Last Read',
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
                              },
                              child: Container(
                                width: 48.0,
                                decoration: BoxDecoration(),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Icon(
                                  Icons.menu_book_rounded,
                                  color: FlutterFlowTheme.of(context).verseIcon,
                                  size: 14.0,
                                ),
                              ),
                            ),
                          Align(
                            alignment: AlignmentDirectional(1.0, 0.0),
                            child: RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: widget.verseId > 0
                                        ? widget.verseId.toString()
                                        : '',
                                    style: TextStyle(),
                                  )
                                ],
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .headlineSmallFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .verseIcon,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .headlineSmallFamily),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (widget.verseId > 0)
            Opacity(
              opacity: 0.8,
              child: Divider(
                thickness: 0.5,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
        ],
      ),
    );
  }
}
