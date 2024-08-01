import 'package:flutter/material.dart';
import 'package:todo_app/pages/TaskCategory.dart';
import 'package:todo_app/utils/Shared_Pref.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();


  void addTask() async{
    await SharedPref.saveTodo(titleController.text,descController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Task"),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child:  TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Enter your Task"),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child:  TextField(
                    controller: descController,
                    maxLines: 25,
                    decoration: const InputDecoration(
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
              print(titleController.text);
              print(descController.text);
              addTask();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TaskCategory()));
            },
            child: const Text("Add Task"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
