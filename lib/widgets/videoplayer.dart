import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../services/model.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Post post;

  const VideoPlayerWidget({Key? key, required this.post}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.post.videoLink)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        if (_controller.value.isInitialized)
          GestureDetector(
            onTap: () {
              setState(() {
                _isPlaying = !_isPlaying;
                _isPlaying ? _controller.play() : _controller.pause();
              });
            },
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          )
        else
          Image.network(
            widget.post.thumbnailUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        if (!_controller.value.isInitialized)
          Center(
            child: CircularProgressIndicator(color: Colors.blueGrey,),
          ),
        Positioned(
          bottom: 110,
          left: 20,
          right: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.post.title,
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'by ${widget.post.firstName} ${widget.post.lastName} (@${widget.post.username})',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          bottom: 90, 
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.thumb_up_outlined, color: Colors.white, size: 30),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.thumb_down_outlined, color: Colors.white, size: 30),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.comment, color: Colors.white, size: 30),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.share, color: Colors.white, size: 30),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.white, size: 30),
                onPressed: () {},
              ),
            ],
          ),
        ),
        if (_controller.value.isInitialized)
          Positioned(
            bottom: 70,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(_controller.value.position),
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      _formatDuration(_controller.value.duration),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Colors.red,
                    backgroundColor: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}





class FullScreenVideoPlayer extends StatefulWidget {
  final Post post;

  const FullScreenVideoPlayer({Key? key, required this.post}) : super(key: key);

  @override
  _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.post.videoLink)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? VideoPlayerWidget(post: widget.post)
                : Center(child: CircularProgressIndicator(color: Colors.blueGrey,)),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
