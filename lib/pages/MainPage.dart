import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/FlexTextfield.dart';
import 'package:todo_app/components/TaskBox.dart';
import 'package:todo_app/components/TaskProgress.dart';
import 'package:todo_app/pages/AddPage.dart';
import 'package:todo_app/providers/theme_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double progress = 10;
  Timer? _timer;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _checkProgress();
  }

  void _checkProgress() {
    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      if (progress >= 100) {
        timer.cancel();
      } else {
        setState(() {
          progress += 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: _AppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 150,
              child: Container(
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'Header',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Switch Theme'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                themeProvider.switchTheme(); // Switch the theme
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
              16.0), // Add padding to avoid content touching edges
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Hi Jason"),
              const Text(
                "Be productive today",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const FlexTextfield(),
              const SizedBox(height: 20),
              const TaskProgress(),
              const SizedBox(height: 20),
              const Tasksbox(),
              const SizedBox(height: 20),
              const Text(
                "Urgent Tasks",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
              
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(height: 80,width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                color: const Color.fromRGBO(35, 34, 40, 1),
                   borderRadius: BorderRadius.circular(18)
                 ),
                 child:const  Padding(
                   padding: EdgeInsets.all(18.0),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        child: Text("20"),
                      ),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("Write a Post on Linkedin"),
                           Text("7 PM, 24 March", style: TextStyle(fontSize: 10, color: Colors.grey),)
                         ],
                       ),
                       Text("Left")
                    ],
                   ),
                 ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(height: 80,width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                color: const Color.fromRGBO(35, 34, 40, 1),
                   borderRadius: BorderRadius.circular(18)
                 ),
                 child: const Padding(
                   padding: EdgeInsets.all(18.0),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        child: Text("20"),
                      ),
                       Text("Write a Post on Linkedin"),
                       Text("Left")
                    ],
                   ),
                 ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(height: 80,width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                color: const Color.fromRGBO(35, 34, 40, 1),
                   borderRadius: BorderRadius.circular(18)
                 ),
                 child: const Padding(
                   padding: EdgeInsets.all(18.0),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        child: Text("20"),
                      ),
                       Text("Write a Post on Linkedin"),
                       Text("Left")
                    ],
                   ),
                 ),
                 ),
               )
            ],
          ),
        ),
      ),
       floatingActionButton: Container(
        width: MediaQuery.of(context).size.width - 80,
         child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddTask()));
          },
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add Task",
                style: TextStyle(fontSize: 16), // Adjust font size if needed
              ),
              Icon(Icons.add), // Icon for the button
              SizedBox(width: 8), // Space between the icon and text
            ],
          ),
               ),
       ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Default location
   
    );
  }

  _AppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.dashboard),
        onPressed: () {
          _scaffoldKey.currentState
              ?.openDrawer(); // Use the key to open the drawer
        },
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(18.0),
          child: Icon(Icons.notifications),
        )
      ],
    );
  }
}
