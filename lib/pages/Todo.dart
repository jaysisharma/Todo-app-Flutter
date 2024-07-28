import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List todos = [];
  TextEditingController todocontroller = TextEditingController();

  void addtodo() {
    if (todocontroller.text.isNotEmpty) {
      todos.add({"id": 1, "title": todocontroller.text, "isCompleted": false});
      setState(() {});
    }
  }

  void done(){
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: todocontroller,
                )),
                Icon(Icons.add)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: addtodo, child: Text("Add todo")),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) => Card(
                        child: CheckboxListTile(
                          value: todos[index]['isCompleted'],
                          onChanged: (v) {
                            
                            setState(() {
                              !todos[index]['isCompleted'];
                            });
                          },
                          title: Text('${todos[index]['title']}'),
                          secondary: SizedBox(
                            width: 80,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.delete)),
                              ],
                            ),
                          ),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
