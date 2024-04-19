part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoListState extends TodoState {
  final List<TodoData> todos;
  TodoListState({required this.todos});
}
