import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final String text;
  final String? text2;
  final double? sh;
  final Color sliderbg;
  final Color sliderfr;
  final double txtsz;
  final String? deadline;
  final double? deadh;
  const TaskContainer({super.key, required this.height, required this.width, required this.color, required this.text, required this.text2, required this.sh, required this.sliderbg, required this.sliderfr, required this.txtsz, this.deadline, this.deadh});

  @override
  Widget build(BuildContext context) {

    return Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(71, 57, 111, 0.4),
                              borderRadius: BorderRadius.circular(18)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.mode_edit_outline),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          text,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: txtsz),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if(text2 !=null)
                          Text(
                          // "Task management \nmobile app",
                            text2.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w200),
                          ),
                        SizedBox(
                          height: sh,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 8,
                          decoration: BoxDecoration(
                            color: sliderbg,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                width: 60,
                                // height: 2,
                                decoration: BoxDecoration(
                                    color: sliderfr,
                                    borderRadius: BorderRadius.circular(18)),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Progress"), Text("70%")],
                        ),
                        SizedBox(height: deadh,),
                        if(deadline != null)
                          Text(deadline.toString())
                      ],
                    ),
                  ),
                );
  }
}