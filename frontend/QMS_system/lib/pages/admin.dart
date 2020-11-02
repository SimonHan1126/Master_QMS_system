import 'package:QMS_system/constant/constants.dart';
import 'package:QMS_system/bloc/bloc_provider.dart';
import 'package:QMS_system/bloc/user_list_bloc.dart';
import 'package:QMS_system/model/user.dart';
import 'package:QMS_system/util/base_util.dart';
import 'package:QMS_system/util/screen_util.dart';
import 'package:QMS_system/util/size_util.dart';
import 'package:QMS_system/widget/common/drop_down_menu.dart';
import 'package:QMS_system/widget/common/responsive_widget.dart';
import 'package:QMS_system/widget/common/sub_page_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminPageState();
  }
}

class AdminPageState extends State<AdminPage> {

  final _userListBloc = UserListBloc();

  Map<String, dynamic> _dropdownSelectedMap = {};

  TextStyle _commonTextStyle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userListBloc.getAllUser();
    _commonTextStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Color(0xFF50AFC0));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    SizeUtil.size = MediaQuery.of(context).size;
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: !ResponsiveWidget.isSmallScreen(context)
                ? (ScreenUtil.getInstance().setWidth(108))
                : (ScreenUtil.getInstance().setWidth(6))), //144
        child: Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  child: _getDrawerItemWidget(),
                ),
              ],
            )),
      ),
    );
  }

  _userPermissionSelectCallback(Map<String, dynamic> map) {
    String userId = map["userId"];
    int userPermission = map["userPermission"];
    _dropdownSelectedMap[userId] = userPermission;
  }

  Widget _buildUserEditBoxes(List<User> userList) {
    List<Widget> list = [];
    list.add(SubPageTitle(title: "Admin Page"));
    for (int i = 0; i < userList.length; i++) {
      User user = userList.elementAt(i);
      String userName = user.userName??"";
      String password = user.password??"";
      InputDecoration inputDecorationUserName;
      InputDecoration inputDecorationPassword;
      userName.length > 0 ?  inputDecorationUserName = InputDecoration(hintText: userName) : inputDecorationUserName = InputDecoration(hintText: "Enter user name");
      password.length > 0 ?  inputDecorationPassword = InputDecoration(hintText: password) : inputDecorationPassword = InputDecoration(hintText: "Enter password");
      list.add(Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("User name",style: _commonTextStyle),
            TextFormField(
                onChanged: (String value) async {
                  user.userName = value;
                },
                decoration: inputDecorationUserName
            ),
            Text("Password",style: _commonTextStyle),
            TextFormField(
                onChanged: (String value) async {
                  user.password = value;
                },
                decoration: inputDecorationPassword
            ),
            Text("User Permission",style: _commonTextStyle),
            DropDownMenu(
                Constants.dropdown_admin_user_permission,
                user.userId,
                Constants.map_permission_reverse[user.userPermission],
                Constants.map_permission_int_color[user.userPermission],
                Constants.user_permission_string_list,
                Constants.map_permission_color,
                _userPermissionSelectCallback
            ),
            Row(
              children: [
                FlatButton(
                  onPressed: () {
                    if (_dropdownSelectedMap[user.userId] != null) {
                      user.userPermission = _dropdownSelectedMap[user.userId];
                    }
                    _userListBloc.saveUser(user);
                  },
                  child: Text("Save User", style: _commonTextStyle),
                ),
                FlatButton(
                  onPressed: () {
                    _userListBloc.removeUser(user.userId);
                  },
                  child: Text("Remove User", style: _commonTextStyle),
                )
              ],
            )
          ],
        ),
      ));
    }
    list.add(FlatButton(onPressed: (){
      _userListBloc.addUser(User(BaseUtil.getCurrentTimestamp(), "", "",0));
    }, child: Text("Add User", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF50AFC0)))));
    return ListBody(
      children: list,
    );
  }

  Widget _getDrawerItemWidget() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocProvider<UserListBloc>(
              bloc: _userListBloc,
              child: StreamBuilder(
                stream: _userListBloc.userListStream,
                builder: (context, snapshot) {
                  List<User> list = snapshot.data??[];
                  return _buildUserEditBoxes(list);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userListBloc.dispose();
  }
}