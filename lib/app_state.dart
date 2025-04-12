import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _showArabicText = prefs.getBool('ff_showArabicText') ?? _showArabicText;
    });
    _safeInit(() {
      _showTransliteration =
          prefs.getBool('ff_showTransliteration') ?? _showTransliteration;
    });
    _safeInit(() {
      _showTranslation =
          prefs.getBool('ff_showTranslation') ?? _showTranslation;
    });
    _safeInit(() {
      _arabFontSize = prefs.getInt('ff_arabFontSize') ?? _arabFontSize;
    });
    _safeInit(() {
      _readingMode = prefs.getBool('ff_readingMode') ?? _readingMode;
    });
    _safeInit(() {
      _translationFontSize =
          prefs.getInt('ff_translationFontSize') ?? _translationFontSize;
    });
    _safeInit(() {
      _transliterationFontSize = prefs.getInt('ff_transliterationFontSize') ??
          _transliterationFontSize;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_lastRead')) {
        try {
          final serializedData = prefs.getString('ff_lastRead') ?? '{}';
          _lastRead =
              BookMarkStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_lastRecitation')) {
        try {
          final serializedData = prefs.getString('ff_lastRecitation') ?? '{}';
          _lastRecitation =
              BookMarkStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _downloadAudio = prefs.getBool('ff_downloadAudio') ?? _downloadAudio;
    });
    _safeInit(() {
      _wordSpaceSeconds =
          prefs.getInt('ff_wordSpaceSeconds') ?? _wordSpaceSeconds;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _showArabicText = true;
  bool get showArabicText => _showArabicText;
  set showArabicText(bool value) {
    _showArabicText = value;
    prefs.setBool('ff_showArabicText', value);
  }

  bool _showTransliteration = true;
  bool get showTransliteration => _showTransliteration;
  set showTransliteration(bool value) {
    _showTransliteration = value;
    prefs.setBool('ff_showTransliteration', value);
  }

  bool _showTranslation = true;
  bool get showTranslation => _showTranslation;
  set showTranslation(bool value) {
    _showTranslation = value;
    prefs.setBool('ff_showTranslation', value);
  }

  int _arabFontSize = 30;
  int get arabFontSize => _arabFontSize;
  set arabFontSize(int value) {
    _arabFontSize = value;
    prefs.setInt('ff_arabFontSize', value);
  }

  bool _readingMode = false;
  bool get readingMode => _readingMode;
  set readingMode(bool value) {
    _readingMode = value;
    prefs.setBool('ff_readingMode', value);
  }

  int _translationFontSize = 16;
  int get translationFontSize => _translationFontSize;
  set translationFontSize(int value) {
    _translationFontSize = value;
    prefs.setInt('ff_translationFontSize', value);
  }

  int _transliterationFontSize = 12;
  int get transliterationFontSize => _transliterationFontSize;
  set transliterationFontSize(int value) {
    _transliterationFontSize = value;
    prefs.setInt('ff_transliterationFontSize', value);
  }

  BookMarkStruct _lastRead = BookMarkStruct.fromSerializableMap(
      jsonDecode('{\"surah_id\":\"0\",\"verse_id\":\"0\"}'));
  BookMarkStruct get lastRead => _lastRead;
  set lastRead(BookMarkStruct value) {
    _lastRead = value;
    prefs.setString('ff_lastRead', value.serialize());
  }

  void updateLastReadStruct(Function(BookMarkStruct) updateFn) {
    updateFn(_lastRead);
    prefs.setString('ff_lastRead', _lastRead.serialize());
  }

  BookMarkStruct _lastRecitation = BookMarkStruct.fromSerializableMap(
      jsonDecode('{\"surah_id\":\"0\",\"verse_id\":\"0\"}'));
  BookMarkStruct get lastRecitation => _lastRecitation;
  set lastRecitation(BookMarkStruct value) {
    _lastRecitation = value;
    prefs.setString('ff_lastRecitation', value.serialize());
  }

  void updateLastRecitationStruct(Function(BookMarkStruct) updateFn) {
    updateFn(_lastRecitation);
    prefs.setString('ff_lastRecitation', _lastRecitation.serialize());
  }

  bool _downloadAudio = false;
  bool get downloadAudio => _downloadAudio;
  set downloadAudio(bool value) {
    _downloadAudio = value;
    prefs.setBool('ff_downloadAudio', value);
  }

  int _wordSpaceSeconds = 0;
  int get wordSpaceSeconds => _wordSpaceSeconds;
  set wordSpaceSeconds(int value) {
    _wordSpaceSeconds = value;
    prefs.setInt('ff_wordSpaceSeconds', value);
  }

  List<QuranInitialStruct> _QuranInitials = [
    QuranInitialStruct.fromSerializableMap(jsonDecode(
        '{\"surahId\":\"40\",\"verseId\":\"1\",\"positionId\":\"1\"}')),
    QuranInitialStruct.fromSerializableMap(jsonDecode(
        '{\"surahId\":\"2\",\"verseId\":\"1\",\"positionId\":\"1\"}')),
    QuranInitialStruct.fromSerializableMap(jsonDecode(
        '{\"surahId\":\"10\",\"verseId\":\"1\",\"positionId\":\"1\"}')),
    QuranInitialStruct.fromSerializableMap(jsonDecode(
        '{\"surahId\":\"26\",\"verseId\":\"1\",\"positionId\":\"1\"}')),
    QuranInitialStruct.fromSerializableMap(jsonDecode(
        '{\"surahId\":\"7\",\"verseId\":\"1\",\"positionId\":\"1\"}')),
    QuranInitialStruct.fromSerializableMap(jsonDecode(
        '{\"surahId\":\"13\",\"verseId\":\"1\",\"positionId\":\"1\"}')),
    QuranInitialStruct.fromSerializableMap(jsonDecode(
        '{\"surahId\":\"19\",\"verseId\":\"1\",\"positionId\":\"1\"}')),
    QuranInitialStruct.fromSerializableMap(jsonDecode(
        '{\"surahId\":\"20\",\"verseId\":\"1\",\"positionId\":\"1\"}')),
    QuranInitialStruct.fromSerializableMap(jsonDecode(
        '{\"surahId\":\"27\",\"verseId\":\"1\",\"positionId\":\"1\"}')),
    QuranInitialStruct.fromSerializableMap(jsonDecode(
        '{\"surahId\":\"36\",\"verseId\":\"1\",\"positionId\":\"1\"}')),
    QuranInitialStruct.fromSerializableMap(jsonDecode(
        '{\"surahId\":\"38\",\"verseId\":\"1\",\"positionId\":\"1\"}')),
    QuranInitialStruct.fromSerializableMap(jsonDecode(
        '{\"surahId\":\"42\",\"verseId\":\"2\",\"positionId\":\"1\"}')),
    QuranInitialStruct.fromSerializableMap(jsonDecode(
        '{\"surahId\":\"50\",\"verseId\":\"1\",\"positionId\":\"1\"}')),
    QuranInitialStruct.fromSerializableMap(jsonDecode(
        '{\"surahId\":\"68\",\"verseId\":\"1\",\"positionId\":\"1\"}'))
  ];
  List<QuranInitialStruct> get QuranInitials => _QuranInitials;
  set QuranInitials(List<QuranInitialStruct> value) {
    _QuranInitials = value;
  }

  void addToQuranInitials(QuranInitialStruct value) {
    QuranInitials.add(value);
  }

  void removeFromQuranInitials(QuranInitialStruct value) {
    QuranInitials.remove(value);
  }

  void removeAtIndexFromQuranInitials(int index) {
    QuranInitials.removeAt(index);
  }

  void updateQuranInitialsAtIndex(
    int index,
    QuranInitialStruct Function(QuranInitialStruct) updateFn,
  ) {
    QuranInitials[index] = updateFn(_QuranInitials[index]);
  }

  void insertAtIndexInQuranInitials(int index, QuranInitialStruct value) {
    QuranInitials.insert(index, value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
