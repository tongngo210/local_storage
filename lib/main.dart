import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models.dart';
import '../bloc/bloc.dart';
import 'local_datasource.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Storage Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<MainBloc>(
        create: (context) =>
            MainBloc(MainState.initial([]))..add(GetLocalToDoListEvent()),
        child: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  List<ToDoItem> toDoList = [];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listener: ((context, state) {
        toDoList.clear();
        toDoList.addAll(state.todoList);
      }),
      child: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Local Storage Demo')),
          body: Container(
              padding: const EdgeInsets.all(10.0),
              constraints: const BoxConstraints.expand(),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ListView(
                      itemExtent: 50.0,
                      children: _widgets(toDoList),
                    ),
                  ),
                  ListTile(
                    title: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        labelText: 'What to do?',
                      ),
                      onEditingComplete: () => {
                        if (!toDoList
                            .map((e) => e.title)
                            .contains(controller.text))
                          {
                            BlocProvider.of<MainBloc>(context)
                                .add(AddLocalToDoItemEvent(ToDoItem(
                              controller.value.text,
                              false,
                            ))),
                            controller.text = ""
                          }
                      },
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.save),
                          onPressed: () => {
                            if (!toDoList
                                .map((e) => e.title)
                                .contains(controller.text))
                              {
                                BlocProvider.of<MainBloc>(context)
                                    .add(AddLocalToDoItemEvent(ToDoItem(
                                  controller.value.text,
                                  false,
                                ))),
                                controller.text = ""
                              }
                          },
                          tooltip: 'Save',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => BlocProvider.of<MainBloc>(context)
                              .add(DeleteLocalToDoItemsEvent(toDoList
                                  .where((e) => e.done == true)
                                  .toList())),
                          tooltip: 'Clear storage',
                        )
                      ],
                    ),
                  ),
                ],
              )),
        );
      }),
    );
  }

  List<Widget> _widgets(List<ToDoItem> toDoList) {
    return toDoList.map((item) {
      return CheckboxListTile(
        value: item.done,
        title: Text(item.title),
        selected: item.done,
        onChanged: (_) {
          ToDoItem updatedItem = ToDoItem(item.title, !item.done);
          BlocProvider.of<MainBloc>(context)
              .add(UpdateLocalToDoItemEvent(updatedItem));
        },
      );
    }).toList();
  }
}
