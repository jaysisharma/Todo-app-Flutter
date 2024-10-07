import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String _todoListKey = "todo_list";
  static const String _logged = 'is_logged';
  static const String _user = 'user';

  // Get the instance of SharedPreferences
  static Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  // Save a to-do item to the list
  static Future<void> saveTodo(String todoTitle, String todoDesc) async {
    final SharedPreferences pref = await _getPreferences();
    final List<Map<String, dynamic>> todoList = _getTodoListFromPref(pref);

    final newTodo = {
      'title': todoTitle,
      'desc': todoDesc,
    };
    todoList.add(newTodo);

    await _saveTodoListToPref(pref, todoList);
  }

  // Retrieve the list of to-do items
  static Future<List<Map<String, dynamic>>> getTodoList() async {
    final SharedPreferences pref = await _getPreferences();
    return _getTodoListFromPref(pref);
  }

  // Remove a specific to-do item by title
  static Future<void> removeTodoByTitle(String todoTitle) async {
    final SharedPreferences pref = await _getPreferences();
    final List<Map<String, dynamic>> todoList = _getTodoListFromPref(pref);

    todoList.removeWhere((item) => item['title'] == todoTitle);

    await _saveTodoListToPref(pref, todoList);
  }

  // Save login status
  static Future<void> setLoginStatus(bool isLoggedIn) async {
    final SharedPreferences pref = await _getPreferences();
    await pref.setBool(_logged, isLoggedIn);
  }

  // Retrieve login status
  static Future<bool> getLoginStatus() async {
    final SharedPreferences pref = await _getPreferences();
    return pref.getBool(_logged) ?? false;
  }

  // Save username
  static Future<void> saveUsername(String username) async {
    final SharedPreferences pref = await _getPreferences();
    await pref.setString(_user, username);
  }

  // Retrieve username
  static Future<String?> getUsername() async {
    final SharedPreferences pref = await _getPreferences();
    return pref.getString(_user);
  }

  // Helper to get the todo list from SharedPreferences
  static List<Map<String, dynamic>> _getTodoListFromPref(SharedPreferences pref) {
    final String? jsonString = pref.getString(_todoListKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      return [];
    }
  }

  // Helper to save the todo list to SharedPreferences
  static Future<void> _saveTodoListToPref(
      SharedPreferences pref, List<Map<String, dynamic>> todoList) async {
    final String updatedJsonString = json.encode(todoList);
    await pref.setString(_todoListKey, updatedJsonString);
  }
}
