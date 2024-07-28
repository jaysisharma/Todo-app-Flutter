import 'package:flutter/material.dart';

class FlexTextfield extends StatelessWidget {
  const FlexTextfield({super.key});

  @override
  Widget build(BuildContext context) {

    return  TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(35, 34, 40, 1),
        suffixIcon: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.search,
            size: 30,
          ),
        ),
        hintText: 'Enter text here',
        // Define the border when the TextField is not focused
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        // Define the border when the TextField is focused
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}