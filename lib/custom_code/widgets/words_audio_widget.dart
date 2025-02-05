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

import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

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

  // Font customization
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
  bool _autoPlay = false; // Toggle for automatic playback
  bool _loopPlayback = false; // Toggle for looping playback

  @override
  void initState() {
    super.initState();
    _loadAudio(_currentIndex);
    _player.playerStateStream.listen((state) {
      if (_autoPlay && state.processingState == ProcessingState.completed) {
        _playNext();
      }
    });
  }

  Future<void> _loadAudio(int index) async {
    final audioUrl = widget.audioList[index].audioUrl;

    if (audioUrl == null || audioUrl.isEmpty) {
      setState(() {
        _error = "Audio URL is missing.";
      });
      return;
    }

    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(audioUrl)));
      await _player.play();
      setState(() {
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = "Error loading audio: $e";
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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_error != null) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _error!,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ] else ...[
                  Flexible(
                    child: Text(
                      currentAudio.arabicText ?? "",
                      style: TextStyle(
                        fontSize: widget.arabicFontSize,
                        fontWeight: FontWeight.normal,
                        fontFamily: widget.arabicFontFamily,
                        color: widget.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Flexible(
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
                            iconSize: 36,
                            onPressed: _currentIndex > 0 ? _playPrevious : null,
                          ),
                          Text("Previous Word",
                              style: TextStyle(color: widget.primaryColor)),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.replay, color: widget.primaryColor),
                        iconSize: 64,
                        onPressed: _repeatCurrentAudio,
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.skip_next,
                                color: widget.primaryColor),
                            iconSize: 36,
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
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
