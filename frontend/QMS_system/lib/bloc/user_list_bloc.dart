import 'dart:async';

import 'package:QMS_system/model/user.dart';
import 'package:QMS_system/util/api_base_helper.dart';

import 'bloc.dart';

class UserListBloc implements Bloc {

  var _userList = [];
  // 1
  final _userListController = StreamController<List<User>>();
  final ApiBaseHelper _helper = ApiBaseHelper();

  Stream<List<User>> get userListStream => _userListController.stream;
  StreamSink<List<User>> get userListSink => _userListController.sink;

  void getAllUser() async {
    _userList = await _helper.get("user/getAllUser");
    _userListController.sink.add(
        _userList.map<User>((json) => User.fromJson(json)).toList(growable: false)
    );
  }

  void removeUser(String userId) async{
    _userList = await _helper.get("user/removeUser?userId=$userId");
    _userListController.sink.add(
        _userList.map<User>((json) => User.fromJson(json)).toList(growable: false)
    );
  }

  void addUser(User user) async {
    final response = await _helper.post("user/saveUser", user);
    _userList.add(response);
    _userListController.sink.add(
        _userList.map<User>((json) => User.fromJson(json)).toList(growable: false)
    );
  }

  @override
  void dispose() {
    _userListController.close();
  }
}