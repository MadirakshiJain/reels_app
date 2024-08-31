import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class ReelsProvider extends ChangeNotifier {
  List<List<Post>> reels = [];
  bool isLoading = false;
  bool hasMore = true;
  int _page = 1;

  Future<void> fetchReels() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    notifyListeners();

    final url = 'https://api.wemotions.app/feed?page=$_page';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> postsJson = data['posts'];
        List<Post> fetchedPosts = postsJson.map((json) => Post.fromJson(json)).toList();

        if (fetchedPosts.isEmpty) {
          hasMore = false;
        } else {
          // Group the fetched posts into sets for horizontal scrolling
          for (int i = 0; i < fetchedPosts.length; i += 3) {
            reels.add(fetchedPosts.sublist(
              i, 
              i + 3 > fetchedPosts.length ? fetchedPosts.length : i + 3
            ));
          }
          _page++;
        }
      } else {
        throw Exception('Failed to load reels');
      }
    } catch (e) {
      print('Error fetching reels: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
