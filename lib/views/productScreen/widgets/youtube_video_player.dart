import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/models/youtube_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  final YoutubeVideo youtubeVideo;

  const YoutubeVideoPlayer({this.youtubeVideo});
  @override
  _YoutubeVideoPlayerState createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    String videoURL;
    try {
      videoURL = widget.youtubeVideo.url
          .split('v=')[widget.youtubeVideo.url.split('v=').length - 1];
    } catch (_) {}
    var _controller = YoutubePlayerController(
        initialVideoId: videoURL,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          enableCaption: false,
          mute: false,
        ));

    return videoURL != null
        ? Card(
            elevation: 4.0,
            child: Column(
              children: [
                Container(
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Palette.midBlue,
                    progressColors: ProgressBarColors(
                      playedColor: Palette.midBlue,
                      handleColor: Palette.lightBlue,
                    ),
                    onReady: () {
                      // _controller.addListener(listener);
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  margin: EdgeInsets.all(10),
                  child: Text(
                    widget.youtubeVideo.title,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  margin: EdgeInsets.all(10),
                  child: Text(
                    widget.youtubeVideo.description,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Palette.black,
                    ),
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
