import 'package:flutter/material.dart';
import 'package:reels_app/screens/profile.dart';
import 'package:reels_app/screens/reels.dart';
import 'package:reels_app/screens/search.dart';

class TransparentNavBar extends StatefulWidget {
  @override
  _TransparentNavBarState createState() => _TransparentNavBarState();
}

class _TransparentNavBarState extends State<TransparentNavBar> {
  int _selectedIndex = 0;

  // List of pages
  final List<Widget> _pages = [
    ReelsScreen(),
    SearchPage(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, 
      body: _pages[_selectedIndex], 
      bottomNavigationBar: Container(
        
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30), 
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.black.withOpacity(0.5), 
            elevation: 0, // Removes the shadow
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.amber.shade700,
            unselectedItemColor: Colors.white.withOpacity(0.7),
            showSelectedLabels: false,
            showUnselectedLabels: false, 
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30),
                label: '', 
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.language, size: 30),
                label: '', 
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30),
                label: '', 
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
