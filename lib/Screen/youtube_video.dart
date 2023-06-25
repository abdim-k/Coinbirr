import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideo extends StatefulWidget {
  const YoutubeVideo({Key? key}) : super(key: key);

  @override
  State<YoutubeVideo> createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  YoutubePlayerController videoController = YoutubePlayerController(
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
    initialVideoId: 'i3OVYC8MFDY',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            width: double.infinity,
            child: YoutubePlayer(
              controller: videoController,
              showVideoProgressIndicator: true,
              onReady: () {},
            )));
  }
}
