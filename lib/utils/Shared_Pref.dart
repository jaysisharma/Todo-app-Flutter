import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String _todo = "";

  static Future<void> saveTodo(String Todo) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_todo, Todo);
  }

  static Future<String? > getTodo() async{
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_todo);
  }

  static Future<void> removeTodo() async{
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_todo);
  }
}
