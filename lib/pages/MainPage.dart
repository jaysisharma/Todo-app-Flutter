import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/components/Drawer.dart';
import 'package:todo_app/components/FlexTextfield.dart';
import 'package:todo_app/components/TaskBox.dart';
import 'package:todo_app/components/TaskProgress.dart';
import 'package:todo_app/pages/AddPage.dart';
import 'package:todo_app/pages/Login.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/utils/Shared_Pref.dart'; // Update or remove if using Firestore

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double progress = 10;
  Timer? _timer;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<Map<String, dynamic>>> _todoListFuture;

  @override
  void initState() {
    super.initState();
    _checkProgress();
    _refreshTodoList();
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

  Future<void> _refreshTodoList() async {
    // Replace with Firebase logic to fetch tasks if needed
    // Example: Fetch tasks from Firestore
    setState(() {
      _todoListFuture = SharedPref.getTodoList(); // Update as needed
    });
  }

  Future<void> _deleteTodo(String todoTitle) async {
    // Replace with Firebase logic to delete tasks if needed
    await SharedPref.removeTodoByTitle(todoTitle); // Update as needed
    _refreshTodoList();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      drawer: MyDrawer(themeProvider: themeProvider),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi ${_getCurrentUserName()}'), // Show current user's name
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
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _todoListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No to-dos found'));
                } else {
                  final todos = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    shrinkWrap: true,
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return _buildTodoItem(todo);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          );
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Add Task"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  String _getCurrentUserName() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.displayName ?? '';
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.dashboard),
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(18.0),
          child: Icon(Icons.notifications),
        ),
      ],
    );
  }

  Widget _buildTodoItem(Map<String, dynamic> todo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                child: Text(
                  '20',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    todo['title'] ?? 'No title',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyText1?.color,
                    ),
                  ),
                  Text(
                    todo['desc'] ?? 'No description',
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).textTheme.bodyText2?.color,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _deleteTodo(todo['title'] ?? '');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
