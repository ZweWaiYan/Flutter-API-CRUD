import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:json_curd_doc/model/userInsert.dart';
import 'package:json_curd_doc/model/userList.dart';
import 'package:json_curd_doc/service/user_service.dart';

//use package in this session
//get_it

//use class in this session
//user_service
//userInsert
//userList

class EditScreen extends StatefulWidget {
  final String id;
  final String name;
  final String job;
  final String age;
  const EditScreen({this.name, this.job, this.age, this.id});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  UserService get userService => GetIt.I<UserService>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _jobController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  //hint: to show existed data in TextField(this Screen) that data must not be null.
  bool get isEditing => widget.id != null;
  //hint: take time for show data in TextField(this Screen)
  bool isLoading = false;
  //hint: while get data from API if something wrong show error message
  String errorMessage;
  //hint: if get data from API to show like 'user.name' in UI
  UserList user;

  //hint: Error message for textField

  @override
  void initState() {
    super.initState();

    setState(() {
      isLoading = true;
    });

    userService.getUser(widget.id).then((value) {
      setState(() {
        isLoading = false;
      });

      if (value.error) {
        errorMessage = value.errorMessage ?? "An error occured";
      } else {
        user = value.data;
      }

      if (isEditing) {
        _nameController.text = user.name;
        _jobController.text = user.job;
        _ageController.text = user.age;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update User"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                //todo add 2: need to add error message in textField.
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
                      keyboardType: TextInputType.number),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: () async {
                            UserInsert userInsert = UserInsert(
                              name: _nameController.text,
                              job: _jobController.text,
                              age: _ageController.text,
                            );
                            // //hint: use Getit package to call from user_service function.
                            await userService.updateUser(widget.id, userInsert);
                            Navigator.pop(context);
                          },
                          child: Text("Update"),
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
