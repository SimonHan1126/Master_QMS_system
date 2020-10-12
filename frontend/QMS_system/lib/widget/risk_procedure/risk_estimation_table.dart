import 'package:QMS_system/model/risk_procedure.dart';
import 'package:QMS_system/widget/common/drop_down_menu.dart';
import 'package:flutter/material.dart';

class RiskEstimationTable extends StatefulWidget {

  final RiskProcedure riskProcedure;

  RiskEstimationTable(this.riskProcedure);

  @override
  _RiskEstimationTableState createState() => _RiskEstimationTableState();
}

class _RiskEstimationTableState extends State<RiskEstimationTable> {



  List<TableRow> _buildTableRowItemList(List<RiskProcedureItem> listSeverity, List<RiskProcedureItem> listProbability) {
    List<TableRow> tiles = [];

    int listSeverityLength = listSeverity.length;
    int listProbabilityLength = listProbability.length;

    for (int i = 0; i < listProbabilityLength; i++) {
      List<Widget> subTiles = [];
      RiskProcedureItem probabilityItem = listProbability.elementAt(i);
      String probabilityName = probabilityItem.name ?? "";
      subTiles.add(Container(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Text(
          probabilityName,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ));
      for (int j = 0; j < listSeverityLength; j++) {
        subTiles.add(Column(
          children: [DropDownMenu()],
        ));
      }

      tiles.add(TableRow(children: subTiles));
    }

    List<Widget> lastRow = [];
    lastRow.add(Container(// add empty item
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Text(
        "",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ));
    for (int k = 0; k < listSeverityLength; k++) {
      RiskProcedureItem severityItem = listSeverity.elementAt(k);
      String severityName = severityItem.name ?? "";
      lastRow.add(Container(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Text(
          severityName,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ));
    }
    tiles.add(TableRow(children: lastRow));
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    List<RiskProcedureItem> listSeverity = widget.riskProcedure.severity;
    List<RiskProcedureItem> listProbability = widget.riskProcedure.probability;

    Map<int, FractionColumnWidth> mapFractionColumnWidth = {};
    int listSeverityLength = listSeverity.length;
    if (listSeverity.length > 0) {
      double widthInPercent = 1 / (listSeverityLength + 1);
      print("this is risk_estimation_table widthInPercent " + widthInPercent.toString());
      for (int i = 0; i < listSeverity.length; i++) {
        mapFractionColumnWidth[i] = FractionColumnWidth(widthInPercent);
      }
    }

    return Container(
      margin: EdgeInsets.all(10),
      child: Table(
        border: TableBorder.all(),
        columnWidths: mapFractionColumnWidth,
        children: _buildTableRowItemList(listSeverity, listProbability),
      ),
    );
  }
}
