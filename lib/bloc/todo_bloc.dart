import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_task/domain/home/hive_methods.dart';
import 'package:todo_app_task/domain/home/model/todo_model.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoHiveHelper todoHiveMethods;

  TodoBloc({required this.todoHiveMethods}) : super(TodoInitial()) {
    on<GetAll>((event, emit) async {
      final todos = await todoHiveMethods.getTodoLists();
      emit(TodoListState(todos: todos));
    });

    on<AddTodo>((event, emit) async {
      await todoHiveMethods.insertTodo(event.todoModel);
      final todos = await todoHiveMethods.getTodoLists();
      emit(TodoListState(todos: todos));
    });

    on<DeleteTodo>((event, emit) async {
      await todoHiveMethods.deleteTodo(event.todoModel.id!);
      final todos = await todoHiveMethods.getTodoLists();
      emit(TodoListState(todos: todos));
    });

    on<UpdateTodo>((event, emit) async {
      await todoHiveMethods.updateTodo(event.todoModel);
      final todos = await todoHiveMethods.getTodoLists();
      emit(TodoListState(todos: todos));
    });

    on<DeleteAll>((event, emit) async {
      await todoHiveMethods.deleteAllTodos();
      final todos = await todoHiveMethods.getTodoLists();
      emit(TodoListState(todos: todos));
    });
  }
}
//ATBBBjg3Vd56h47r72AdRTVmRkAp5B7DCB57