class ToDo {
  String key;
  String text;
  bool isDone;

  ToDo(this.key, this.text, this.isDone);

  Map<String, dynamic> toJson() =>
      {
        'key': key,
        'text': text,
        'isDone': isDone
      };

  ToDo fromJson(Map<String, dynamic> json) {
    return ToDo(json['key'], json['text'], json['isDone']);
  }
}
