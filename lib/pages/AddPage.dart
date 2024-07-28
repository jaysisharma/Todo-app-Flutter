import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/pages/TaskCategory.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Task"),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: const TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Enter your Task"),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: const TextField(
                     maxLines: 25,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Task Description......",
                        hintStyle: TextStyle(fontSize: 14)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: FloatingActionButton(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TaskCategory()));
            },
            child: Text("Add Task"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
