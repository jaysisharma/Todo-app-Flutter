import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<Map<String, dynamic>> todos = [];
  final TextEditingController todocontroller = TextEditingController();
  bool update = false;

  void addtodo() {
    if (todocontroller.text.isNotEmpty) {
      setState(() {
        todos.add({
          "id": DateTime.now().microsecondsSinceEpoch,
          "title": todocontroller.text,
          "isCompleted": false
        });
        todocontroller.clear();
      });
    }
  }

  void toggleCompletion(int index) {
    setState(() {
      todos[index]['isCompleted'] = !todos[index]['isCompleted'];
    });
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }
  
  void editTodo(int index){
    // add editTodo Logic

    // setState(() {
    //   // int i = todos.indexWhere((element) => element['id']== selId);
    //   if (i > -1)  {
    //     var todo = todos[i];
    //     todos.removeAt(i);
    //     todos.insert(index, i);
    //   }
    //   todos[index]['title'] = todocontroller.text;

    // });
  }

  // void editTodo(int index) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       final TextEditingController editController = TextEditingController(text: todos[index]['title']);

  //       return AlertDialog(
  //         title: const Text('Edit Todo'),
  //         content: TextField(
  //           controller: editController,
  //           decoration: const InputDecoration(
  //             hintText: 'Edit todo',
  //             border: OutlineInputBorder(),
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: const Text('Save'),
  //             onPressed: () {
  //               setState(() {
  //                 todos[index]['title'] = editController.text;
  //               });
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
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
                    decoration: const InputDecoration(
                      hintText: 'Enter todo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              update ?   IconButton(
                  icon: const Icon(Icons.update),
                  onPressed: (){
                    // editTodo(index)
                  },
                ) : IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addtodo,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: CheckboxListTile(
                    value: todos[index]['isCompleted'],
                    onChanged: (bool? value) {
                      toggleCompletion(index);
                    },
                    title:  Text(todos[index]['title'], style: TextStyle(decoration: todos[index]['isCompleted'] ? TextDecoration.lineThrough : TextDecoration.none),),
                    secondary: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // editTodo(index);
                            todocontroller.text = todos[index]['title'];
                            setState(() {
                              update = !update;
                            });
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteTodo(index);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
