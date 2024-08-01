import 'package:flutter/material.dart';
import 'package:todo_app/pages/Login.dart';
import 'package:todo_app/pages/ProfilePage.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/utils/GoogleSignIn.dart';

class MyDrawer extends StatelessWidget {
  final ThemeProvider themeProvider;

  const MyDrawer({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
      final GoogleSignInProvider _googleSignInProvider = GoogleSignInProvider();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 150,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    // color: Colors.white, // Border color
                    width: 2.0, // Border width
                  ),
                ),
              ),
              child: const Center(
                child: Text(
                  'TADA TODO',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer
              // Navigate to home screen
            },
          ),
          ListTile(
            leading: Icon(Icons.task),
            title: const Text('Tasks'),
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer
              // Navigate to tasks screen
            },
          ),
          ListTile(
            leading: Icon(Icons.done_all),
            title: const Text('Completed Tasks'),
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer
              // Navigate to completed tasks screen
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer
              // Navigate to settings screen
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=> ProfilePage())
              ); // Close the drawer
              // Navigate to profile screen
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: const Text('Search'),
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer
              // Open search
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: const Text('Help & Support'),
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer
              // Navigate to help & support
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer
              // Navigate to notifications settings
            },
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: const Text('Switch Theme'),
            onTap: () {
              Navigator.of(context).pop(); // Close the drawer
              themeProvider.switchTheme(); // Switch the theme
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async{
              await _googleSignInProvider.signOutGoogle();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginPage())); // Close the drawer
              // Implement logout functionality
            },
          ),
        ],
      ),
    );
  }
}
