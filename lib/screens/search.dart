import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reels_app/services/videoAPI.dart';
import 'package:reels_app/widgets/videoplayer.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reelsProvider = Provider.of<ReelsProvider>(context);
    final allPosts = reelsProvider.reels.expand((reelSet) => reelSet).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Expanded(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.white70,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('Assets/girl.png'), 
                      backgroundColor: Colors.white, 
                    ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Madirakshi', style: TextStyle(color: Colors.white, fontSize: 20)),
                    Text('20 videos', style: TextStyle(color: Colors.white, fontSize: 15)),
                    Text('The Best Vibes!', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 231, 174, 3)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                 ),
                  ),
                ),
                onPressed: () {
                  // Define your action here
                },
                child: Text('Upload', style: TextStyle(color: Colors.white)),
              ),
            ],
            ),
           ),
 
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns in the grid
                  childAspectRatio: 9 / 16, // Aspect ratio for each grid item
                ),
                itemCount: allPosts.length,
                itemBuilder: (context, index) {
                  final post = allPosts[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5), 
                      borderRadius: BorderRadius.circular(8), 
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenVideoPlayer(post: post),
                          ),
                        );
                      },
                      child: Image.network(
                        post.thumbnailUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
