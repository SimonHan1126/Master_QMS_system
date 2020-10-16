import 'package:QMS_system/constant/strings.dart';
import 'package:QMS_system/constant/text_styles.dart';
import 'package:QMS_system/pages/admin.dart';
import 'package:QMS_system/pages/fmea_table_page.dart';
import 'package:QMS_system/pages/report_page.dart';
import 'package:QMS_system/pages/risk_procedure_page.dart';
import 'package:QMS_system/util/screen_util.dart';
import 'package:QMS_system/util/size_util.dart';
import 'package:QMS_system/widget/common/responsive_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
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
        return RiskProcedurePage();
      case 1:
        return FMEATablePage();
      case 2:
        return AdminPage();
        // return ReportPage();
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
            text: Strings.portfoli,
            style: TextStyles.logo,
          ),
          TextSpan(
            text: Strings.o,
            style: TextStyles.logo.copyWith(
              color: Color(0xFF50AFC0),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      MaterialButton(
        child: Text(
          Strings.menu_procedure,
          style: TextStyles.menu_item.copyWith(
            color: Color(0xFF50AFC0),
          ),
        ),
        onPressed: () {
          setState(() {
            _selectedDrawerIndex = 0;
          });
          if (ResponsiveWidget.isSmallScreen(context)) Navigator.pop(context);
        },
      ),
      MaterialButton(
        child: Text(
          Strings.menu_fmea,
          style: TextStyles.menu_item.copyWith(
            color: Color(0xFF50AFC0),
          ),
        ),
        onPressed: () {
          setState(() {
            _selectedDrawerIndex = 1;
          });
          if (ResponsiveWidget.isSmallScreen(context)) Navigator.pop(context);
        },
      ),
      MaterialButton(
        child: Text(
          Strings.menu_report,
          style: TextStyles.menu_item.copyWith(
            color: Color(0xFF50AFC0),
          ),
        ),
        onPressed: () {
          setState(() {
            _selectedDrawerIndex = 2;
          });
          if (ResponsiveWidget.isSmallScreen(context)) Navigator.pop(context);
        },
      ),
    ];
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