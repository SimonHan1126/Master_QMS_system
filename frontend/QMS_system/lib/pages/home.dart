import 'package:QMS_system/constant/constants.dart';
import 'package:QMS_system/constant/text_styles.dart';
import 'package:QMS_system/model/user.dart';
import 'package:QMS_system/pages/admin.dart';
import 'package:QMS_system/pages/example_page.dart';
import 'package:QMS_system/widget/fmea_table/fmea_spreadsheet_table.dart';
import 'package:QMS_system/pages/fmea_table_page.dart';
import 'package:QMS_system/pages/login_page.dart';
import 'package:QMS_system/pages/report_page.dart';
import 'package:QMS_system/pages/risk_procedure_page.dart';
import 'package:QMS_system/util/screen_util.dart';
import 'package:QMS_system/util/size_util.dart';
import 'package:QMS_system/widget/common/responsive_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  final User _user;

  HomePage(this._user);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  int _selectedDrawerIndex = 0;

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
//          backgroundColor: Colors.transparent,
            appBar: _buildAppBar(context),
            drawer: _buildDrawer(context),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: _getDrawerItemWidget(_selectedDrawerIndex),
                ),
              ],
            )),
      ),
    );
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return RiskProcedurePage(widget._user);
      case 1:
        return FMEATablePage(widget._user);
      case 2:
        return AdminPage();
        // return ReportPage();
      case 3:
        return Container();
    }
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: Constants.portfoli,
            style: TextStyles.logo,
          ),
          TextSpan(
            text: Constants.o,
            style: TextStyles.logo.copyWith(
              color: Color(0xFF50AFC0),
            ),
          ),
        ],
      ),
    );
  }

  _onMaterialButtonClick(BuildContext context, int pos) {
    setState(() {
      _selectedDrawerIndex = pos;
    });
    if (ResponsiveWidget.isSmallScreen(context)) Navigator.pop(context);

    switch (pos) {
      case 3:
        Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(
            builder: (context){return LoginPage();}
        ), (Route<dynamic> route) => false);
        return;
    }
  }

  Widget _buildItemMaterialButton(BuildContext context, String text, int selectIndex) {
    return MaterialButton(
      child: Text(
        text,
        style: TextStyles.menu_item.copyWith(
          color: Color(0xFF50AFC0),
        ),
      ),
      onPressed: () {
        _onMaterialButtonClick(context, selectIndex);
      },
    );
  }

  List<Widget> _buildActions(BuildContext context) {

    List<MaterialButton> buttonList = List();
    buttonList.add(_buildItemMaterialButton(context, Constants.menu_procedure, 0));
    buttonList.add(_buildItemMaterialButton(context, Constants.menu_fmea, 1));
    if (widget._user.userPermission == Constants.user_permission_admin) {
      buttonList.add(_buildItemMaterialButton(context, Constants.menu_admin, 2));
    }
    buttonList.add(_buildItemMaterialButton(context, Constants.menu_logout, 3));
    return buttonList;
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      title: _buildTitle(),
      backgroundColor: Color(0xFFf1f3f4),
      elevation: 0.0,
      actions: !ResponsiveWidget.isSmallScreen(context)
          ? _buildActions(context)
          : null,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? Drawer(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: _buildActions(context),
      ),
    )
        : null;
  }
}