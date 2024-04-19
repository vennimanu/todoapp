import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_task/bloc/todo_bloc.dart';
import 'package:todo_app_task/domain/home/hive_methods.dart';
import 'package:todo_app_task/screens/home_page.dart';
import 'domain/home/model/todo_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<TodoData>(TodoModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(todoHiveMethods: TodoHiveHelper()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Todo',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.blue, foregroundColor: Colors.white),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage()),
    );
  }
}
