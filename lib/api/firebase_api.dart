import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todotrial/models/todo.dart';

class FirebaseApi {
  static String UserID = "";
  static String UserName = "";
  static String UserPhotoURL = "";
  static bool UisLoggedIn = false;

  static Future<String> createTodo(ToDo todo) async {
    final docToDo = FirebaseFirestore.instance.collection(UserID).doc();
    await docToDo.set(todo.toJson());
    todo.key = docToDo.id;
    updateTodo(todo);
  }

  static updateTodo(ToDo todo) async {
    final docToDo =
        FirebaseFirestore.instance.collection(UserID).doc(todo.key).update({
      "isDone": !todo.isDone,
      "key": todo.key,
      "text": todo.text,
    }).then((_) {
      print("success updated!");

      // print(todo.isDone);
      // getTodo();
    });
  }

  static getTodo(update) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(UserID).get();

    var l = querySnapshot.docs.toList();
    // map((DocumentSnapshot docSnapshot){
    //   return ToDo(docSnapshot.data()['key'], docSnapshot.data()['text'], docSnapshot.data()['isDone']);
    // });

    List<ToDo> l2 = [];
    for (var i = 0; i < l.length; i++) {
      // print(l[i].data());
      l2.add(
          ToDo(l[i].data()['key'], l[i].data()['text'], l[i].data()['isDone']));
    }
    // print(l2);
    update(l2);
  }
}
