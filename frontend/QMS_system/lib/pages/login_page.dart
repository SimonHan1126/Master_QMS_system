import 'package:QMS_system/pages/home.dart';
import 'package:QMS_system/util/api_base_helper.dart';
import 'package:QMS_system/util/screen_util.dart';
import 'package:QMS_system/util/size_util.dart';
import 'package:QMS_system/util/snackbar_util.dart';
import 'package:QMS_system/widget/common/responsive_widget.dart';
import 'package:QMS_system/widget/common/sub_page_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {

  final ApiBaseHelper _helper = ApiBaseHelper();

  String _inputtedUserName;

  String _inputtedPassword;

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

  void _login() async {
    Navigator.push(context, MaterialPageRoute(
        builder: (context){return HomePage();}
    ));

    // final response = await _helper.post("login/login", {"userName" : _inputtedUserName, "password" : _inputtedPassword});
    // if (response["errorTag"] == 1) {
    //   SnackBarUtil.showSnackBar(context, response["message"]);
    // } else {
    //   print("this is login_page response RRRRRR" + response["message"]);
    //   MaterialPageRoute(builder: (context) => HomePage());
    // }
  }

  Widget _getDrawerItemWidget() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SubPageTitle(title: "Login Page"),
            Card(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: new TextFormField(
                  onChanged: (String value) async {
                    _inputtedUserName = value;
                  },
                  decoration: new InputDecoration(
                    hintText: "Enter User Name"
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: new TextFormField(
                  obscureText: true,
                  onChanged: (String value) async {
                    _inputtedPassword = value;
                  },
                  decoration: new InputDecoration(
                      hintText: "Enter Password"
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                _login();
              },
              child: Text("LOGIN",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF50AFC0))),
            )
          ],
        ),
      ),
    );
  }
}