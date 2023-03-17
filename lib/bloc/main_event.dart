import 'package:equatable/equatable.dart';
import '../models.dart';

abstract class MainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetLocalToDoListEvent extends MainEvent {
  GetLocalToDoListEvent();

  @override
  List<Object> get props => [];
}

class AddLocalToDoItemEvent extends MainEvent {
  final ToDoItem item;

  AddLocalToDoItemEvent(this.item);

  @override
  List<Object> get props => [];
}

class DeleteLocalToDoItemsEvent extends MainEvent {
  final List<ToDoItem> items;

  DeleteLocalToDoItemsEvent(this.items);

  @override
  List<Object> get props => [];
}

class UpdateLocalToDoItemEvent extends MainEvent {
  final ToDoItem item;

  UpdateLocalToDoItemEvent(this.item);

  @override
  List<Object> get props => [];
}
