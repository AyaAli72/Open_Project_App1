import 'package:flutter/material.dart';

class MyDrawer_Page extends StatefulWidget {
  @override
  _MyDrawer_PageState createState() => _MyDrawer_PageState();
}

class _MyDrawer_PageState extends State<MyDrawer_Page> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'Profile Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
