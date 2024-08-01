import 'dart:convert'; // For json encoding and decoding
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String _todoListKey = "todo_list"; // Key for storing the list

  // Save a to-do item to the list
  static Future<void> saveTodo(String todoTitle, String todoDesc) async {
    final pref = await SharedPreferences.getInstance();
    
    // Get the current list of to-dos
    final String? jsonString = pref.getString(_todoListKey);
    final List<dynamic> todoList = jsonString != null ? json.decode(jsonString) : [];

    // Add the new to-do item
    final newTodo = {
      'title': todoTitle,
      'desc': todoDesc,
    };
    todoList.add(newTodo);

    // Save the updated list back to SharedPreferences
    final updatedJsonString = json.encode(todoList);
    await pref.setString(_todoListKey, updatedJsonString);
  }

  // Retrieve the list of to-do items
  static Future<List<Map<String, dynamic>>> getTodoList() async {
    final pref = await SharedPreferences.getInstance();
    final String? jsonString = pref.getString(_todoListKey);
    
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      return []; // Return an empty list if no to-dos are saved
    }
  }

  // Remove a specific to-do item by title
  static Future<void> removeTodoByTitle(String todoTitle) async {
    final pref = await SharedPreferences.getInstance();
    final String? jsonString = pref.getString(_todoListKey);
    
    if (jsonString != null) {
      final List<dynamic> todoList = json.decode(jsonString);
      
      // Remove the to-do item with the matching title
      todoList.removeWhere((item) => item['title'] == todoTitle);
      
      // Save the updated list back to SharedPreferences
      final updatedJsonString = json.encode(todoList);
      await pref.setString(_todoListKey, updatedJsonString);
    }
  }
}
