import 'package:flutter/foundation.dart';

import '/backend/sqlite/init.dart';
import 'queries/read.dart';
import 'queries/update.dart';

import 'package:sqflite/sqflite.dart';
export 'queries/read.dart';
export 'queries/update.dart';

class SQLiteManager {
  SQLiteManager._();

  static SQLiteManager? _instance;
  static SQLiteManager get instance => _instance ??= SQLiteManager._();

  static late Database _database;
  Database get database => _database;

  static Future initialize() async {
    if (kIsWeb) {
      return;
    }
    _database = await initializeDatabaseFromDbFile(
      'quran',
      'quran.db',
    );
  }

  /// START READ QUERY CALLS

  Future<List<GetVersesFromSurahIdRow>> getVersesFromSurahId({
    int? surahId,
    String? translationCode,
  }) =>
      performGetVersesFromSurahId(
        _database,
        surahId: surahId,
        translationCode: translationCode,
      );

  Future<List<GetVersesFromListRow>> getVersesFromList({
    String? verses,
    String? translationCode,
  }) =>
      performGetVersesFromList(
        _database,
        verses: verses,
        translationCode: translationCode,
      );

  Future<List<GetSurahRow>> getSurah({
    int? surahId,
  }) =>
      performGetSurah(
        _database,
        surahId: surahId,
      );

  Future<List<GetVerseRow>> getVerse({
    int? surahId,
    int? verseId,
    String? translationCode,
  }) =>
      performGetVerse(
        _database,
        surahId: surahId,
        verseId: verseId,
        translationCode: translationCode,
      );

  Future<List<SearchTextRow>> searchText({
    String? searchText,
    String? translationCode,
  }) =>
      performSearchText(
        _database,
        searchText: searchText,
        translationCode: translationCode,
      );

  Future<List<GetProgressRow>> getProgress({
    int? surahId,
    int? verseId,
  }) =>
      performGetProgress(
        _database,
        surahId: surahId,
        verseId: verseId,
      );

  Future<List<GetGlossaryRow>> getGlossary({
    String? translationCode,
    String? searchText,
  }) =>
      performGetGlossary(
        _database,
        translationCode: translationCode,
        searchText: searchText,
      );

  Future<List<GetVerseCommentsRow>> getVerseComments({
    int? surahId,
    int? verseId,
  }) =>
      performGetVerseComments(
        _database,
        surahId: surahId,
        verseId: verseId,
      );

  Future<List<GetCommentsRow>> getComments() => performGetComments(
        _database,
      );

  Future<List<GetJournalsRow>> getJournals() => performGetJournals(
        _database,
      );

  Future<List<GetJournalVersesRow>> getJournalVerses({
    int? journalId,
    String? translationCode,
  }) =>
      performGetJournalVerses(
        _database,
        journalId: journalId,
        translationCode: translationCode,
      );

  Future<List<GetJournalReflectionsRow>> getJournalReflections({
    int? id,
  }) =>
      performGetJournalReflections(
        _database,
        id: id,
      );

  Future<List<GetVersesIdsFromSuraRow>> getVersesIdsFromSura({
    String? surahId,
    String? verseId,
  }) =>
      performGetVersesIdsFromSura(
        _database,
        surahId: surahId,
        verseId: verseId,
      );

  Future<List<GetSuraIdsRow>> getSuraIds({
    String? surahId,
  }) =>
      performGetSuraIds(
        _database,
        surahId: surahId,
      );

  Future<List<GetCommentsSurahIdRow>> getCommentsSurahId({
    int? surahId,
  }) =>
      performGetCommentsSurahId(
        _database,
        surahId: surahId,
      );

  Future<List<GetVersesRow>> getVerses({
    String? translationCode,
  }) =>
      performGetVerses(
        _database,
        translationCode: translationCode,
      );

  Future<List<GetCollectionsByTypeRow>> getCollectionsByType({
    String? type,
  }) =>
      performGetCollectionsByType(
        _database,
        type: type,
      );

  Future<List<GetCollectionVersesRow>> getCollectionVerses({
    int? collectionId,
    String? translationCode,
  }) =>
      performGetCollectionVerses(
        _database,
        collectionId: collectionId,
        translationCode: translationCode,
      );

  Future<List<SearchTextCountRow>> searchTextCount({
    String? searchText,
    String? translationCode,
  }) =>
      performSearchTextCount(
        _database,
        searchText: searchText,
        translationCode: translationCode,
      );

  Future<List<GetNamesByTypeRow>> getNamesByType({
    String? type,
    String? languageCode,
  }) =>
      performGetNamesByType(
        _database,
        type: type,
        languageCode: languageCode,
      );

  Future<List<GetSurahsRow>> getSurahs({
    String? surahId,
  }) =>
      performGetSurahs(
        _database,
        surahId: surahId,
      );

  Future<List<GetRecitersRow>> getReciters({
    String? searchText,
  }) =>
      performGetReciters(
        _database,
        searchText: searchText,
      );

  Future<List<GetWordsRow>> getWords({
    int? surahId,
    int? verseId,
  }) =>
      performGetWords(
        _database,
        surahId: surahId,
        verseId: verseId,
      );

  Future<List<VerseCommentCountRow>> verseCommentCount({
    int? surahId,
    int? verseId,
  }) =>
      performVerseCommentCount(
        _database,
        surahId: surahId,
        verseId: verseId,
      );

  Future<List<CheckBookmarkRow>> checkBookmark({
    int? surahId,
    int? verseId,
  }) =>
      performCheckBookmark(
        _database,
        surahId: surahId,
        verseId: verseId,
      );

  Future<List<GetArabicWordsRow>> getArabicWords({
    int? surahId,
    int? verseId,
  }) =>
      performGetArabicWords(
        _database,
        surahId: surahId,
        verseId: verseId,
      );

  Future<List<GetDictionaryRow>> getDictionary() => performGetDictionary(
        _database,
      );

  Future<List<GetGoalsPrayersRow>> getGoalsPrayers({
    String? type,
  }) =>
      performGetGoalsPrayers(
        _database,
        type: type,
      );

  /// END READ QUERY CALLS

  /// START UPDATE QUERY CALLS

  Future addComment({
    int? surahId,
    int? verseId,
    String? commentText,
  }) =>
      performAddComment(
        _database,
        surahId: surahId,
        verseId: verseId,
        commentText: commentText,
      );

  Future updateComment({
    int? surahId,
    int? verseId,
    String? commentText,
  }) =>
      performUpdateComment(
        _database,
        surahId: surahId,
        verseId: verseId,
        commentText: commentText,
      );

  Future deleteComment({
    int? id,
  }) =>
      performDeleteComment(
        _database,
        id: id,
      );

  Future newJournalEntry({
    String? title,
    String? reflections,
  }) =>
      performNewJournalEntry(
        _database,
        title: title,
        reflections: reflections,
      );

  Future updateJournalTitle({
    int? id,
    String? title,
  }) =>
      performUpdateJournalTitle(
        _database,
        id: id,
        title: title,
      );

  Future deleteJournalEntry({
    int? id,
  }) =>
      performDeleteJournalEntry(
        _database,
        id: id,
      );

  Future deleteJournalVerse({
    int? id,
  }) =>
      performDeleteJournalVerse(
        _database,
        id: id,
      );

  Future addVerseJournal({
    int? journalId,
    int? surahId,
    int? verseId,
  }) =>
      performAddVerseJournal(
        _database,
        journalId: journalId,
        surahId: surahId,
        verseId: verseId,
      );

  Future updateJournalReflections({
    int? id,
    String? reflections,
  }) =>
      performUpdateJournalReflections(
        _database,
        id: id,
        reflections: reflections,
      );

  Future deleteCollection({
    int? id,
  }) =>
      performDeleteCollection(
        _database,
        id: id,
      );

  Future deleteCollectionVerse({
    int? id,
  }) =>
      performDeleteCollectionVerse(
        _database,
        id: id,
      );

  Future newCollection({
    String? title,
    String? type,
  }) =>
      performNewCollection(
        _database,
        title: title,
        type: type,
      );

  Future addVerseCollection({
    int? collectionId,
    int? surahId,
    int? verseId,
  }) =>
      performAddVerseCollection(
        _database,
        collectionId: collectionId,
        surahId: surahId,
        verseId: verseId,
      );

  Future updateCollectionTitle({
    int? id,
    String? title,
  }) =>
      performUpdateCollectionTitle(
        _database,
        id: id,
        title: title,
      );

  Future deleteBookmark({
    int? collectionId,
    int? surahId,
    int? verseId,
  }) =>
      performDeleteBookmark(
        _database,
        collectionId: collectionId,
        surahId: surahId,
        verseId: verseId,
      );

  Future addGoalPrayer({
    String? title,
    String? description,
    String? type,
  }) =>
      performAddGoalPrayer(
        _database,
        title: title,
        description: description,
        type: type,
      );

  Future deleteGoalPrayer({
    int? id,
  }) =>
      performDeleteGoalPrayer(
        _database,
        id: id,
      );

  /// END UPDATE QUERY CALLS
}
