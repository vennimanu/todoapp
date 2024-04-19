# Todo App
Save Todo's into local database\
fetch list of todo's\
edit, delete and mark as complete todo's\

## Database: Hive
## State Management: Bloc

## Step 1:

Download or clone this repo by using the link below:

https://github.com/vennimanu/todoapp.git

## Step 2:

Go to project root and execute the following command in console to get the required dependencies:

flutter pub get 
## Step 3:

This project uses inject library that works with code generation, execute the following command to generate files:

flutter packages pub run build_runner build --delete-conflicting-outputs
or watch command in order to keep the source code synced automatically:

flutter packages pub run build_runner watch

## Features

. View list of Todos\
. Add new Todo\
. Update new Todo\
. Delete Todo\
. Mark as completed\
. Delete All\

Libraries & Tools Used

[Hive (Database)](https://pub.dev/packages/hive)\
[Path Provider](https://pub.dev/packages/path_provider)\
[Bloc (State Management)](https://pub.dev/packages/bloc)\
[FlutterToast (To show toast messages)](https://pub.dev/packages/fluttertoast)\
## Screens

HomePage
TaskEditor

## Helper Class
TodoHiveHelper

Folder Structure

flutter-app/
|- android
|- build
|- ios
|- lib
|- test





