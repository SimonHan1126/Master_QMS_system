class User {
  String userId;
  String userName;
  String password;
  int userPermission;

  User(this.userId, this.userName, this.password, this.userPermission);

  User.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        userName = json['userName'],
        password = json['password'],
        userPermission = json['userPermission'];

  Map<String, dynamic> toJson() =>
      {
        'userId': userId,
        'userName': userName,
        'password': password,
        'userPermission': userPermission,
      };
}