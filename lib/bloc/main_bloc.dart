import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_storagelocalstorage/local_datasource.dart';
import 'package:local_storagelocalstorage/models.dart';

import 'bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final LocalDataSource localDataSource = LocalDataSourceDefault();

  MainBloc(MainState initialState) : super(initialState) {
    on<GetLocalToDoListEvent>(onGetLocalToDoList);
    on<AddLocalToDoItemEvent>(onAddToDoItem);
    on<DeleteLocalToDoItemsEvent>(onDeleteToDoItems);
    on<UpdateLocalToDoItemEvent>(onUpdateToDoItem);
  }

  void onGetLocalToDoList(
      GetLocalToDoListEvent event, Emitter<MainState> emit) async {
    try {
      final todoList = await localDataSource.getToDoList();
      emit(state.copyWith(todoList: todoList));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void onAddToDoItem(
      AddLocalToDoItemEvent event, Emitter<MainState> emit) async {
    try {
      final todoList = await localDataSource.cacheToDoItem(event.item);
      emit(state.copyWith(todoList: todoList));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void onDeleteToDoItems(
      DeleteLocalToDoItemsEvent event, Emitter<MainState> emit) async {
    try {
      final todoList = await localDataSource.deleteToDoItems(event.items);
      emit(state.copyWith(todoList: todoList));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void onUpdateToDoItem(
      UpdateLocalToDoItemEvent event, Emitter<MainState> emit) async {
    try {
      final todoList = await localDataSource.updateToDoItem(event.item);
      emit(state.copyWith(todoList: todoList));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
