import 'models.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:core';
import 'dart:convert';

abstract class LocalDataSource {
  Future<List<ToDoItem>> getToDoList();
  Future<List<ToDoItem>> cacheToDoItem(ToDoItem item);
  Future<List<ToDoItem>> updateToDoItem(ToDoItem item);
  Future<List<ToDoItem>> deleteToDoItems(List<ToDoItem> items);
}

class LocalDataSourceDefault extends LocalDataSource {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/to_do_list.json');
  }

  @override
  Future<List<ToDoItem>> updateToDoItem(ToDoItem item) async {
    try {
      final file = await _localFile;
      var toDoList = await getToDoList();
      var index = toDoList.indexWhere((e) => e.title == item.title);
      toDoList.replaceRange(index, index + 1, [item]);
      file.writeAsStringSync(json.encode(toDoList));
      return toDoList;
    } catch (e) {
      print("Update Fail: ${e.toString()}");
      return [];
    }
  }

  @override
  Future<List<ToDoItem>> cacheToDoItem(ToDoItem item) async {
    try {
      final file = await _localFile;
      var toDoList = await getToDoList();
      toDoList.add(item);
      file.writeAsStringSync(json.encode(toDoList));
      return toDoList;
    } catch (e) {
      print("Cache Fail: ${e.toString()}");
      return [];
    }
  }

  @override
  Future<List<ToDoItem>> deleteToDoItems(List<ToDoItem> items) async {
    try {
      final file = await _localFile;
      var toDoList = await getToDoList();
      for (var item in items) {
        toDoList = toDoList.where((e) => e.title != item.title).toList();
      }
      file.writeAsStringSync(json.encode(toDoList));
      return toDoList;
    } catch (e) {
      print("Delete Fail: ${e.toString()}");
      return [];
    }
  }

  @override
  Future<List<ToDoItem>> getToDoList() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      var jsonResponse = jsonDecode(contents);
      return ToDoList.fromJson(jsonResponse).items;
    } catch (e) {
      print("Get Fail: ${e.toString()}");
      return [];
    }
  }
}
