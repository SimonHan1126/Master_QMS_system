import 'package:QMS_system/widget/common/drop_down_menu.dart';
import 'package:QMS_system/widget/common/sub_page_title.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ExpansionPanelWidget(),
            SubPageTitle(title: "Generate Report"),
            RaisedButton(
              child: Text("Generate"),
              onPressed: () {},
            )
          ],
        ),
      )
    );
  }
}