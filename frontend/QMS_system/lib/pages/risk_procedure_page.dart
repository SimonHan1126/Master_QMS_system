import 'package:QMS_system/bloc/risk_procedure_list_bloc.dart';
import 'package:QMS_system/widget/risk_procedure/risk_procedure_expansion_panel.dart';
import 'package:QMS_system/widget/common/sub_page_title.dart';
import 'package:QMS_system/widget/test/test.dart';
import 'package:flutter/material.dart';

class RiskProcedurePage extends StatefulWidget {

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
            RiskProcedureExpansionPanelWidget()
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