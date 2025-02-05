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
      _reciterUrl = prefs.getString('ff_reciterUrl') ?? _reciterUrl;
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

  String _reciterUrl =
      'https://podcasts.qurancentral.com/wadee-hammadi-al-yamani/wadee-hammadi-al-yamani-\${surah_id}-qurancentral.com.mp3';
  String get reciterUrl => _reciterUrl;
  set reciterUrl(String value) {
    _reciterUrl = value;
    prefs.setString('ff_reciterUrl', value);
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
