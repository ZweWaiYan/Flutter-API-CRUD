import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:json_curd_doc/model/userList.dart';
import 'package:json_curd_doc/screen/createScreen.dart';
import 'package:json_curd_doc/screen/deleteScreen.dart';
import 'package:json_curd_doc/screen/editScreen.dart';
import 'package:json_curd_doc/service/api_response.dart';
import 'package:json_curd_doc/service/user_service.dart';

//use package in this session
//Slidable
//get_it

//use class in this session
//user_service
//api_response
//userList

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //hint : use GetIt package to get function from another location.
  UserService get service => GetIt.instance<UserService>();
  //hint : with created Name
  UserService userService;

  List<UserList> user = []; //todo check 1: Need to check it necessary or not!
  APIResponse<List<UserList>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchUser();
    super.initState();
  }

  void _fetchUser() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNoteList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateScreen()))
              .then((value) {
            _fetchUser();
          });
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: service.getNoteList(),
        builder: (BuildContext context,
            AsyncSnapshot<APIResponse<List<UserList>>> snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(backgroundColor: Colors.red),
            );
          } else {
            return ListView.builder(
              itemCount: _apiResponse.data
                  .length, //todo check 2: Check display red error message course of itemCount is null
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actions: <Widget>[
                        IconSlideAction(
                          icon: Icons.edit,
                          color: Colors.green,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        EditScreen(
                                          id: _apiResponse.data[index].id,
                                          name: _apiResponse.data[index].name,
                                          age: _apiResponse.data[index].age,
                                          job: _apiResponse.data[index].job,
                                        ))).then((value) {
                              _fetchUser();
                            });
                          },
                        ),
                      ],
                      secondaryActions: [
                        IconSlideAction(
                          icon: Icons.delete,
                          color: Colors.red,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DeleteScreen(
                                  id: _apiResponse.data[index].id);
                            })).then((value) {
                              _fetchUser();
                            });
                          },
                        ),
                      ],
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(_apiResponse.data[index].name),
                              subtitle:
                                  Text(_apiResponse.data[index].age.toString()),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 0.0, 15.0, 0.0),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(_apiResponse.data[index].job),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
