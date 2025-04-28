import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import '../core/tallVideo.dart'; // ویجت مخصوص ویدیوی بلنده

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, dynamic>> rawPosts = [
    {'type': 'video', 'url': 'https://v.ftcdn.net/11/21/46/21/240_F_1121462188_3P2cGXzNE4ZLKOvrYaB2MZAGHXXhycP2_ST.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/201'},
    {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4'},
    {'type': 'video', 'url': 'https://v.ftcdn.net/11/21/46/21/240_F_1121462188_3P2cGXzNE4ZLKOvrYaB2MZAGHXXhycP2_ST.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/203'},
    {'type': 'image', 'url': 'https://picsum.photos/204'},
    {'type': 'video', 'url': 'https://v.ftcdn.net/11/21/46/21/240_F_1121462188_3P2cGXzNE4ZLKOvrYaB2MZAGHXXhycP2_ST.mp4'},
     {'type': 'video', 'url': 'https://v.ftcdn.net/11/21/46/21/240_F_1121462188_3P2cGXzNE4ZLKOvrYaB2MZAGHXXhycP2_ST.mp4'},
      {'type': 'video', 'url': 'https://v.ftcdn.net/11/21/46/21/240_F_1121462188_3P2cGXzNE4ZLKOvrYaB2MZAGHXXhycP2_ST.mp4'},
       {'type': 'video', 'url': 'https://v.ftcdn.net/11/21/46/21/240_F_1121462188_3P2cGXzNE4ZLKOvrYaB2MZAGHXXhycP2_ST.mp4'},
    {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4'},
     {'type': 'image', 'url': 'https://picsum.photos/203'},
    {'type': 'image', 'url': 'https://picsum.photos/204'},
    {'type': 'video', 'url': 'https://v.ftcdn.net/11/21/46/21/240_F_1121462188_3P2cGXzNE4ZLKOvrYaB2MZAGHXXhycP2_ST.mp4'},
     {'type': 'video', 'url': 'https://v.ftcdn.net/11/21/46/21/240_F_1121462188_3P2cGXzNE4ZLKOvrYaB2MZAGHXXhycP2_ST.mp4'},
      {'type': 'video', 'url': 'https://v.ftcdn.net/11/21/46/21/240_F_1121462188_3P2cGXzNE4ZLKOvrYaB2MZAGHXXhycP2_ST.mp4'},
          {'type': 'image', 'url': 'https://picsum.photos/204'},
              {'type': 'image', 'url': 'https://picsum.photos/204'},
       {'type': 'video', 'url': 'https://v.ftcdn.net/11/21/46/21/240_F_1121462188_3P2cGXzNE4ZLKOvrYaB2MZAGHXXhycP2_ST.mp4'},
                {'type': 'video', 'url': 'https://v.ftcdn.net/11/21/46/21/240_F_1121462188_3P2cGXzNE4ZLKOvrYaB2MZAGHXXhycP2_ST.mp4'},
                       {'type': 'video', 'url': 'https://v.ftcdn.net/11/21/46/21/240_F_1121462188_3P2cGXzNE4ZLKOvrYaB2MZAGHXXhycP2_ST.mp4'},     
    {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/204'},
    {'type': 'image', 'url': 'https://picsum.photos/204'},
    {'type': 'image', 'url': 'https://picsum.photos/204'},
    {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/204'},
    {'type': 'image', 'url': 'https://picsum.photos/204'},
    {'type': 'image', 'url': 'https://picsum.photos/204'},
    {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4'},
    {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/204'},
    {'type': 'image', 'url': 'https://picsum.photos/204'},
    {'type': 'image', 'url': 'https://picsum.photos/204'},
    {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4'},
    {'type': 'video', 'url': 'https://v.ftcdn.net/11/21/46/21/240_F_1121462188_3P2cGXzNE4ZLKOvrYaB2MZAGHXXhycP2_ST.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/204'},
    {'type': 'image', 'url': 'https://picsum.photos/204'},
    {'type': 'image', 'url': 'https://picsum.photos/204'},
    {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4'},
        {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4'},
            {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4'},
                {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4'},
  ];

  final List<Map<String, dynamic>> arrangedPosts = [];
  final List<int> tallPositions = [];

  @override
  void initState() {
    super.initState();
    _prepareLayout();
  }

  void _prepareLayout() {
    List<Map<String, dynamic>> videos = [];
    List<Map<String, dynamic>> others = [];

    for (var post in rawPosts) {
      if (post['type'] == 'video') {
        videos.add(post);
      } else {
        others.add(post);
      }
    }

    int videoCounter = 0;
    bool placeLeft = true; // اول بلند چپ قرار بگیره

    while (videos.isNotEmpty || others.isNotEmpty) {
      if (videos.isNotEmpty) {
        var video = videos.removeAt(0);
        bool isTall = (videoCounter % 5 == 0);

        if (isTall) {
          // اگه Tall بود:
          if (placeLeft) {
            arrangedPosts.add(video..['isTall'] = true);
            tallPositions.add(arrangedPosts.length - 1);
            for (int i = 0; i < 4 && others.isNotEmpty; i++) {
              arrangedPosts.add(others.removeAt(0));
            }
          } else {
            for (int i = 0; i < 4 && others.isNotEmpty; i++) {
              arrangedPosts.add(others.removeAt(0));
            }
            arrangedPosts.add(video..['isTall'] = true);
            tallPositions.add(arrangedPosts.length - 1);
          }
          placeLeft = !placeLeft;
        } else {
          arrangedPosts.add(video..['isTall'] = false);
        }

        videoCounter++;
      } else {
        arrangedPosts.addAll(others);
        others.clear();
      }
    }
  }

  Widget _buildMediaWidget(int index) {
    final post = arrangedPosts[index];
    final bool isTall = post['isTall'] == true;

    if (post['type'] == 'image') {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.network(post['url'], fit: BoxFit.cover),
          const Positioned(
            bottom: 4,
            right: 4,
            child: Icon(Icons.photo, size: 16, color: Colors.white),
          ),
        ],
      );
    }

    if (!isTall) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(color: Colors.grey[300]),
          ),
          const Center(
            child: Icon(Icons.play_circle_fill, size: 40, color: Colors.white70),
          ),
        ],
      );
    }

    return TallVideo(post: post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(11),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: StaggeredGrid.count(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                children: List.generate(arrangedPosts.length, (index) {
                  final isTall = tallPositions.contains(index);

                  return StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: isTall ? 2 : 1,
                    child: Container(
                      color: Colors.grey[300],
                      child: _buildMediaWidget(index),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
