import 'package:hive/hive.dart';
import 'package:todo_app_task/domain/home/model/todo_model.dart';

class TodoHiveHelper {
  String dbName = 'todo_app_task';

  //Reading all the users data
  Future<List<TodoData>> getTodoLists() async {
    final box = await Hive.openBox<TodoData>(dbName);
    return box.values.toList();
  }

  //Deleting one data from hive DB
  Future<void> deleteTodo(int id) async {
    final box = await Hive.openBox<TodoData>(dbName);
    await box.delete(id);
  }

  //Deleting whole data from Hive
  Future<void> deleteAllTodos() async {
    var box = await Hive.openBox<TodoData>(dbName);
    await box.clear();
  }

//Insert new todo
  Future<void> insertTodo(TodoData todo) async {
    final box = await Hive.openBox<TodoData>(dbName);
    var newTodo = todo;
    // take key as id
    final int id = await box.add(newTodo);
    // add id to todomodel
    newTodo.id = id;
    // save
    newTodo.save();
  }

  // update todo from hive using key as id
  Future<void> updateTodo(
    TodoData todo,
  ) async {
    final box = await Hive.openBox<TodoData>(dbName);
    await box.put(todo.id, todo);
  }
}
