class ToDo{
  int key;
  String text;
  bool isDone;

  ToDo(this.key,this.text,this.isDone);
  static List<ToDo> fetchAll(){
    return [
      ToDo(1,"create Project", true),
      ToDo(2,"This is second", false),
      ToDo(3,"Third", false),
    ];
  }
}
