part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class GetAll extends TodoEvent {}

final class AddTodo extends TodoEvent {
  final TodoData todoModel;
  AddTodo({required this.todoModel});
}

final class UpdateTodo extends TodoEvent {
  final TodoData todoModel;
  UpdateTodo({required this.todoModel});
}

final class DeleteTodo extends TodoEvent {
  final TodoData todoModel;
  DeleteTodo({required this.todoModel});
}

final class DeleteAll extends TodoEvent {}
