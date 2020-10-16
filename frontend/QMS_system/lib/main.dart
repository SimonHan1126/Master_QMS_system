import 'dart:io';

import 'package:QMS_system/pages/home.dart';
import 'package:QMS_system/pages/login_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
        child:MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'QMS_AUT',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          navigatorObservers: [BotToastNavigatorObserver()],//2.registered route observer
          // home: HomePage(),
          home: LoginPage(),
          routes: <String, WidgetBuilder>{
            '/homePage': (BuildContext context) => HomePage(),
          },
        )
    );
  }
}
