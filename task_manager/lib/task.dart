import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class MyTask extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<MyTask> {
  final taskController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  void addToDo() async {
    if (taskController.text.trim().isEmpty ||
        taskDescriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Some Data Missing"),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    await saveTask(taskController.text, taskDescriptionController.text);
    setState(() {
      taskController.clear();
      taskDescriptionController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
        margin: EdgeInsetsDirectional.all(1),
        child: Column(
          children: [
            TextField(
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              controller: taskController,
              decoration: InputDecoration(
                  labelText: "New Task Name",
                  labelStyle: TextStyle(color: Colors.blueAccent)),
            ),
            SizedBox(height: 20),
            TextField(
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              controller: taskDescriptionController,
              maxLines: 7,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  labelText: "New Task Description",
                  labelStyle: TextStyle(color: Colors.blueAccent)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.blueAccent,
                ),
                onPressed: () {
                  addToDo();
                  Navigator.pop(context);
                },
                child: Text("Create")),
          ],
        ),
      )
    );
  }

  Future<void> saveTask(String title, String description) async {
    final task = ParseObject('tasks')
      ..set('taskName', title)
      ..set('taskDescription', description)
      ..set('taskStatus', 'DEFINED');
    await task.save();
  }
}
