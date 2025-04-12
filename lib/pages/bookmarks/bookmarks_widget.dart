import '/backend/sqlite/sqlite_manager.dart';
import '/components/empty_results_widget.dart';
import '/components/quran_verses_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bookmarks_model.dart';
export 'bookmarks_model.dart';

class BookmarksWidget extends StatefulWidget {
  const BookmarksWidget({super.key});

  static String routeName = 'bookmarks';
  static String routePath = '/bookmarks';

  @override
  State<BookmarksWidget> createState() => _BookmarksWidgetState();
}

class _BookmarksWidgetState extends State<BookmarksWidget> {
  late BookmarksModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookmarksModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GetCollectionsByTypeRow>>(
      future: SQLiteManager.instance.getCollectionsByType(
        type: 'bookmark',
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
        final bookmarksGetCollectionsByTypeRowList = snapshot.data!;

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
                'SAVED VERSES',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).headlineMediumFamily,
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
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: FutureBuilder<List<GetCollectionVersesRow>>(
                        future: SQLiteManager.instance.getCollectionVerses(
                          collectionId: bookmarksGetCollectionsByTypeRowList
                              .firstOrNull!.id,
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
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 50.0,
                                ),
                              ),
                            );
                          }
                          final listViewGetCollectionVersesRowList =
                              snapshot.data!;
                          if (listViewGetCollectionVersesRowList.isEmpty) {
                            return Center(
                              child: EmptyResultsWidget(
                                message: 'Bookmarked verses will appear here',
                                title: 'No Verses Saved',
                              ),
                            );
                          }

                          return ListView.separated(
                            padding: EdgeInsets.fromLTRB(
                              0,
                              0,
                              0,
                              30.0,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount:
                                listViewGetCollectionVersesRowList.length,
                            separatorBuilder: (_, __) => SizedBox(height: 12.0),
                            itemBuilder: (context, listViewIndex) {
                              final listViewGetCollectionVersesRow =
                                  listViewGetCollectionVersesRowList[
                                      listViewIndex];
                              return Stack(
                                alignment: AlignmentDirectional(1.0, 1.0),
                                children: [
                                  wrapWithModel(
                                    model: _model.quranVersesModels.getModel(
                                      listViewGetCollectionVersesRow.id
                                          .toString(),
                                      listViewIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: QuranVersesWidget(
                                      key: Key(
                                        'Keyb4l_${listViewGetCollectionVersesRow.id.toString()}',
                                      ),
                                      suraId: listViewGetCollectionVersesRow
                                          .surahId,
                                      verseId: listViewGetCollectionVersesRow
                                          .verseId,
                                      translation:
                                          listViewGetCollectionVersesRow
                                              .verseTranslation,
                                      showDivider: true,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 12.0),
                                    child: InkWell(
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
                                                          Text('Delete Verse'),
                                                      content: Text(
                                                          'Are you sure you want to delete this verse?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext,
                                                                  false),
                                                          child: Text('No'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext,
                                                                  true),
                                                          child: Text('Yes'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ) ??
                                                false;
                                        if (confirmDialogResponse) {
                                          await SQLiteManager.instance
                                              .deleteCollectionVerse(
                                            id: listViewGetCollectionVersesRow
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
