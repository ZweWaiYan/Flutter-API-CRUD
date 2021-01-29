import 'dart:convert';

import 'package:json_curd_doc/model/userInsert.dart';
import 'package:json_curd_doc/model/userList.dart';
import 'package:http/http.dart' as http;
import 'package:json_curd_doc/service/api_response.dart';

//refer
//https://flutter.dev/docs/cookbook/networking/background-parsing#2-make-a-network-request
//https://flutter.dev/docs/cookbook/networking/fetch-data
//https://flutter.dev/docs/development/data-and-backend/json

class UserService {
  static const API_URL = "https://600fae2d6c21e1001704f132.mockapi.io/api";

  //Display All User Information
  Future<APIResponse<List<UserList>>> getNoteList() async {
    var url = await http.get(API_URL + "/users");
    if (url.statusCode == 200) {
      final jsonData = jsonDecode(url.body);
      List<UserList> user = [];
      for (var data in jsonData) {
        user.add(UserList.fromJson(data));
      }

      return APIResponse<List<UserList>>(data: user);
    } else {
      return APIResponse<List<UserList>>(
        error: true,
        errorMessage: 'An error occured',
      );
    }
  }

  static const header = {'Content-Type': "application/json"};

  //Create User
  Future<APIResponse<bool>> createUser(UserInsert item) async {
    return await http
        .post(API_URL + "/users/",
            headers: header, body: jsonEncode(item.toJson()))
        .then((value) {
      if (value.statusCode == 201) {
        return APIResponse<bool>(data: true);
      } else {
        return APIResponse<bool>(
          error: true,
          errorMessage: 'An error occured',
        );
      }
    });
  }

  //Delete User
  Future<APIResponse<bool>> deleteUser(String id) async {
    return await http
        .delete(API_URL + "/users/" + id, headers: header)
        .then((value) {
      if (value.statusCode == 204) {
        return APIResponse<bool>(data: true);
      } else {
        return APIResponse<bool>(
          error: true,
          errorMessage: 'An error occured',
        );
      }
    });
  }

  //Edit User
  //Get User for show only one(In Edit Screen)
  Future<APIResponse<UserList>> getUser(String id) async {
    return await http.get(API_URL + "/users/$id").then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);
        return APIResponse<UserList>(data: UserList.fromJson(jsonData));
      } else {
        return APIResponse<UserList>(
          error: true,
          errorMessage: 'An error occured',
        );
      }
    });
  }

  //Edit User
  Future<APIResponse<bool>> updateUser(String id, UserInsert item) async {
    return await http
        .put(API_URL + "/users/" + id,
            headers: header, body: json.encode(item.toJson()))
        .then((value) {
      if (value.statusCode == 201) {
        return APIResponse<bool>(data: true);
      } else {
        return APIResponse(error: true, errorMessage: "An Error occoured");
      }
    });
  }
}
