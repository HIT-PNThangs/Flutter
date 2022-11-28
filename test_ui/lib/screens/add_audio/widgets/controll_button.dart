import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 50.0,
                height: 50.0,
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                ),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                ),
                iconSize: 50.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(
                  Icons.pause,
                  color: Colors.black,
                ),
                iconSize: 50.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(
                  Icons.replay,
                  color: Colors.black,
                ),
                iconSize: 50.0,
                onPressed: () => player.seek(Duration.zero, index: player.effectiveIndices!.first),
              );
            }
          },
        ),
      ],
    );
  }
}
