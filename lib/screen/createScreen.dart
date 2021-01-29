import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:json_curd_doc/model/userInsert.dart';
import 'package:json_curd_doc/service/user_service.dart';

//use package in this session
//get_it

//use class in this session
//user_service
//userInsert

class CreateScreen extends StatelessWidget {
  //hint: get value from textField
  TextEditingController _nameController = TextEditingController();
  TextEditingController _jobController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  //hint: I Short form of Instance
  UserService get userService => GetIt.I<UserService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          //todo add 1: need to add error message in textField.
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: "Name"),
            ),
            TextField(
              controller: _jobController,
              decoration: InputDecoration(hintText: "Job"),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(hintText: "Age"),
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton(
              onPressed: () async {
                UserInsert userInsert = UserInsert(
                  name: _nameController.text,
                  job: _jobController.text,
                  age: _ageController.text,
                );
                //hint: use Getit package to call from user_service function.
                await userService.createUser(userInsert);
                Navigator.pop(context);
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
