import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'main.dart' show Task;

class MyTaskUpdate extends StatefulWidget {
  final Task task;

  MyTaskUpdate({required this.task});

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<MyTaskUpdate> {
  late Task myTask;
  late TextEditingController taskController;
  late TextEditingController taskDescriptionController;

  @override
  void initState() {
    myTask = widget.task;
    taskController = TextEditingController(text: myTask.name);
    taskDescriptionController = TextEditingController(text: myTask.desc);
  }

  void updateTask() async {
    if (taskController.text.trim().isEmpty ||
        taskDescriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Some Data Missing"),
        duration: Duration(seconds: 2),
      ));
      return;
    } else {
      await updateTaskToBackEnd(
          myTask.id, taskController.text, taskDescriptionController.text,
          myTask.status);
      setState(() {
        taskController.clear();
        taskDescriptionController.clear();
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update Task #" + myTask.id),
          centerTitle: true,
        ),
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
                    labelText: "Task Name to Update",
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
                    labelText: "Task Description to Update",
                    labelStyle: TextStyle(color: Colors.blueAccent)),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: myTask.status,
                onChanged: (String? newValue) {
                  // myTask.status = newValue!;
                  setState(() {
                    myTask.status = newValue!;
                  });
                },
                items:
                    ['DEFINED', 'IN-PROGRESS', 'COMPLETED'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Colors.blueAccent,
                  ),
                  onPressed: () {
                    updateTask();
                  },
                  child: Text("Update")),
            ],
          ),
        ));
  }

  Future<void> updateTaskToBackEnd(String id, String title, String description, String status) async {
    final task = ParseObject('tasks')
      ..set('objectId', id)
      ..set('taskName', title)
      ..set('taskDescription', description)
      ..set('taskStatus', status);
    await task.save();
  }
}
