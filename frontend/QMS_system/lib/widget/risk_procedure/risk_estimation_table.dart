import 'package:QMS_system/constant/constants.dart';
import 'package:QMS_system/model/risk_procedure.dart';
import 'package:QMS_system/util/base_util.dart';
import 'package:QMS_system/widget/common/drop_down_menu.dart';
import 'package:flutter/material.dart';

class RiskEstimationTable extends StatefulWidget {

  final RiskProcedure _riskProcedure;

  final Function(Map<String, dynamic>) _callback;

  final bool _isShowDropdownMenu;

  RiskEstimationTable(this._riskProcedure, this._callback, this._isShowDropdownMenu);

  @override
  _RiskEstimationTableState createState() => _RiskEstimationTableState();
}

class _RiskEstimationTableState extends State<RiskEstimationTable> {

  callback(Map<String, dynamic> selectedValue) {
    widget._callback(selectedValue);
  }

  List<TableRow> _buildTableRowItemList(List<RiskProcedureItem> listSeverity, List<RiskProcedureItem> listProbability) {
    List<TableRow> tiles = List();

    int listSeverityLength = listSeverity.length;
    int listProbabilityLength = listProbability.length;
    Map<String, dynamic> mapRiskEstimation = widget._riskProcedure.mapRiskEstimation;

    for (int i = 0; i < listProbabilityLength; i++) {
      List<Widget> subTiles = List();
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
        RiskProcedureItem severityItem = listSeverity.elementAt(j);
        List<Map<String,dynamic>> rpiList = List();
        rpiList.add(probabilityItem.toJson());
        rpiList.add(severityItem.toJson());
        Widget itemWidget;
        String riskLevelKey = BaseUtil.getRiskEstimationKey(probabilityItem.id, severityItem.id);
        String riskLevel = mapRiskEstimation[riskLevelKey]??Constants.list_severity_probability_level[0];
        if (widget._isShowDropdownMenu) {
          itemWidget =  DropDownMenu(
            Constants.dropdown_tag_risk_procedure,
            widget._riskProcedure.riskProcedureId,
            riskLevel,
            Colors.green,
            rpiList,
            Constants.map_severity_probability_level_to_color,
            callback);
        } else {
          itemWidget = Text(riskLevel, style: TextStyle(backgroundColor: Constants.map_severity_probability_level_to_color[riskLevel]));
        }

        subTiles.add(Column(
          children: [itemWidget],
        ));
      }

      tiles.add(TableRow(children: subTiles));
    }

    List<Widget> lastRow = List();
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
    List<RiskProcedureItem> listSeverity = widget._riskProcedure.severity;
    List<RiskProcedureItem> listProbability = widget._riskProcedure.probability;

    Map<int, FractionColumnWidth> mapFractionColumnWidth = {};
    int listSeverityLength = listSeverity.length;
    if (listSeverity.length > 0) {
      double widthInPercent = 1 / (listSeverityLength + 1);
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

  @override
  void initState() {
    super.initState();
  }
}
