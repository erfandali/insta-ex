import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math';
//uup
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

  // مدیریت همزمان فقط دو ویدیو بلند
  static final List<String> _activeIds = [];
  static final Map<String, VideoPlayerController> _activeControllers = {};

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
    _activeControllers.remove(uniqueId);
    _activeIds.remove(uniqueId);
    controller.dispose();
    super.dispose();
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction >= 0.6) {
      // اضافه کردن فقط در صورت نبود در لیست فعال‌ها
      if (!_activeIds.contains(uniqueId)) {
        _activeIds.add(uniqueId);
        _activeControllers[uniqueId] = controller;

        // اگر بیش از ۲ ویدیو فعال بودن، قدیمی‌ترین رو استپ کن
        while (_activeIds.length > 3) {
          String removedId = _activeIds.removeAt(0);
          _activeControllers[removedId]?.pause();
          _activeControllers.remove(removedId);
        }
      }

      controller.play();
      widget.onVisible(uniqueId, controller);
    } else {
      // اگر ویدیو از دید خارج شد، متوقفش کن
      if (_activeIds.contains(uniqueId)) {
        controller.pause();
        _activeIds.remove(uniqueId);
        _activeControllers.remove(uniqueId);
      }
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
