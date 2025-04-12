// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:audio_session/audio_session.dart';

class WordsAudioWidget extends StatefulWidget {
  const WordsAudioWidget({
    super.key,
    this.width,
    this.height,
    required this.audioList,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.errorMessage = "An error occurred during playback.",
    this.arabicFontSize = 20.0,
    this.arabicFontFamily,
    this.transliterationFontSize = 16.0,
    this.transliterationFontFamily,
  });

  final double? width;
  final double? height;
  final List<AudioItemStruct> audioList;
  final Color primaryColor;
  final Color secondaryColor;
  final String errorMessage;

  final double arabicFontSize;
  final String? arabicFontFamily;
  final double transliterationFontSize;
  final String? transliterationFontFamily;

  @override
  State<WordsAudioWidget> createState() => _WordsAudioWidgetState();
}

class _WordsAudioWidgetState extends State<WordsAudioWidget> {
  final _player = AudioPlayer();
  String? _error;
  int _currentIndex = 0;
  bool _autoPlay = false;
  bool _loopPlayback = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initAudioSession();
    _loadAudio(_currentIndex);
    _player.playerStateStream.listen((state) {
      if (_autoPlay && state.processingState == ProcessingState.completed) {
        Future.delayed(Duration(seconds: FFAppState().wordSpaceSeconds), () {
          if (mounted) {
            _playNext();
          }
        });
      }
    });
  }

  Future<void> _initAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());
  }

  Future<String?> _getCachedAudioPath(String url) async {
    final dir = await getApplicationDocumentsDirectory();
    final filename = url.split('/').last;
    final filePath = '${dir.path}/$filename';
    final file = File(filePath);

    if (await file.exists()) {
      return filePath;
    } else if (FFAppState().downloadAudio) {
      try {
        await Dio().download(url, filePath);
        return filePath;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> _loadAudio(int index) async {
    final audioUrl = widget.audioList[index].audioUrl;

    if (audioUrl == null || audioUrl.isEmpty) {
      if (!mounted) return;
      setState(() {
        _error =
            "Could not load audio. Check your internet connection or enable download mode.";
        _isLoading = false;
      });
      return;
    }

    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final cachedPath = await _getCachedAudioPath(audioUrl);
      if (!mounted) return;

      if (cachedPath != null) {
        await _player.setFilePath(cachedPath);
        await _player.play();
      } else {
        await _player.setUrl(audioUrl);
        await _player.play();
      }

      if (!mounted) return;
      setState(() {
        _error = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = widget.errorMessage;
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _playNext() {
    if (_currentIndex < widget.audioList.length - 1) {
      setState(() => _currentIndex++);
      _loadAudio(_currentIndex);
    } else if (_loopPlayback && widget.audioList.length > 1) {
      setState(() => _currentIndex = 0);
      _loadAudio(_currentIndex);
    }
  }

  void _playPrevious() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      _loadAudio(_currentIndex);
    }
  }

  void _repeatCurrentAudio() {
    _loadAudio(_currentIndex);
  }

  void _toggleAutoPlay() {
    setState(() {
      _autoPlay = !_autoPlay;
    });
    if (_autoPlay) {
      _loadAudio(_currentIndex);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentAudio = widget.audioList[_currentIndex];

    return Container(
      width: widget.width,
      height: widget.height,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "${_currentIndex + 1} / ${widget.audioList.length}",
            style: TextStyle(color: widget.primaryColor, fontSize: 18),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                _autoPlay ? Icons.playlist_remove : Icons.playlist_play,
                color: widget.primaryColor,
              ),
              tooltip: _autoPlay ? "Disable Auto-Play" : "Enable Auto-Play",
              onPressed: _toggleAutoPlay,
            ),
            IconButton(
              icon: Icon(
                _loopPlayback ? Icons.repeat : Icons.repeat_one,
                color: widget.primaryColor,
              ),
              tooltip: _loopPlayback ? "Disable Looping" : "Enable Looping",
              onPressed: () {
                setState(() {
                  _loopPlayback = !_loopPlayback;
                });
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12),
                  child: Text(
                    currentAudio.arabicText ?? "",
                    style: TextStyle(
                      fontSize: widget.arabicFontSize,
                      fontWeight: FontWeight.normal,
                      fontFamily: widget.arabicFontFamily,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    textHeightBehavior: TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    currentAudio.transliteration ?? "",
                    style: TextStyle(
                      fontSize: widget.transliterationFontSize,
                      fontFamily: widget.transliterationFontFamily,
                      color: widget.secondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.skip_previous,
                              color: widget.primaryColor),
                          iconSize: 24,
                          onPressed: _currentIndex > 0 ? _playPrevious : null,
                        ),
                        Text("Previous Word",
                            style: TextStyle(color: widget.primaryColor)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: _isLoading
                            ? SizedBox(
                                key: ValueKey('loading'),
                                height: 36,
                                width: 36,
                                child: CircularProgressIndicator(
                                  strokeWidth: 4,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      widget.primaryColor),
                                ),
                              )
                            : IconButton(
                                key: ValueKey('replayIcon'),
                                icon: Icon(Icons.replay,
                                    color: widget.primaryColor),
                                iconSize: 36,
                                onPressed: _repeatCurrentAudio,
                              ),
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon:
                              Icon(Icons.skip_next, color: widget.primaryColor),
                          iconSize: 24,
                          onPressed:
                              _currentIndex < widget.audioList.length - 1 ||
                                      _loopPlayback
                                  ? _playNext
                                  : null,
                        ),
                        Text("Next Word",
                            style: TextStyle(color: widget.primaryColor)),
                      ],
                    ),
                  ],
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      _error!,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
