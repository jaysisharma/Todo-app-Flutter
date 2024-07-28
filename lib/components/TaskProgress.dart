import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class TaskProgress extends StatelessWidget {
  const TaskProgress({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
              // color: const Color.fromRGBO(35, 34, 40, 1),
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromRGBO(35, 34, 40, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Task Progress",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "30/40 task done",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 32, 93, 198),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 8,
                            ),
                            child: Text(
                              "March 22",
                              style: TextStyle(fontWeight: FontWeight.w200),
                            ),
                          ),
                        )
                      ],
                    ),
                    SimpleCircularProgressBar(
                      valueNotifier: ValueNotifier<double>(80),
                      animationDuration: 2,
                      progressColors: const [Colors.blueAccent],
                      mergeMode: true,
                      onGetText: (double value) {
                        return Text(
                          '${value.toInt()}%',
                          style: const TextStyle(fontSize: 20),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
  }
}