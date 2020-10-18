import 'package:QMS_system/model/user.dart';
import 'package:QMS_system/widget/risk_procedure/risk_procedure_expansion_panel.dart';
import 'package:QMS_system/widget/common/sub_page_title.dart';
import 'package:flutter/material.dart';

class RiskProcedurePage extends StatefulWidget {

  final User _user;

  RiskProcedurePage(this._user);

  @override
  _RiskProcedurePageState createState() => _RiskProcedurePageState();
}

class _RiskProcedurePageState extends State<RiskProcedurePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SubPageTitle(title: "Risk Procedure Management"),
            RiskProcedureExpansionPanelWidget(widget._user)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}