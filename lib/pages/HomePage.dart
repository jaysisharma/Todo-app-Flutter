import 'package:flutter/material.dart';
import 'package:todo_app/components/Textfield.dart';
import 'package:todo_app/utils/Shared_Pref.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String todo = "";
  bool value = false;
  List<String> todoslist = ["Ss"];
  @override
  void initState() {
    super.initState();
    _gettodos();
  }

  Future<String?> _gettodos() async {
    String? todos = await SharedPref.getTodo();
    setState(() {
      todo = todos ?? '';
    });
    return todos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const CustomTextField(
                icon: Icon(Icons.task), labelText: "Enter your Task"),
            const SizedBox(
              height: 10,
            ),
            const CustomTextField(
                icon: Icon(Icons.date_range), labelText: "Enter your Deadline"),
            const SizedBox(
              height: 10,
            ),
            // Container(
            //   // height: 20,
            //   width: MediaQuery.of(context).size.width,
            //   color: Colors.blueAccent,
            //   alignment: Alignment.center,
            //   child: const Padding(
            //     padding: EdgeInsets.all(8.0),
            //     child: Text(
            //       "Add Todo",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Your Todos",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // todoslist.isEmpty
                  //     ? Text("No Todo")
                       Expanded(
                        child: ListView.builder(
                          itemCount: 10,
                            itemBuilder: (context, index) => Card(
                                  child: CheckboxListTile(
                                    value: value,
                                    onChanged: (v) {},
                                    title: Text("Task Name"),
                                    secondary: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.delete)),
                                      ],
                                    ),
                                  ),
                                )),
                      )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
