import 'package:QMS_system/constant/constants.dart';
import 'package:QMS_system/constant/text_styles.dart';
import 'package:QMS_system/model/user.dart';
import 'package:QMS_system/pages/home.dart';
import 'package:QMS_system/util/api_base_helper.dart';
import 'package:QMS_system/util/screen_util.dart';
import 'package:QMS_system/util/size_util.dart';
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

  String _inputtedUserName = "";

  String _inputtedPassword = "";

  String _errorMessage = "";

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
            appBar: _buildAppBar(context),
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

    if (_inputtedUserName.length <= 0 || _inputtedPassword.length <= 0) {
      setState(() {
        _errorMessage = "User name or password cannot be empty";
      });
      return;
    }

    final response = await _helper.post("login/login", {"userName" : _inputtedUserName, "password" : _inputtedPassword});
    if (response["errorTag"] == 1) {
      setState(() {
        _errorMessage = response["message"];
      });
    } else {
      Navigator.push(context, MaterialPageRoute(
          builder: (context){return HomePage(User.fromJson(response));}
      ));
    }
  }

  Widget _getDrawerItemWidget() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SubPageTitle(title: "Sign in to QMS"),
            Card(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: new TextFormField(
                  onChanged: (String value) async {
                    _inputtedUserName = value;
                    setState(() {
                      _errorMessage = "";
                    });
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
                    setState(() {
                      _errorMessage = "";
                    });
                  },
                  decoration: new InputDecoration(
                      hintText: "Enter Password"
                  ),
                ),
              ),
            ),
            Text(_errorMessage, style: TextStyle(color: Colors.red)),
            RaisedButton(
              onPressed: () {
                _login();
              },
              color:  Color(0xFF50AFC0),
              child: Text("SIGN IN WITH USER NAME",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20)),
            ),
          ],
        ),
      ),
    );
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

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      title: _buildTitle(),
      backgroundColor: Color(0xFFf1f3f4),
      elevation: 0.0,
      // actions: !ResponsiveWidget.isSmallScreen(context)
      //     ? _buildActions(context)
      //     : null,
    );
  }
}