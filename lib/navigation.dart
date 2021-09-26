import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:physic/profile.dart';
import 'leaderboard.dart';
import 'homePage.dart';
import 'package:physic/Update.dart';

class Navigate extends StatefulWidget {
  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  final List<Widget> children = [
    HomePage(),
    LeaderboardPage(),
    Profile(),
    Update()
  ];
  int currentIndex=0;

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[currentIndex],
      bottomNavigationBar:CurvedNavigationBar(
        backgroundColor:Color(0xFF559584),
        color:  Color(0xFF17352E),
        buttonBackgroundColor: Color(0xFF17352E),
        height: 60,
        animationDuration: Duration(
          milliseconds: 200,
        ),
        animationCurve: Curves.bounceInOut,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.leaderboard,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.update,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: onTapped,
        index: currentIndex,
      ),
    );
  }
}
