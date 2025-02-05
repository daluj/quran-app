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

import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioWidget extends StatefulWidget {
  const AudioWidget({
    super.key,
    this.width,
    this.height,
    this.audioUrl,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.errorMessage = "An error occurred during playback.",
  });

  final double? width;
  final double? height;
  final String? audioUrl;
  final Color primaryColor;
  final Color secondaryColor;
  final String errorMessage;

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  final _player = AudioPlayer();
  String? _error;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Configure the audio session for background playback
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      androidAudioAttributes: AndroidAudioAttributes(
        usage: AndroidAudioUsage.media,
        contentType: AndroidAudioContentType.music,
      ),
      androidWillPauseWhenDucked: false,
    ));

    // Listen to playback errors
    _player.playbackEventStream.listen(
      (event) {},
      onError: (Object e, StackTrace stackTrace) {
        setState(() {
          _error = widget.errorMessage;
        });
      },
    );

    // Attempt to preload and play the audio
    try {
      if (widget.audioUrl != null) {
        await _player.setAudioSource(
          AudioSource.uri(Uri.parse(widget.audioUrl!)),
          preload: true, // Preloading the audio
        );
        await _player.play(); // Automatically start playing
      } else {
        setState(() {
          _error = "Audio URL is null.";
        });
      }
    } catch (e) {
      setState(() {
        _error = "Error loading audio source: $e";
      });
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_error != null) ...[
                Text(
                  _error!,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ] else ...[
                ControlButtons(
                  _player,
                  primaryColor: widget.primaryColor,
                  secondaryColor: widget.secondaryColor,
                ),
                StreamBuilder<PositionData>(
                  stream: _positionDataStream,
                  builder: (context, snapshot) {
                    final positionData = snapshot.data;
                    return SeekBar(
                      duration: positionData?.duration ?? Duration.zero,
                      position: positionData?.position ?? Duration.zero,
                      bufferedPosition:
                          positionData?.bufferedPosition ?? Duration.zero,
                      onChangeEnd: _player.seek,
                      primaryColor: widget.primaryColor,
                      secondaryColor: widget.secondaryColor,
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream,
        _player.bufferedPositionStream,
        _player.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;
  final Color primaryColor;
  final Color secondaryColor;

  const ControlButtons(
    this.player, {
    Key? key,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Play/Pause Button
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return CircularProgressIndicator(color: primaryColor);
            } else if (playing != true) {
              return IconButton(
                icon: Icon(Icons.play_arrow, color: primaryColor),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: Icon(Icons.pause, color: primaryColor),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: Icon(Icons.replay, color: primaryColor),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
      ],
    );
  }
}

class SeekBar extends StatelessWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChangeEnd;
  final Color primaryColor;
  final Color secondaryColor;

  const SeekBar({
    Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChangeEnd,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          min: 0.0,
          max: duration.inMilliseconds.toDouble(),
          value: position.inMilliseconds
              .toDouble()
              .clamp(0.0, duration.inMilliseconds.toDouble()),
          activeColor: primaryColor,
          inactiveColor: secondaryColor,
          onChanged: (value) {
            if (onChangeEnd != null) {
              onChangeEnd!(Duration(milliseconds: value.round()));
            }
          },
        ),
        Text(
          "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')} / ${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
        ),
      ],
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
