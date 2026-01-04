import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flicknova/core/theme/app_colors.dart';

class YouTubePlayerWidget extends StatefulWidget {
  final String videoKey;
  final String title;

  const YouTubePlayerWidget({
    super.key,
    required this.videoKey,
    required this.title,
  });

  @override
  State<YouTubePlayerWidget> createState() => _YouTubePlayerWidgetState();
}

class _YouTubePlayerWidgetState extends State<YouTubePlayerWidget> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller =
        YoutubePlayerController(
          initialVideoId: widget.videoKey,
          flags: const YoutubePlayerFlags(
            mute: false,
            autoPlay: true,
            disableDragSeek: false,
            loop: false,
            isLive: false,
            forceHD: false,
            enableCaption: true,
          ),
        )..addListener(() {
          if (_isPlayerReady && mounted && _controller.value.isFullScreen) {
            setState(() {});
          }
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: YoutubePlayerBuilder(
        onExitFullScreen: () {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        },
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: AppColors.playButton,
          onReady: () {
            _isPlayerReady = true;
          },
          onEnded: (data) {
            // Optionally navigate back or show related videos
          },
        ),
        builder: (context, player) {
          return Column(
            children: [
              player,
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  color: AppColors.background,
                  child: Center(
                    child: Text(
                      'Now Playing: ${widget.title}',
                      style: const TextStyle(
                        color: AppColors.white600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
