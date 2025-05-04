import 'package:expllor/core/tallVideo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, dynamic>> rawPosts = [
    {'type': 'video', 'url': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/200/300'},
    {'type': 'video', 'url': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/250/400'},
    {'type': 'video', 'url': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/300/200'},
    {'type': 'video', 'url': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/350/250'},
    {'type': 'video', 'url': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/400/300'},    {'type': 'video', 'url': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/200/300'},
    {'type': 'video', 'url': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'},
        {'type': 'image', 'url': 'https://picsum.photos/300/200'},
    {'type': 'video', 'url': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/350/250'},
    {'type': 'video', 'url': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/400/300'},
    {'type': 'video', 'url': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'},
        {'type': 'image', 'url': 'https://picsum.photos/300/200'},
    {'type': 'video', 'url': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/350/250'},
    {'type': 'video', 'url': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/400/300'},
    {'type': 'image', 'url': 'https://picsum.photos/250/400'},
    {'type': 'video', 'url': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/300/200'},
    {'type': 'video', 'url': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/350/250'},
    {'type': 'video', 'url': 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/400/300'},


  ];

  final List<Map<String, dynamic>> arrangedPosts = [];
  int _currentTallColumn = 0; // 0=left, 2=right
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _prepareLayout();
  }

  Future<void> _prepareLayout() async {
    try {
      final videos = rawPosts.where((p) => p['type'] == 'video').toList();
      final images = rawPosts.where((p) => p['type'] == 'image').toList();

      int videoIndex = 0;
      int imageIndex = 0;
      int positionCounter = 0;

      while (videoIndex < videos.length || imageIndex < images.length) {
        if (videoIndex < videos.length && positionCounter % 5 == 0) {
          // Add tall video
          arrangedPosts.add({
            ...videos[videoIndex],
            'isTall': true,
            'column': _currentTallColumn,
          });
          videoIndex++;
          
          // Alternate columns
          _currentTallColumn = _currentTallColumn == 0 ? 2 : 0;
          
          // Add 4 regular items
          for (int i = 0; i < 4; i++) {
            if (imageIndex < images.length) {
              arrangedPosts.add({
                ...images[imageIndex],
                'isTall': false,
                'column': _getOppositeColumn(_currentTallColumn, i),
              });
              imageIndex++;
            } else if (videoIndex < videos.length) {
              arrangedPosts.add({
                ...videos[videoIndex],
                'isTall': false,
                'column': _getOppositeColumn(_currentTallColumn, i),
              });
              videoIndex++;
            }
          }
        } else {
          // Add regular item
          if (imageIndex < images.length) {
            arrangedPosts.add({
              ...images[imageIndex],
              'isTall': false,
              'column': -1, // Auto-position
            });
            imageIndex++;
          } else if (videoIndex < videos.length) {
            arrangedPosts.add({
              ...videos[videoIndex],
              'isTall': false,
              'column': -1,
            });
            videoIndex++;
          }
        }
        positionCounter++;
      }
    } catch (e) {
      debugPrint('Layout preparation error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  int _getOppositeColumn(int tallColumn, int index) {
    return tallColumn == 0 ? [1, 2][index % 2] : [0, 1][index % 2];
  }

  Widget _buildMediaWidget(int index) {
    final post = arrangedPosts[index];
    
    if (post['type'] == 'image') {
      return _buildImageWidget(post);
    }
    
    return post['isTall'] 
      ? TallVideo(post: post)
      : _buildVideoPlaceholder();
  }

  Widget _buildImageWidget(Map<String, dynamic> post) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          post['url'],
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, color: Colors.white),
          ),
        ),
        const Positioned(
          bottom: 4,
          right: 4,
          child: Icon(Icons.photo, size: 16, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildVideoPlaceholder() {
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
          _buildSearchBar(),
          Expanded(
            child: _isLoading
              ? _buildLoadingIndicator()
              : _buildContentGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
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
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContentGrid() {
    return  Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: StaggeredGrid.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    children: [
                      for (int i = 0; i < arrangedPosts.length; i++)
                        StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: arrangedPosts[i]['isTall'] ? 2 : 1,
                          child: Container(
                            color: Colors.grey[300],
                            child: _buildMediaWidget(i),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );

  }
}
