import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Icon icon;
  final String labelText;

  const CustomTextField(
      {super.key, required this.icon, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                prefixIcon: icon,
                border: OutlineInputBorder(),
                labelText: labelText),
          ),
        ),
      ],
    );
  }
}
