import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math';

class TallVideo extends StatefulWidget {
  const TallVideo({Key? key, required this.post, required this.onVisible})
      : super(key: key);

  final Map<String, dynamic> post;
  final Function(String id, VideoPlayerController controller) onVisible;

  @override
  State<TallVideo> createState() => _TallVideoState();
}

class _TallVideoState extends State<TallVideo> {
  late VideoPlayerController controller;
  bool showShimmer = true;
  late final String uniqueId;

  @override
  void initState() {
    super.initState();
    uniqueId = widget.post['url'] + Random().nextInt(99999).toString();
    _initializeVideos();
  }

  void _initializeVideos() async {
    controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.post['url']),
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
        allowBackgroundPlayback: false,
      ),
    );
    await controller.initialize();
    controller.setLooping(true);
    controller.setVolume(0);
    if (mounted) {
      setState(() => showShimmer = false);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction >= 0.6) {
      widget.onVisible(uniqueId, controller); // اعلام کن که من باید پخش شم
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(uniqueId),
      onVisibilityChanged: _handleVisibilityChanged,
      child: InkWell(
        onTap: () {
          if (controller.value.isInitialized) {
            controller.play();
          }
        },
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
      ),
    );
  }
}
