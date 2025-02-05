// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:quran/backend/sqlite/queries/read.dart';
import '/components/quran_sura_verse_widget.dart';

class CustomScrollableList extends StatefulWidget {
  const CustomScrollableList({
    super.key,
    this.width,
    this.height,
    required this.queryResults,
    this.indexToScroll = 0,
  });

  final double? width;
  final double? height;
  final List<GetVersesFromSurahIdRow> queryResults;
  final int indexToScroll;

  @override
  State<CustomScrollableList> createState() => _CustomScrollableListState();
}

class _CustomScrollableListState extends State<CustomScrollableList> {
  final ItemScrollController _itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();

    // Scroll to the specified index after the widget builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.indexToScroll >= 0 &&
          widget.indexToScroll < widget.queryResults.length) {
        _itemScrollController.jumpTo(index: widget.indexToScroll);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.queryResults.isEmpty) {
      return Center(child: Text('No verses found.'));
    }

    return Container(
      width: widget.width,
      height: widget.height,
      child: ScrollablePositionedList.builder(
        itemScrollController: _itemScrollController,
        itemCount: widget.queryResults.length,
        itemBuilder: (context, index) {
          final row = widget.queryResults[index];
          return QuranSuraVerseWidget(
              key: ValueKey('${row.surahId}_${row.verseId}'),
              suraId: row.surahId,
              verseId: row.verseId,
              hasBookMark: row.hasBookMark,
              bookmarkCollectionId: row.collectionId,
              translation: row.verseTranslation,
              ar: row.ar,
              commentCount: row.commentCount);
        },
      ),
    );
  }
}
