import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SmartTallVideoPlayer extends StatefulWidget {
  final Map<String, dynamic> post;
  final ValueNotifier<String?> activeVideoIdNotifier;

  const SmartTallVideoPlayer({
    Key? key,
    required this.post,
    required this.activeVideoIdNotifier,
  }) : super(key: key);

  @override
  State<SmartTallVideoPlayer> createState() => _SmartTallVideoPlayerState();
}

class _SmartTallVideoPlayerState extends State<SmartTallVideoPlayer> {
  late final VideoPlayerController _controller;
  late final String videoId;

  @override
  void initState() {
    super.initState();
    videoId = widget.post['url'];
    _controller = VideoPlayerController.network(videoId)
      ..setLooping(true)
      ..setVolume(0.0)
      ..initialize().then((_) => setState(() {}));

    widget.activeVideoIdNotifier.addListener(_onActiveVideoChanged);
  }

  void _onActiveVideoChanged() {
    if (widget.activeVideoIdNotifier.value == videoId) {
      _controller.play();
    } else {
      _controller.pause();
    }
  }

  @override
  void dispose() {
    widget.activeVideoIdNotifier.removeListener(_onActiveVideoChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(videoId),
      onVisibilityChanged: (VisibilityInfo info) {
        final visibleFraction = info.visibleFraction;
        if (visibleFraction >= 0.6) {
          widget.activeVideoIdNotifier.value = videoId;
        }
      },
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
 