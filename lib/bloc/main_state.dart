import 'package:equatable/equatable.dart';
import '../models.dart';

class MainState extends Equatable {
  final List<ToDoItem> todoList;
  final String? errorMessage;

  const MainState({required this.todoList, this.errorMessage});

  @override
  List<Object?> get props => [todoList];

  static MainState initial(List<ToDoItem> todoList) =>
      MainState(todoList: todoList);

  MainState copyWith({
    List<ToDoItem>? todoList,
    String? errorMessage,
  }) {
    return MainState(
      todoList: todoList ?? [],
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
