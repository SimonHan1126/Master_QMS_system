import 'package:QMS_system/model/user.dart';
import 'package:QMS_system/widget/common/sub_page_title.dart';
import 'package:QMS_system/widget/fmea_table/fmea_spreadsheet_table.dart';
import 'package:flutter/material.dart';

class FMEATablePage extends StatefulWidget {

  final User _user;

  FMEATablePage(this._user);

  @override
  _FMEATablePageState createState() => _FMEATablePageState();
}

class _FMEATablePageState extends State<FMEATablePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SubPageTitle(title: "FMEA Table Management"),
            // FMEATableExpansionPanelWidget(widget._user)
            FMEASpreadsheetTable()
          ],
        ),
      ),
    );
  }
}