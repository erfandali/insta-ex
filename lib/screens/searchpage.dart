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
  bool _isLoading = true;
  int _layoutPatternIndex = 0; // Tracks which layout pattern we're on (0: |:: or 1: ::| )

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
      int itemCount = 0;
      
      // Process items in groups of 5 (1 tall + 4 squares)
      while ((videoIndex < videos.length || imageIndex < images.length) && itemCount < 100) {
        // Determine if we're in a |:: pattern (0) or a ::| pattern (1)
        bool isTallVideoOnLeft = _layoutPatternIndex % 2 == 0;
        
        // We need at least one video for the tall slot
        if (videoIndex >= videos.length) break;
        
        // Process a group of 5 items (1 tall video + 4 squares)
        // First, add the tall video on the left or right based on pattern
        if (isTallVideoOnLeft) {
          // |:: pattern - Tall video on left
          arrangedPosts.add({
            ...videos[videoIndex++],
            'isTall': true,
            'position': 'left',
          });
          
          // Add 4 square items on the right
          for (int i = 0; i < 4; i++) {
            if (imageIndex < images.length) {
              arrangedPosts.add({
                ...images[imageIndex++],
                'isTall': false,
                'position': 'right',
                'squareIndex': i,
              });
            } else if (videoIndex < videos.length) {
              arrangedPosts.add({
                ...videos[videoIndex++],
                'isTall': false,
                'position': 'right',
                'squareIndex': i,
              });
            }
          }
        } else {
          // ::| pattern - 4 square items on left
          for (int i = 0; i < 4; i++) {
            if (imageIndex < images.length) {
              arrangedPosts.add({
                ...images[imageIndex++],
                'isTall': false,
                'position': 'left',
                'squareIndex': i,
              });
            } else if (videoIndex < videos.length) {
              arrangedPosts.add({
                ...videos[videoIndex++],
                'isTall': false,
                'position': 'left',
                'squareIndex': i,
              });
            }
          }
          
          // Tall video on right
          arrangedPosts.add({
            ...videos[videoIndex++],
            'isTall': true,
            'position': 'right',
          });
        }
        
        // Move to next pattern
        _layoutPatternIndex++;
        itemCount += 5;
      }
    } catch (e) {
      debugPrint('Layout preparation error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
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
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double screenWidth = constraints.maxWidth;
          // Add extra padding to account for rounding errors
          final double safeWidth = screenWidth - 4;
          
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                children: [
                  for (int patternIndex = 0; patternIndex < _layoutPatternIndex; patternIndex++)
                    Container(
                      width: screenWidth,
                      margin: const EdgeInsets.only(bottom: 2),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 2,
                        runSpacing: 2,
                        children: [
                          if (patternIndex % 2 == 0) ...[
                            // |:: pattern
                            // Tall video on left (1/3 of screen width)
                            Container(
                              width: safeWidth / 3 - 4,
                              height: (safeWidth / 3) * 2 - 4,
                              margin: const EdgeInsets.all(1),
                              child: _buildMediaWidget(patternIndex * 5),
                            ),
                            
                            // Create a container for the 2x2 grid on the right
                            Container(
                              width: (safeWidth * 2 / 3) - 2,
                              child: Wrap(
                                spacing: 2,
                                runSpacing: 2,
                                children: [
                                  _buildSquareItem(patternIndex * 5 + 1, safeWidth),
                                  _buildSquareItem(patternIndex * 5 + 2, safeWidth),
                                  _buildSquareItem(patternIndex * 5 + 3, safeWidth),
                                  _buildSquareItem(patternIndex * 5 + 4, safeWidth),
                                ],
                              ),
                            ),
                          ] else ...[
                            // ::| pattern
                            // Create a container for the 2x2 grid on the left
                            Container(
                              width: (safeWidth * 2 / 3) - 2,
                              child: Wrap(
                                spacing: 2,
                                runSpacing: 2,
                                children: [
                                  _buildSquareItem(patternIndex * 5, safeWidth),
                                  _buildSquareItem(patternIndex * 5 + 1, safeWidth),
                                  _buildSquareItem(patternIndex * 5 + 2, safeWidth),
                                  _buildSquareItem(patternIndex * 5 + 3, safeWidth),
                                ],
                              ),
                            ),
                            
                            // Tall video on right
                            Container(
                              width: safeWidth / 3 - 4,
                              height: (safeWidth / 3) * 2 - 4,
                              margin: const EdgeInsets.all(1),
                              child: _buildMediaWidget(patternIndex * 5 + 4),
                            ),
                          ],
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSquareItem(int index, double screenWidth) {
    if (index >= arrangedPosts.length) {
      return Container(); // Empty container if index out of bounds
    }
    
    final itemSize = (screenWidth / 3) - 4;
    
    return Container(
      width: itemSize,
      height: itemSize,
      margin: const EdgeInsets.all(1),
      child: _buildMediaWidget(index),
    );
  }
}
