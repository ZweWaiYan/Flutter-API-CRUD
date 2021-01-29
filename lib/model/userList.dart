class UserList {
  String id;
  String name;
  String job;
  String age;

  UserList({
    this.id,
    this.name,
    this.job,
    this.age,
  });

  factory UserList.fromJson(Map<String, dynamic> data) {
    return UserList(
      id: data['id'],
      name: data['name'],
      job: data['job'],
      age: data['age'],
    );
  }
}
