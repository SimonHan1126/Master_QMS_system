import 'package:QMS_system/pages/home.dart';
import 'package:QMS_system/util/api_base_helper.dart';
import 'package:QMS_system/util/screen_util.dart';
import 'package:QMS_system/util/size_util.dart';
import 'package:QMS_system/util/snackbar_util.dart';
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

  Widget _getDrawerItemWidget() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SubPageTitle(title: "Admin Page"),
          ],
        ),
      ),
    );
  }
}