// ignore_for_file: unused_field

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/Drawer.dart';
import 'package:todo_app/components/FlexTextfield.dart';
import 'package:todo_app/components/TaskBox.dart';
import 'package:todo_app/components/TaskProgress.dart';
import 'package:todo_app/pages/AddPage.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/utils/Shared_Pref.dart';

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
    _refreshTodoList(); // Initialize the Future
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
    setState(() {
      _todoListFuture = SharedPref.getTodoList();
    });
  }

  Future<void> _deleteTodo(String todoTitle) async {
    await SharedPref.removeTodoByTitle(todoTitle);
    _refreshTodoList(); // Refresh the list after deletion
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: _AppBar(),
      drawer: MyDrawer(themeProvider: themeProvider),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _todoListFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No to-dos found'));
                  } else {
                    final todos = snapshot.data!;
                    return ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      shrinkWrap: true,
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(35, 34, 40, 1),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    child: Text(
                                        '20'), // Placeholder for dynamic content
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        todo['title'] ?? 'No title',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        todo['desc'] ?? 'No description',
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      _deleteTodo(todo['title'] ??
                                          ''); // Trigger delete
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
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

  AppBar _AppBar() {
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
}
