import '/backend/sqlite/sqlite_manager.dart';
import '/components/empty_results_widget.dart';
import '/components/quran_verses_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_collection_model.dart';
export 'edit_collection_model.dart';

class EditCollectionWidget extends StatefulWidget {
  const EditCollectionWidget({
    super.key,
    required this.collection,
  });

  final GetCollectionsByTypeRow? collection;

  @override
  State<EditCollectionWidget> createState() => _EditCollectionWidgetState();
}

class _EditCollectionWidgetState extends State<EditCollectionWidget> {
  late EditCollectionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditCollectionModel());

    _model.titleTextController ??=
        TextEditingController(text: widget.collection?.title);
    _model.titleFocusNode ??= FocusNode();
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
          title: TextFormField(
            controller: _model.titleTextController,
            focusNode: _model.titleFocusNode,
            autofocus: false,
            readOnly: !_model.showSave,
            obscureText: false,
            decoration: InputDecoration(
              isDense: true,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0x00000000),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
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
            maxLength: 24,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            buildCounter: (context,
                    {required currentLength, required isFocused, maxLength}) =>
                null,
            cursorColor: FlutterFlowTheme.of(context).primaryText,
            validator: _model.titleTextControllerValidator.asValidator(context),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
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
                              widget.collection!.title;
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
                                  .updateCollectionTitle(
                                id: widget.collection!.id,
                                title: _model.titleTextController.text,
                              );
                              _model.showSave = false;
                              safeSetState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Collection saved successfully',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 4000),
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
                  if (widget.collection?.deletable == 1)
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
                                  title: const Text('Delete Collection'),
                                  content: const Text(
                                      'Are you sure you want to delete this collection?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, false),
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, true),
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            ) ??
                            false;
                        if (confirmDialogResponse) {
                          await SQLiteManager.instance.deleteCollection(
                            id: widget.collection!.id,
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
                ].divide(const SizedBox(width: 12.0)),
              ),
            ),
          ],
          centerTitle: false,
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
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                      child: FutureBuilder<List<GetCollectionVersesRow>>(
                        future: SQLiteManager.instance.getCollectionVerses(
                          collectionId: widget.collection!.id,
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
                            return const Center(
                              child: EmptyResultsWidget(
                                message:
                                    'Verses added to this collection will appear here.',
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
                                listViewGetCollectionVersesRowList.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 18.0),
                            itemBuilder: (context, listViewIndex) {
                              final listViewGetCollectionVersesRow =
                                  listViewGetCollectionVersesRowList[
                                      listViewIndex];
                              return Stack(
                                alignment: const AlignmentDirectional(1.0, 1.0),
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
                                        'Key6zq_${listViewGetCollectionVersesRow.id.toString()}',
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
                                  if (_model.showSave)
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 16.0, 12.0),
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
                                                        title: const Text(
                                                            'Delete Verse'),
                                                        content: const Text(
                                                            'Are you sure you want to delete this verse?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext,
                                                                    false),
                                                            child: const Text('No'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext,
                                                                    true),
                                                            child: const Text('Yes'),
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
                  ),
                ].divide(const SizedBox(height: 12.0)).around(const SizedBox(height: 12.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
