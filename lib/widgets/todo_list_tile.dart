import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app_task/bloc/todo_bloc.dart';
import 'package:todo_app_task/screens/task_editor.dart';

import '../domain/home/model/todo_model.dart';

// ignore: must_be_immutable
class TodoListTitle extends StatelessWidget {
  TodoListTitle(this.todoModel, this.index, {super.key});

  TodoData todoModel;
  int index;

  @override
  Widget build(BuildContext context) {
    final todoBloc = context.read<TodoBloc>();
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    todoModel.done = tick(todoModel.done);
                    todoBloc.add(UpdateTodo(todoModel: todoModel));
                    Fluttertoast.showToast(
                        msg:
                            "Successfully marked as ${todoModel.done == true ? "done" : "not completed"}");
                  },
                  icon: todoModel.done == false
                      ? const Icon(Icons.circle_outlined)
                      : const Icon(Icons.check_circle_rounded)),
              Expanded(
                  child: Text(
                todoModel.title!,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddTodoScreen(todoModel);
                    }));
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    todoBloc.add(DeleteTodo(todoModel: todoModel));
                    Fluttertoast.showToast(msg: "Successfully deleted todo");
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          ),
          const Divider(
            color: Colors.black87,
            height: 20.0,
            thickness: 1.0,
          ),
          Text(
            todoModel.description!,
            style: const TextStyle(fontSize: 16.0),
          )
        ],
      ),
    );
  }

  bool tick(tick) => !tick;
}
