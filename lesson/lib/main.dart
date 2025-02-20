import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lesson/getController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('ToDo');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: ToDoApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ToDoApp extends StatefulWidget {
  @override
  _ToDoAppState createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  TextEditingController controller = TextEditingController();
  final todo = Hive.box('ToDo');

  void add() {
    if (controller.text.isNotEmpty) {
      todo.add(controller.text);
      controller.clear();
      setState(() {});
    }
  }
 void change(int index) {
    if (controller.text.isNotEmpty) {
      todo.putAt(index,controller.text);
      controller.clear();
      setState(() {});
    }
  }

  void remove(int index) {
    todo.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'TODO TASK',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                todo.length.toString(),
                style: TextStyle(
                    color: Colors.indigo, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 5, 16, 88),
                const Color.fromARGB(195, 67, 36, 127)
              ], 
              begin: Alignment.topRight, 
              end: Alignment.bottomLeft,
            )),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  '${TimeOfDay.now().format(context)}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.list,
                              size: 28, color: Colors.black54)),
                      Text('All'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.check,
                              size: 28, color: Colors.black54)),
                      Text('Compated'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 5, 16, 88),
                  const Color.fromARGB(209, 98, 72, 150)
                ], 
                begin: Alignment.topRight, 
                end: Alignment.bottomLeft,
              )),
              child: ListView.builder(
                itemCount: todo.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 236, 237, 243),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            todo.getAt(index),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                controller.text = todo.getAt(index);
                                 showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Add Your Todo Item'),
                  content: TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: 'Enter your task'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        change(index);
                        Navigator.pop(context);
                      },
                      child: Text('Add'),
                    )
                  ],
                ),
              );
                              },
                              
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>dialogController().showDialog((){remove(index);
                              Get.back();}),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            shape: CircleBorder(),
            backgroundColor: const Color.fromARGB(255, 35, 6, 114),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Add Your Todo Item'),
                  content: TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: 'Enter your task'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        add();
                        Navigator.pop(context);
                      },
                      child: Text('Add'),
                    )
                  ],
                ),
              );
            },
            child: Icon(Icons.add, size: 24, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
