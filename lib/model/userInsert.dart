import 'package:flutter/cupertino.dart';

class UserInsert {
  String name;
  String job;
  String age;

  UserInsert({@required this.name, @required this.job, @required this.age});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'job': job,
      'age': age,
    };
  }
}
