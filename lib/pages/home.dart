import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todotrial/api/firebase_api.dart';
import 'package:todotrial/models/todo.dart';
import 'package:todotrial/pages/drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final todos = [
  //   ToDo('0', "create Project", true),
  //   ToDo('1', "Add a To Do", true),
  //   ToDo('2', "Complete All Your ToDos", false)
  // ];
  @override
  void initState() {
    super.initState();
    FirebaseApi.getTodo(_update);
  }

  var todos = [];

  // FirebaseApi.getTodo();
  void _update(List<ToDo> count) {
    // print("asdf");
    setState(() => todos = count);
  }

  createAlertDialogue(BuildContext context) {
    TextEditingController controllerText = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add ToDo"),
            content: TextField(
              controller: controllerText,
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  ToDo tempToDo =
                      ToDo("", controllerText.text.toString(), false);
                  FirebaseApi.createTodo(tempToDo);
                  Navigator.of(context).pop();
                  setState(() {
                    print(todos.length);
                    todos.add(tempToDo);
                    todos.sort((a, b) {
                      if (b.isDone) {
                        return -1;
                      }
                      return 1;
                    });
                  });
                },
                elevation: 0.5,
                child: Text("Add"),
              )
            ],
          );
        });
  }

  GestureDetector createTodo(double width, ToDo temp) {
    return GestureDetector(
        onTap: () {
          setState(() {
            ToDo tempToDo = (todos.elementAt(
                todos.indexWhere((element) => element.key == temp.key)));
            tempToDo.isDone = !tempToDo.isDone;
            FirebaseApi.updateTodo(tempToDo);

            todos.sort((a, b) {
              if (b.isDone) {
                return -1;
              }
              return 1;
            });
          });
        },
        child: Center(
            child: Container(
                width: 0.95 * width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey[100],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      temp.text,
                      style: TextStyle(
                        fontSize: 17,
                        color: temp.isDone ? Colors.grey : Colors.black,
                        decoration:
                            temp.isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          color: temp.isDone ? Colors.green : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: Colors.grey[300],
                          )),
                      child: Icon(
                        Icons.done,
                        size: 16,
                        color: Colors.white,
                      ),
                    )
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
            drawer: NavigationDrawer(),
            backgroundColor: Color(0xffF4F4F5),
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.subject_sharp,
                  color: Color(0xff53A5D5),
                  size: 30.0,
                ),
                onPressed: () {},
              ),
              elevation: 0.0,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                "All Task",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                createAlertDialogue(context);
              },
              tooltip: 'Add',
              backgroundColor: Color(0xff53A5D5),
              child: Icon(
                Icons.add,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: ListView(
                children: [
              // createTodo(width,false),
            ]..addAll(todos.map((todo) => createTodo(width, todo))))
            // Container(
            //   height: 70,
            // )

            ));
  }
}
