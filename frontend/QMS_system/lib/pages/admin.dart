import 'package:QMS_system/bloc/bloc_provider.dart';
import 'package:QMS_system/bloc/user_list_bloc.dart';
import 'package:QMS_system/model/user.dart';
import 'package:QMS_system/util/screen_util.dart';
import 'package:QMS_system/util/size_util.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userListBloc.getAllUser();
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

  Widget _buildUserEditBoxes(List<User> userList) {
    List<Widget> list = [];
    list.add(SubPageTitle(title: "Admin Page"));

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
                  List<User> list = snapshot.data;
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