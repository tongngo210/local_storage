class ToDoItem {
  final String title;
  final bool done;

  ToDoItem(
    this.title,
    this.done,
  );

  factory ToDoItem.fromJson(Map<String, dynamic> parsedJson) {
    return ToDoItem(
      parsedJson['title'],
      parsedJson['done'],
    );
  }

  Map<String, dynamic> toJson() => {'title': title, 'done': done};
}

class ToDoList {
  List<ToDoItem> items;

  ToDoList(this.items);

  factory ToDoList.fromJson(dynamic parsedJson) {
    return ToDoList(
      List<ToDoItem>.from(
          parsedJson.map<ToDoItem>((item) => ToDoItem.fromJson(item))),
    );
  }
}
