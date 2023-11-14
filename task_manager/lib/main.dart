import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:task_manager/task.dart';
import 'package:task_manager/taskUpdate.dart';
// import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final keyApplicationId = 'JThEaW2yeQZNAxlCa0G33SU0WMHnrstWKKy2JrJw';
  final keyClientKey = '688mRiiMSrGx8glAbNWPet5quCMok8CXY8qlhatG';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class Task{
  String id = '';
  String name = '';
  String desc = '';
  String status = '';

  Task(String id, String name, String desc, String status){
    this.id = id;
    this.name = name;
    this.desc = desc;
    this.status = status;
  }
}

class MyApp extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<GlobalKey<RefreshIndicatorState>> _refreshKeys;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _refreshKeys = List.generate(3, (_) => GlobalKey<RefreshIndicatorState>());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Task Manager"),
            centerTitle: true,
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text('DEFINED'),
                  icon: Icon(Icons.warning_outlined),
                ),
                Tab(
                  child: Text('IN-PROGRESS'),
                  icon: Icon(Icons.lock_clock_outlined),
                ),
                Tab(
                  child: Text('COMPLETED'),
                  icon: Icon(Icons.check_circle_outline),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              RefreshIndicator(
                key: _refreshKeys[0],
                onRefresh: () async {
                  // Implement your refresh logic for Tab 1
                  await Future.delayed(Duration(seconds: 2));
                  setState(() {
                    // Update data for Tab 1
                  });
                },
                child: buildTabView('DEFINED'),
              ),
              RefreshIndicator(
                key: _refreshKeys[1],
                onRefresh: () async {
                  // Implement your refresh logic for Tab 1
                  await Future.delayed(Duration(seconds: 2));
                  setState(() {
                    // Update data for Tab 1
                  });
                },
                child: buildTabView('IN-PROGRESS'),
              ),
              RefreshIndicator(
                key: _refreshKeys[2],
                onRefresh: () async {
                  // Implement your refresh logic for Tab 1
                  await Future.delayed(Duration(seconds: 2));
                  setState(() {
                    // Update data for Tab 1
                  });
                },
                child: buildTabView('COMPLETED'),
              ),
            ],
          ),
        ));
  }

  Future<List<ParseObject>> getTasks(status) async {
    QueryBuilder<ParseObject> queryTasks =
    QueryBuilder<ParseObject>(ParseObject('tasks'))
      ..whereEqualTo('taskStatus', status);
    final ParseResponse apiResponse = await queryTasks.query();

    if (apiResponse.success && apiResponse.results != null) {
      var taskArray = apiResponse.results as List<ParseObject>;
      if (status == 'DEFINED') {
        taskArray.sort((a, b) => (b['createdAt']).compareTo((a['createdAt'])));
      } else {
        taskArray.sort((a, b) => (b['updatedAt']).compareTo((a['updatedAt'])));
      }
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }

  Future<void> updateTask(String id, String status) async {
    var task = ParseObject('tasks')
      ..objectId = id
      ..set('taskStatus', status);
    await task.save();
    setState(() {
      //Refresh UI
    });
  }

  Future<void> deleteTask(String id) async {
    var task = ParseObject('tasks')
      ..objectId = id;
    await task.delete();
  }

  Widget buildTabView(String status) {
    return Column(children: [
      Expanded(
          child: FutureBuilder<List<ParseObject>>(
              future: getTasks(status),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: Container(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator()),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error..."),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text("No Data..."),
                      );
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 10.0),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          //*************************************
                          //Get Parse Object Values
                          final varTask = snapshot.data![index];
                          final varTitle = varTask.get<String>('taskName')!;
                          final varId = varTask.get<String>('objectId')!;
                          final varDescription =
                              varTask.get<String>('taskDescription')!;
                          final varStatus = varTask.get<String>('taskStatus');
                          //*************************************

                          return ListTile(
                            title: Text(varTitle,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(varDescription,
                                style: TextStyle(fontWeight: FontWeight.w100)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(varStatus!),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () async {
                                    await deleteTask(varTask.objectId!);
                                    setState(() {
                                      final snackBar = SnackBar(
                                        content: Text("Todo deleted!"),
                                        duration: Duration(seconds: 2),
                                      );
                                      ScaffoldMessenger.of(context)
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(snackBar);
                                    });
                                  },
                                )
                              ],
                            ),
                            onTap: () async {
                              // Navigate to the second page and wait for a result
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyTaskUpdate(
                                        task: Task(varId, varTitle,
                                            varDescription, varStatus))),
                              );
                              setState(() {
                                //Refresh UI
                              });
                            },
                          );
                        },
                      );
                    }
                }
              })),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: Colors.blueAccent,
        ),
        onPressed: () async {
          // Navigate to the second page and wait for a result
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyTask()),
          );
          setState(() {
            //Refresh UI
          });
        },
        child: Text('New Task'),
      ),
      SizedBox(height: 20),
      SizedBox(height: 20),
    ]);
  }
}