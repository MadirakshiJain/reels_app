import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reels_app/services/videoAPI.dart';
import 'package:reels_app/widgets/videoplayer.dart';

class ReelsScreen extends StatefulWidget {
  @override
  _ReelsScreenState createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _verticalPageController = PageController();

  @override
  void initState() {
    super.initState();
    final reelsProvider = Provider.of<ReelsProvider>(context, listen: false);
    reelsProvider.fetchReels();
  }

  @override
  void dispose() {
    _verticalPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<ReelsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.reels.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return PageView.builder(
              controller: _verticalPageController,
              scrollDirection: Axis.vertical,
              itemCount: provider.reels.length,
              onPageChanged: (index) {
                if (index == provider.reels.length - 1 && provider.hasMore) {
                  provider.fetchReels();
                }
              },
              itemBuilder: (context, verticalIndex) {
                final reelSet = provider.reels[verticalIndex];
                return PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: reelSet.length,
                  itemBuilder: (context, horizontalIndex) {
                    final post = reelSet[horizontalIndex];
                    return VideoPlayerWidget(post: post);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
