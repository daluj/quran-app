import 'package:sqflite/sqflite.dart';

/// BEGIN ADDCOMMENT
Future performAddComment(
  Database database, {
  int? surahId,
  int? verseId,
  String? commentText,
}) {
  final query = '''
INSERT INTO comments (verse_id, surah_id,comment_text,last_updated)
VALUES ($verseId, $surahId,'$commentText',strftime('%s', 'now'));
''';
  return database.rawQuery(query);
}

/// END ADDCOMMENT

/// BEGIN UPDATECOMMENT
Future performUpdateComment(
  Database database, {
  int? surahId,
  int? verseId,
  String? commentText,
}) {
  final query = '''
UPDATE comments
SET 
    surah_id = $surahId,
    verse_id = $verseId,
    comment_text = '$commentText',
    last_updated = strftime('%s', 'now')
WHERE surah_id = $surahId AND verse_id = $verseId;
''';
  return database.rawQuery(query);
}

/// END UPDATECOMMENT

/// BEGIN DELETECOMMENT
Future performDeleteComment(
  Database database, {
  int? id,
}) {
  final query = '''
DELETE FROM comments WHERE id = $id;
''';
  return database.rawQuery(query);
}

/// END DELETECOMMENT

/// BEGIN NEWJOURNALENTRY
Future performNewJournalEntry(
  Database database, {
  String? title,
  String? reflections,
}) {
  final query = '''
INSERT INTO journal (title,reflections,entry_date)
VALUES ('$title','$reflections',strftime('%s', 'now'));
''';
  return database.rawQuery(query);
}

/// END NEWJOURNALENTRY

/// BEGIN UPDATEJOURNALTITLE
Future performUpdateJournalTitle(
  Database database, {
  int? id,
  String? title,
}) {
  final query = '''
UPDATE journal
SET 
    title = '$title'
WHERE id = $id;
''';
  return database.rawQuery(query);
}

/// END UPDATEJOURNALTITLE

/// BEGIN DELETEJOURNALENTRY
Future performDeleteJournalEntry(
  Database database, {
  int? id,
}) {
  final query = '''
DELETE FROM journal WHERE id = $id;
''';
  return database.rawQuery(query);
}

/// END DELETEJOURNALENTRY

/// BEGIN DELETEJOURNALVERSE
Future performDeleteJournalVerse(
  Database database, {
  int? id,
}) {
  final query = '''
DELETE FROM journal_verses WHERE id = $id;
''';
  return database.rawQuery(query);
}

/// END DELETEJOURNALVERSE

/// BEGIN ADDVERSEJOURNAL
Future performAddVerseJournal(
  Database database, {
  int? journalId,
  int? surahId,
  int? verseId,
}) {
  final query = '''
INSERT OR IGNORE INTO journal_verses (journal_id,surah_id,verse_id)
VALUES ('$journalId','$surahId','$verseId');
''';
  return database.rawQuery(query);
}

/// END ADDVERSEJOURNAL

/// BEGIN UPDATEJOURNALREFLECTIONS
Future performUpdateJournalReflections(
  Database database, {
  int? id,
  String? reflections,
}) {
  final query = '''
UPDATE journal
SET 
    reflections = '$reflections'
WHERE id = $id;
''';
  return database.rawQuery(query);
}

/// END UPDATEJOURNALREFLECTIONS

/// BEGIN DELETECOLLECTION
Future performDeleteCollection(
  Database database, {
  int? id,
}) {
  final query = '''
DELETE FROM collections WHERE id = $id;
''';
  return database.rawQuery(query);
}

/// END DELETECOLLECTION

/// BEGIN DELETECOLLECTIONVERSE
Future performDeleteCollectionVerse(
  Database database, {
  int? id,
}) {
  final query = '''
DELETE FROM collection_verses WHERE id = $id;
''';
  return database.rawQuery(query);
}

/// END DELETECOLLECTIONVERSE

/// BEGIN NEWCOLLECTION
Future performNewCollection(
  Database database, {
  String? title,
  String? type,
}) {
  final query = '''
INSERT INTO collections (title,type,deletable)
VALUES ('$title','$type',1);
''';
  return database.rawQuery(query);
}

/// END NEWCOLLECTION

/// BEGIN ADDVERSECOLLECTION
Future performAddVerseCollection(
  Database database, {
  int? collectionId,
  int? surahId,
  int? verseId,
}) {
  final query = '''
INSERT OR IGNORE INTO collection_verses (collection_id,surah_id,verse_id)
VALUES ('$collectionId','$surahId','$verseId');
''';
  return database.rawQuery(query);
}

/// END ADDVERSECOLLECTION

/// BEGIN UPDATECOLLECTIONTITLE
Future performUpdateCollectionTitle(
  Database database, {
  int? id,
  String? title,
}) {
  final query = '''
UPDATE collections
SET 
    title = '$title'
WHERE id = $id;
''';
  return database.rawQuery(query);
}

/// END UPDATECOLLECTIONTITLE

/// BEGIN DELETEBOOKMARK
Future performDeleteBookmark(
  Database database, {
  int? collectionId,
  int? surahId,
  int? verseId,
}) {
  final query = '''
DELETE FROM collection_verses 
WHERE collection_id = $collectionId 
AND surah_id = $surahId 
AND verse_id = $verseId;
''';
  return database.rawQuery(query);
}

/// END DELETEBOOKMARK
