import 'package:QMS_system/widget/common/sub_page_title.dart';
import 'package:QMS_system/widget/fmea_table/fmea_table_expansion_panel.dart';
import 'package:flutter/material.dart';

class FMEATablePage extends StatefulWidget {

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
          children: [
            SubPageTitle(title: "FMEA Table Management"),
            FMEATableExpansionPanelWidget()
          ],
        ),
      ),
    );
  }
}