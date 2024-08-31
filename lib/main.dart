import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reels_app/widgets/bottomnav.dart';
import 'package:reels_app/services/videoAPI.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReelsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TransparentNavBar()),
    );
  
  }
}

