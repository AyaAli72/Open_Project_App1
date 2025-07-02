import 'package:flutter/material.dart';
import 'sign_in_page.dart';

class MyDrawer_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 28, 37, 45),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person,
                        size: 40, color: const Color.fromARGB(255, 15, 18, 20)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Sign-in options

          _buildDrawerItem(
            context: context,
            text: "Sign In",
            icon: Icons.person,
            page: SignInPage(),
          ),
          Divider(),
          // Additional drawer items
          ListTile(
            leading: Icon(Icons.settings,
                color: const Color.fromARGB(255, 90, 97, 103)),
            title: Text('Settings', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle settings navigation
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:
                Icon(Icons.help, color: Color.fromARGB(255, 102, 111, 119)),
            title: Text('Help & Support', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle help navigation
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout,
                color: const Color.fromARGB(255, 96, 106, 115)),
            title: Text('Logout', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Handle logout
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required String text,
    required IconData icon,
    required Widget page,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color.fromARGB(255, 111, 120, 128)),
      title: Text(text, style: TextStyle(fontSize: 18)),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}
