import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN GETVERSESFROMSURAHID
Future<List<GetVersesFromSurahIdRow>> performGetVersesFromSurahId(
  Database database, {
  int? surahId,
  String? translationCode,
}) {
  final query = '''
SELECT 
    v.verse_id,
    v.surah_id,
    v.$translationCode AS verse_translation,
    COALESCE(COUNT(c.id), 0) AS comment_count,
    	 (
        SELECT GROUP_CONCAT(w.ar, ' ')
        FROM words w
        WHERE w.surah_id = v.surah_id AND w.verse_id = v.verse_id
    ) AS ar,
    CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM collection_verses cv
            INNER JOIN collections col
            ON col.id = cv.collection_id
            WHERE col.type = 'bookmark'
            AND cv.surah_id = v.surah_id
            AND cv.verse_id = v.verse_id
        ) THEN 1
        ELSE 0
    END AS hasBookMark,
    (SELECT col.id 
     FROM collections col
     WHERE col.type = 'bookmark'
     LIMIT 1) AS collection_id
FROM 
    verses v
LEFT JOIN 
    comments c
    ON v.surah_id = c.surah_id 
    AND v.verse_id = c.verse_id
WHERE 
    v.surah_id = $surahId
GROUP BY 
    v.verse_id, 
    v.surah_id, 
    v.$translationCode
ORDER BY 
    v.surah_id, 
    v.verse_id;
''';
  return _readQuery(database, query, (d) => GetVersesFromSurahIdRow(d));
}

class GetVersesFromSurahIdRow extends SqliteRow {
  GetVersesFromSurahIdRow(super.data);

  int get verseId => data['verse_id'] as int;
  int get surahId => data['surah_id'] as int;
  String get verseTranslation => data['verse_translation'] as String;
  int get commentCount => data['comment_count'] as int;
  int get hasBookMark => data['hasBookMark'] as int;
  int get collectionId => data['collection_id'] as int;
  String get ar => data['ar'] as String;
}

/// END GETVERSESFROMSURAHID

/// BEGIN GETVERSESFROMLIST
Future<List<GetVersesFromListRow>> performGetVersesFromList(
  Database database, {
  String? verses,
  String? translationCode,
}) {
  final query = '''
SELECT verse_id, surah_id, $translationCode AS verse_translation
FROM verses
WHERE verse_code IN ( $verses )
ORDER BY surah_id, verse_id;
''';
  return _readQuery(database, query, (d) => GetVersesFromListRow(d));
}

class GetVersesFromListRow extends SqliteRow {
  GetVersesFromListRow(super.data);

  int get verseId => data['verse_id'] as int;
  int get surahId => data['surah_id'] as int;
  String get verseTranslation => data['verse_translation'] as String;
}

/// END GETVERSESFROMLIST

/// BEGIN GETSURAH
Future<List<GetSurahRow>> performGetSurah(
  Database database, {
  int? surahId,
}) {
  final query = '''
SELECT id,verses_count,bismillah_pre 
FROM surahs 
WHERE id = $surahId;
''';
  return _readQuery(database, query, (d) => GetSurahRow(d));
}

class GetSurahRow extends SqliteRow {
  GetSurahRow(super.data);

  int get id => data['id'] as int;
  int get versesCount => data['verses_count'] as int;
  int? get bismillahPre => data['bismillah_pre'] as int?;
}

/// END GETSURAH

/// BEGIN GETVERSE
Future<List<GetVerseRow>> performGetVerse(
  Database database, {
  int? surahId,
  int? verseId,
  String? translationCode,
}) {
  final query = '''
SELECT verse_id, surah_id, $translationCode AS verse_translation
FROM verses
WHERE surah_id = $surahId AND verse_id = $verseId;
''';
  return _readQuery(database, query, (d) => GetVerseRow(d));
}

class GetVerseRow extends SqliteRow {
  GetVerseRow(super.data);

  int get verseId => data['verse_id'] as int;
  int get surahId => data['surah_id'] as int;
  String get verseTranslation => data['verse_translation'] as String;
}

/// END GETVERSE

/// BEGIN SEARCHTEXT
Future<List<SearchTextRow>> performSearchText(
  Database database, {
  String? searchText,
  String? translationCode,
}) {
  final query = '''
SELECT 
    v.verse_id, 
    v.surah_id,
    v.$translationCode AS verse_translation,
    t.total_results
FROM verses v
JOIN (
    SELECT COUNT(*) AS total_results
    FROM verses
    WHERE verse_id > 0 
      AND ($translationCode LIKE '%$searchText%' OR verse_code = '$searchText')
) t ON 1=1
WHERE v.verse_id > 0 
  AND (v.$translationCode LIKE '%$searchText%' OR v.verse_code = '$searchText');
''';
  return _readQuery(database, query, (d) => SearchTextRow(d));
}

class SearchTextRow extends SqliteRow {
  SearchTextRow(super.data);

  int get verseId => data['verse_id'] as int;
  int get surahId => data['surah_id'] as int;
  String get verseTranslation => data['verse_translation'] as String;
  int get totalResults => data['total_results'] as int;
  String get ar => data['ar'] as String;
  String get transliteration => data['transliteration'] as String;
}

/// END SEARCHTEXT

/// BEGIN GETPROGRESS
Future<List<GetProgressRow>> performGetProgress(
  Database database, {
  int? surahId,
  int? verseId,
}) {
  final query = '''
SELECT
    IFNULL((SELECT SUM(verses_count)
            FROM surahs s2
            WHERE s2.id < s1.id), 0) + v.verse_id AS cumulative_verses,
    (SELECT SUM(verses_count) FROM surahs) AS total_verses
FROM
    surahs s1
JOIN
    verses v ON s1.id = v.surah_id
WHERE
    v.surah_id = $surahId AND v.verse_id = $verseId;
''';
  return _readQuery(database, query, (d) => GetProgressRow(d));
}

class GetProgressRow extends SqliteRow {
  GetProgressRow(super.data);

  int get cumulativeVerses => data['cumulative_verses'] as int;
  int get totalVerses => data['total_verses'] as int;
}

/// END GETPROGRESS

/// BEGIN GETGLOSSARY
Future<List<GetGlossaryRow>> performGetGlossary(
  Database database, {
  String? translationCode,
  String? searchText,
}) {
  final query = '''
SELECT word,$translationCode as translation_text
FROM glossary 
WHERE word LIKE '%$searchText%'
ORDER BY word ASC;
''';
  return _readQuery(database, query, (d) => GetGlossaryRow(d));
}

class GetGlossaryRow extends SqliteRow {
  GetGlossaryRow(super.data);

  String get word => data['word'] as String;
  String get translationText => data['translation_text'] as String;
}

/// END GETGLOSSARY

/// BEGIN GETVERSECOMMENTS
Future<List<GetVerseCommentsRow>> performGetVerseComments(
  Database database, {
  int? surahId,
  int? verseId,
}) {
  final query = '''
SELECT id,surah_id, verse_id, comment_text, last_updated
FROM comments
WHERE surah_id = $surahId AND verse_id = $verseId
ORDER BY last_updated DESC;
''';
  return _readQuery(database, query, (d) => GetVerseCommentsRow(d));
}

class GetVerseCommentsRow extends SqliteRow {
  GetVerseCommentsRow(super.data);

  int get surahId => data['surah_id'] as int;
  int get verseId => data['verse_id'] as int;
  String get commentText => data['comment_text'] as String;
  int get id => data['id'] as int;
  int get lastUpdated => data['last_updated'] as int;
}

/// END GETVERSECOMMENTS

/// BEGIN GETCOMMENTS
Future<List<GetCommentsRow>> performGetComments(
  Database database,
) {
  const query = '''
SELECT
    c.id,
    c.verse_id,
    c.surah_id,
    c.comment_text,
    c.last_updated
FROM comments c
ORDER BY c.last_updated DESC;
''';
  return _readQuery(database, query, (d) => GetCommentsRow(d));
}

class GetCommentsRow extends SqliteRow {
  GetCommentsRow(super.data);

  int get verseId => data['verse_id'] as int;
  int get surahId => data['surah_id'] as int;
  String get commentText => data['comment_text'] as String;
  int get id => data['id'] as int;
  int get lastUpdated => data['last_updated'] as int;
}

/// END GETCOMMENTS

/// BEGIN GETJOURNALS
Future<List<GetJournalsRow>> performGetJournals(
  Database database,
) {
  const query = '''
SELECT  
    j.id, 
    j.title, 
    j.entry_date,
    COUNT(jv.id) AS total_verses
FROM journal j
LEFT JOIN journal_verses jv ON j.id = jv.journal_id
WHERE j.id IS NOT NULL
GROUP BY j.id, j.title, j.entry_date
ORDER BY j.entry_date DESC;

''';
  return _readQuery(database, query, (d) => GetJournalsRow(d));
}

class GetJournalsRow extends SqliteRow {
  GetJournalsRow(super.data);

  String get title => data['title'] as String;
  int get id => data['id'] as int;
  int get entryDate => data['entry_date'] as int;
  int get totalVerses => data['total_verses'] as int;
}

/// END GETJOURNALS

/// BEGIN GETJOURNALVERSES
Future<List<GetJournalVersesRow>> performGetJournalVerses(
  Database database, {
  int? journalId,
  String? translationCode,
}) {
  final query = '''
SELECT jv.id, jv.journal_id, v.verse_id, v.surah_id, v.$translationCode AS verse_translation
FROM verses v
INNER JOIN journal_verses jv ON v.verse_id = jv.verse_id AND v.surah_id = jv.surah_id
WHERE jv.journal_id = $journalId;
''';
  return _readQuery(database, query, (d) => GetJournalVersesRow(d));
}

class GetJournalVersesRow extends SqliteRow {
  GetJournalVersesRow(super.data);

  int get id => data['id'] as int;
  int get journalId => data['journal_id'] as int;
  int get verseId => data['verse_id'] as int;
  int get surahId => data['surah_id'] as int;
  String get verseTranslation => data['verse_translation'] as String;
}

/// END GETJOURNALVERSES

/// BEGIN GETJOURNALREFLECTIONS
Future<List<GetJournalReflectionsRow>> performGetJournalReflections(
  Database database, {
  int? id,
}) {
  final query = '''
SELECT reflections
FROM journal
WHERE id = $id;
''';
  return _readQuery(database, query, (d) => GetJournalReflectionsRow(d));
}

class GetJournalReflectionsRow extends SqliteRow {
  GetJournalReflectionsRow(super.data);

  String? get reflections => data['reflections'] as String?;
}

/// END GETJOURNALREFLECTIONS

/// BEGIN GETVERSESIDSFROMSURA
Future<List<GetVersesIdsFromSuraRow>> performGetVersesIdsFromSura(
  Database database, {
  String? surahId,
  String? verseId,
}) {
  final query = '''
SELECT verse_id
FROM verses
WHERE surah_id = $surahId AND (verse_id = $verseId OR $verseId = '') AND verse_id > 0;
''';
  return _readQuery(database, query, (d) => GetVersesIdsFromSuraRow(d));
}

class GetVersesIdsFromSuraRow extends SqliteRow {
  GetVersesIdsFromSuraRow(super.data);

  int get verseId => data['verse_id'] as int;
}

/// END GETVERSESIDSFROMSURA

/// BEGIN GETSURAIDS
Future<List<GetSuraIdsRow>> performGetSuraIds(
  Database database, {
  String? surahId,
}) {
  final query = '''
SELECT id
FROM surahs
WHERE id = $surahId OR $surahId = '';
''';
  return _readQuery(database, query, (d) => GetSuraIdsRow(d));
}

class GetSuraIdsRow extends SqliteRow {
  GetSuraIdsRow(super.data);

  int get id => data['id'] as int;
}

/// END GETSURAIDS

/// BEGIN GETCOMMENTSSURAHID
Future<List<GetCommentsSurahIdRow>> performGetCommentsSurahId(
  Database database, {
  int? surahId,
}) {
  final query = '''
SELECT
    id,
    verse_id,
    surah_id,
    comment_text,
    last_updated
FROM comments
WHERE surah_id = $surahId
ORDER BY last_updated DESC;
''';
  return _readQuery(database, query, (d) => GetCommentsSurahIdRow(d));
}

class GetCommentsSurahIdRow extends SqliteRow {
  GetCommentsSurahIdRow(super.data);

  int get verseId => data['verse_id'] as int;
  int get surahId => data['surah_id'] as int;
  String get commentText => data['comment_text'] as String;
  int get id => data['id'] as int;
  int get lastUpdated => data['last_updated'] as int;
}

/// END GETCOMMENTSSURAHID

/// BEGIN GETVERSES
Future<List<GetVersesRow>> performGetVerses(
  Database database, {
  String? translationCode,
}) {
  final query = '''
SELECT verse_id, surah_id, $translationCode AS verse_translation
FROM verses
ORDER BY surah_id, verse_id;
''';
  return _readQuery(database, query, (d) => GetVersesRow(d));
}

class GetVersesRow extends SqliteRow {
  GetVersesRow(super.data);

  int get verseId => data['verse_id'] as int;
  int get surahId => data['surah_id'] as int;
  String get verseTranslation => data['verse_translation'] as String;
}

/// END GETVERSES

/// BEGIN GETCOLLECTIONSBYTYPE
Future<List<GetCollectionsByTypeRow>> performGetCollectionsByType(
  Database database, {
  String? type,
}) {
  final query = '''
SELECT 
    c.id, 
    c.title, 
    c.deletable,
    COUNT(cv.id) AS total_verses
FROM 
    collections c
LEFT JOIN 
    collection_verses cv ON c.id = cv.collection_id
WHERE 
    c.type = '$type'
GROUP BY 
    c.id, c.title
ORDER BY c.id;
''';
  return _readQuery(database, query, (d) => GetCollectionsByTypeRow(d));
}

class GetCollectionsByTypeRow extends SqliteRow {
  GetCollectionsByTypeRow(super.data);

  int get id => data['id'] as int;
  String get title => data['title'] as String;
  int get totalVerses => data['total_verses'] as int;
  int get deletable => data['deletable'] as int;
}

/// END GETCOLLECTIONSBYTYPE

/// BEGIN GETCOLLECTIONVERSES
Future<List<GetCollectionVersesRow>> performGetCollectionVerses(
  Database database, {
  int? collectionId,
  String? translationCode,
}) {
  final query = '''
SELECT cv.id, cv.collection_id, v.verse_id, v.surah_id, v.$translationCode AS verse_translation
FROM verses v
INNER JOIN collection_verses cv ON v.verse_id = cv.verse_id AND v.surah_id = cv.surah_id
WHERE cv.collection_id = $collectionId;
''';
  return _readQuery(database, query, (d) => GetCollectionVersesRow(d));
}

class GetCollectionVersesRow extends SqliteRow {
  GetCollectionVersesRow(super.data);

  int get id => data['id'] as int;
  int get collectionId => data['collection_id'] as int;
  int get verseId => data['verse_id'] as int;
  int get surahId => data['surah_id'] as int;
  String get verseTranslation => data['verse_translation'] as String;
}

/// END GETCOLLECTIONVERSES

/// BEGIN SEARCHTEXTCOUNT
Future<List<SearchTextCountRow>> performSearchTextCount(
  Database database, {
  String? searchText,
  String? translationCode,
}) {
  final query = '''
SELECT COUNT(*) AS total_results
FROM verses
WHERE verse_id > 0 AND ($translationCode LIKE '%$searchText%' OR verse_code = '$searchText');
''';
  return _readQuery(database, query, (d) => SearchTextCountRow(d));
}

class SearchTextCountRow extends SqliteRow {
  SearchTextCountRow(super.data);

  int get totalResults => data['total_results'] as int;
}

/// END SEARCHTEXTCOUNT

/// BEGIN GETNAMESBYTYPE
Future<List<GetNamesByTypeRow>> performGetNamesByType(
  Database database, {
  String? type,
  String? languageCode,
}) {
  final query = '''
SELECT 
    IFNULL(ar, '') AS ar,
    IFNULL($languageCode, '') AS translation,
    IFNULL(transliteration, '') AS transliteration,
    IFNULL(verses, '') AS verses,
    IFNULL(audio_url, '') AS audio_url
FROM  names
WHERE type = '$type'
ORDER BY id;
''';
  return _readQuery(database, query, (d) => GetNamesByTypeRow(d));
}

class GetNamesByTypeRow extends SqliteRow {
  GetNamesByTypeRow(super.data);

  String get ar => data['ar'] as String;
  String get translation => data['translation'] as String;
  String get transliteration => data['transliteration'] as String;
  String get verses => data['verses'] as String;
  String get audioUrl => data['audio_url'] as String;
}

/// END GETNAMESBYTYPE

/// BEGIN GETSURAHS
Future<List<GetSurahsRow>> performGetSurahs(
  Database database, {
  String? surahId,
}) {
  final query = '''
SELECT id,verses_count,bismillah_pre 
FROM surahs
WHERE id = $surahId OR $surahId = '';
''';
  return _readQuery(database, query, (d) => GetSurahsRow(d));
}

class GetSurahsRow extends SqliteRow {
  GetSurahsRow(super.data);

  int get id => data['id'] as int;
  int get versesCount => data['verses_count'] as int;
  int? get bismillahPre => data['bismillah_pre'] as int?;
}

/// END GETSURAHS

/// BEGIN GETRECITERS
Future<List<GetRecitersRow>> performGetReciters(
  Database database, {
  String? searchText,
}) {
  final query = '''
SELECT name,code,audio_url
FROM reciters
WHERE name LIKE '%$searchText%';
''';
  return _readQuery(database, query, (d) => GetRecitersRow(d));
}

class GetRecitersRow extends SqliteRow {
  GetRecitersRow(super.data);

  String get name => data['name'] as String;
  String get code => data['code'] as String;
  String get audioUrl => data['audio_url'] as String;
}

/// END GETRECITERS

/// BEGIN GETWORDS
Future<List<GetWordsRow>> performGetWords(
  Database database, {
  int? surahId,
  int? verseId,
}) {
  final query = '''
SELECT surah_id, verse_id, position_id, ar, transliteration
FROM words
WHERE surah_id = $surahId AND verse_id = $verseId
ORDER BY position_id;
''';
  return _readQuery(database, query, (d) => GetWordsRow(d));
}

class GetWordsRow extends SqliteRow {
  GetWordsRow(super.data);

  int get surahId => data['surah_id'] as int;
  int get verseId => data['verse_id'] as int;
  int get positionId => data['position_id'] as int;
  String get ar => data['ar'] as String;
  String get transliteration => data['transliteration'] as String;
}

/// END GETWORDS

/// BEGIN VERSECOMMENTCOUNT
Future<List<VerseCommentCountRow>> performVerseCommentCount(
  Database database, {
  int? surahId,
  int? verseId,
}) {
  final query = '''
SELECT COUNT(id) as comment_count
FROM comments
WHERE surah_id = $surahId AND verse_id = $verseId
''';
  return _readQuery(database, query, (d) => VerseCommentCountRow(d));
}

class VerseCommentCountRow extends SqliteRow {
  VerseCommentCountRow(super.data);

  int get commentCount => data['comment_count'] as int;
}

/// END VERSECOMMENTCOUNT

/// BEGIN CHECKBOOKMARK
Future<List<CheckBookmarkRow>> performCheckBookmark(
  Database database, {
  int? surahId,
  int? verseId,
}) {
  final query = '''
SELECT
    CASE 
        WHEN COUNT(cv.id) > 0 THEN 1
        ELSE 0
    END AS hasBookMark,
    c.id as collection_id
FROM 
    collections c
LEFT JOIN 
    collection_verses cv 
    ON c.id = cv.collection_id 
    AND cv.surah_id = $surahId 
    AND cv.verse_id = $verseId
WHERE 
    c.type = 'bookmark';
''';
  return _readQuery(database, query, (d) => CheckBookmarkRow(d));
}

class CheckBookmarkRow extends SqliteRow {
  CheckBookmarkRow(super.data);

  int get hasBookMark => data['hasBookMark'] as int;
  int get collectionId => data['collection_id'] as int;
}

/// END CHECKBOOKMARK

/// BEGIN GETARABICWORDS
Future<List<GetArabicWordsRow>> performGetArabicWords(
  Database database, {
  int? surahId,
  int? verseId,
}) {
  final query = '''
SELECT surah_id, verse_id, position_id, ar
FROM words
WHERE surah_id = $surahId AND verse_id = $verseId
ORDER BY position_id;
''';
  return _readQuery(database, query, (d) => GetArabicWordsRow(d));
}

class GetArabicWordsRow extends SqliteRow {
  GetArabicWordsRow(super.data);

  int get surahId => data['surah_id'] as int;
  int get verseId => data['verse_id'] as int;
  int get positionId => data['position_id'] as int;
  String get ar => data['ar'] as String;
  String get transliteration => data['transliteration'] as String;
}

/// END GETARABICWORDS

/// BEGIN GETDICTIONARY
Future<List<GetDictionaryRow>> performGetDictionary(
  Database database,
) {
  const query = '''
SELECT surah_id, verse_id, position_id, ar, transliteration, COUNT(*) AS frequency
FROM words w
WHERE w.verse_id > 0
GROUP BY w.ar
ORDER BY frequency DESC;
''';
  return _readQuery(database, query, (d) => GetDictionaryRow(d));
}

class GetDictionaryRow extends SqliteRow {
  GetDictionaryRow(super.data);

  int get surahId => data['surah_id'] as int;
  int get verseId => data['verse_id'] as int;
  int get positionId => data['position_id'] as int;
  String get ar => data['ar'] as String;
  String get transliteration => data['transliteration'] as String;
  int get frequency => data['frequency'] as int;
}

/// END GETDICTIONARY
