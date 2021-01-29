import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:json_curd_doc/screen/homeScreen.dart';
import 'package:json_curd_doc/service/api_response.dart';
import 'package:json_curd_doc/service/user_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'model/userList.dart';

//API => mockAPI

//use package in this session
//get_it

//use class in this session
//user_service

void setupLocator() {
  GetIt.I.registerLazySingleton(() => UserService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(title: 'User Lists'),
    );
  }
}
