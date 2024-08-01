import 'package:flutter/material.dart';
import 'package:todo_app/pages/MainPage.dart';

class TaskCategory extends StatefulWidget {
  const TaskCategory({super.key});

  @override
  State<TaskCategory> createState() => _TaskCategoryState();
}

class _TaskCategoryState extends State<TaskCategory> {
  bool _isUrgentChecked = false;
  bool _isRegularChecked = false;
  bool _isTechTaskChecked = false;
  bool _isIndoorChecked = false;
  bool _isOutdoorChecked = false;
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate =
        DateTime(now.year - 100); // Example: 100 years ago
    final DateTime lastDate =
        DateTime(now.year + 100); // Example: 100 years in the future

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Deadline",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No date selected'
                        : 'Deadline: ${_formatDate(_selectedDate!)}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(height: 20), // Space between sections
            Text(
              "Select Task Priority",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10),
            CheckboxListTile(
              title: Text('Urgent'),
              value: _isUrgentChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isUrgentChecked = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Regular'),
              value: _isRegularChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isRegularChecked = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            SizedBox(height: 20), // Space between sections
            Text(
              "Add Category",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10),
            CheckboxListTile(
              title: Text('Tech Task'),
              value: _isTechTaskChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isTechTaskChecked = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Indoor'),
              value: _isIndoorChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isIndoorChecked = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Outdoor'),
              value: _isOutdoorChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isOutdoorChecked = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: FloatingActionButton(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainPage()));
            },
            child: Text("Add Task"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  String _formatDate(DateTime date) {
    // Format date as "YYYY-MM-DD"
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
