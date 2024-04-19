import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_task/screens/task_editor.dart';

import '../bloc/todo_bloc.dart';
import '../domain/home/model/todo_model.dart';
import '../widgets/todo_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(GetAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showAlertDialog(context);
              },
              icon: const Icon(Icons.delete))
        ],
        elevation: 0.0,
        title: const Text(
          "My Todos",
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoListState) {
            return state.todos.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                        itemCount: state.todos.length,
                        itemBuilder: (context, index) {
                          TodoData currentTodo = state.todos[index];
                          return TodoListTitle(currentTodo, index);
                        }),
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "You have done all tasks! 📝",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "click plus icon to add new task.👇",
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        )
                      ],
                    ),
                  );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTodoScreen(null)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Delete all"),
      onPressed: () {
        context.read<TodoBloc>().add(DeleteAll());
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete All"),
      content: const Text("Are you sure, do you want to remove all todos?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}


/*
body: ValueListenableBuilder<Box<TodoModel>>(
        valueListenable: Hive.box<TodoModel>("todo_app_task").listenable(),
        builder: (context, value, child) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Todays Task",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Dates come here",
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 18.0),
                ),
                Divider(
                  height: 40.0,
                  thickness: 1.0,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: box.values.length,
                        itemBuilder: (context, index) {
                          TodoModel currentTodo = box.getAt(index);
                          return TodoListTitle(currentTodo, index);
                        }))
              ],
            ),
          );
        },
      ),*/