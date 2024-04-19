import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app_task/bloc/todo_bloc.dart';

import '../domain/home/model/todo_model.dart';

// ignore: must_be_immutable
class AddTodoScreen extends StatefulWidget {
  AddTodoScreen(this.todoModel, {super.key});
  TodoData? todoModel;

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  bool? isChecked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.todoModel != null) {
      isChecked = widget.todoModel?.done;
    }
  }

  @override
  Widget build(BuildContext context) {
    final todoBloc = context.read<TodoBloc>();

    TextEditingController title = TextEditingController(
        text: widget.todoModel == null ? null : widget.todoModel!.title);
    TextEditingController description = TextEditingController(
        text: widget.todoModel == null ? null : widget.todoModel!.description);

    FocusNode descFocusNode = FocusNode();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.todoModel == null ? "Add a new Todo" : "Update your Todo",
        ),
        elevation: 0,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          print("On Tap View");
          descFocusNode.unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Todo Title",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextFormField(
                      controller: title,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid title";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.blue.shade100.withAlpha(75),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8.0)),
                        hintText: "Your todo title",
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Todo Description",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid description";
                        }
                        return null;
                      },
                      minLines: 5,
                      maxLines: 8,
                      focusNode: descFocusNode,
                      controller: description,
                      decoration: InputDecoration(
                        fillColor: Colors.blue.shade100.withAlpha(75),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8.0)),
                        hintText: "write some description..",
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    if (widget.todoModel != null)
                      CheckboxListTile(
                          title: const Text('Mark as completed'),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value;
                            });
                          }),
                  ]),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              var newTodo = TodoData(
                  title: title.text,
                  description: description.text,
                  done: false);

              if (widget.todoModel != null) {
                newTodo.done = isChecked;
                newTodo.id = widget.todoModel!.id;
                todoBloc.add(UpdateTodo(todoModel: newTodo));
                Fluttertoast.showToast(msg: "Successfully updated todo");
                Navigator.pop(context);
              } else {
                todoBloc.add(AddTodo(todoModel: newTodo));
                Fluttertoast.showToast(msg: "Successfully added todo");
                Navigator.pop(context);
              }
            }
          },
          child: Text(
            widget.todoModel == null ? "Save" : "Update",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
