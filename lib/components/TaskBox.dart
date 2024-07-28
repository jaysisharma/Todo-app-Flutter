import 'package:flutter/material.dart';
import 'package:todo_app/components/TaskContainer.dart';

class Tasksbox extends StatelessWidget {
  const Tasksbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TaskContainer(
          height: 310,
          width: MediaQuery.of(context).size.width / 2,
          color: const Color.fromRGBO(127, 94, 220, 1),
          text: "Tech Task",
          text2: "Task management \n mobile app",
          sh: 40,
          sliderbg: const Color.fromRGBO(26, 16, 6, 1),
          sliderfr: const Color.fromRGBO(13, 171, 254, 1),
          txtsz: 25,
          deadline: "24 Aug 2024",
          deadh: 20,
        ),
        const Column(
          children: [
            TaskContainer(
              height: 150,
              width: 150,
              color: Color.fromRGBO(33, 175, 243, 1),
              text: "Indoor Task",
              text2: null,
              sh: null,
              sliderbg: Color.fromRGBO(36, 115, 180, 1),
              sliderfr: Color.fromRGBO(146, 236, 154, 1),
              txtsz: 16,
            ),
            SizedBox(
              height: 10,
            ),
            TaskContainer(
              height: 150,
              width: 150,
              color: Color.fromRGBO(3, 165, 122, 1),
              text: "Indoor Task",
              text2: null,
              sh: null,
              sliderbg: Color.fromRGBO(36, 115, 180, 1),
              sliderfr: Color.fromRGBO(146, 236, 154, 1),
              txtsz: 16,
            ),
          ],
        )
      ],
    );
  }
}