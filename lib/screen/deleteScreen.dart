import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:json_curd_doc/service/user_service.dart';

//use package in this session
//get_it

//use class in this session
//user_service

class DeleteScreen extends StatelessWidget {
  const DeleteScreen({this.id});
  final id;

  UserService get userService => GetIt.I<UserService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AlertDialog(
          title: Text("Warning!"),
          content: Text("Are you sure to want delete this user?"),
          actions: [
            FlatButton(
              onPressed: () {
                userService.deleteUser(id);
                Navigator.of(context).pop(context);
              },
              child: Text("Yes"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(context);
              },
              child: Text("No"),
            ),
          ],
        ),
      ),
    );
  }
}
