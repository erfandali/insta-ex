import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math';

class TallVideo extends StatefulWidget {
  const TallVideo({Key? key, required this.post}) : super(key: key);

  final Map<String, dynamic> post;

  @override
  State<TallVideo> createState() => _TallVideoState();
}

class _TallVideoState extends State<TallVideo> {
  late VideoPlayerController controller;
  bool showShimmer = true;
  late final String uniqueId;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    uniqueId = widget.post['url'] + Random().nextInt(99999).toString();
    _initializeVideo();
  }

  void _initializeVideo() async {
    try {
      controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.post['url']),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
          allowBackgroundPlayback: false,
        ),
      );
      
      // Add error handling and platform check
      if (!mounted) return;
      
      await controller.initialize().catchError((error) {
        print('Error initializing video: $error');
        if (mounted) {
          setState(() => showShimmer = false);
        }
      });
      
      if (!mounted) return;
      
      controller.setLooping(true);
      controller.setVolume(0);
      setState(() => showShimmer = false);
    } catch (e) {
      print('Error in _initializeVideo: $e');
      if (mounted) {
        setState(() => showShimmer = false);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    bool currentlyVisible = info.visibleFraction >= 0.6;

    if (currentlyVisible && !isVisible) {
      // ویدیو تازه دیده شده
      controller.play();
    } else if (!currentlyVisible && isVisible) {
      // ویدیو دیگه دیده نمیشه
      controller.pause();
    }

    isVisible = currentlyVisible;
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(uniqueId),
      onVisibilityChanged: _handleVisibilityChanged,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showShimmer)
            widget.post['postable_thumbnail'] != null &&
                    widget.post['postable_thumbnail'].toString().isNotEmpty
                ? Image.network(
                    widget.post['postable_thumbnail'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                    ),
                  )
          else
            VideoPlayer(controller),
          const Positioned(
            bottom: 4,
            right: 4,
            child: Icon(Icons.play_arrow, size: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
