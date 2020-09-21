import 'package:QMS_system/widget/common/drop_down_menu.dart';
import 'package:flutter/material.dart';

class RiskEstimationTable extends StatefulWidget {
  @override
  _RiskEstimationTableState createState() => _RiskEstimationTableState();
}

class _RiskEstimationTableState extends State<RiskEstimationTable> {

  List _tableList = [
    ["Frequent"   ,"#"          ,"#"      ,"#"        ,"#"      ,"#"],
    ["Probable"   ,"#"          ,"#"      ,"#"        ,"#"      ,"#"],
    ["Occasional" ,"#"          ,"#"      ,"#"        ,"#"      ,"#"],
    ["Remote"     ,"#"          ,"#"      ,"#"        ,"#"      ,"#"],
    ["Improbable" ,"#"          ,"#"      ,"#"        ,"#"      ,"#"],
    [""           ,"Negligible" ,"Minor"  ,"Serious"  ,"Major"  ,"Critical"],
  ];

  List<TableRow> _buildTableRowItemList() {
    List<TableRow> tiles = [];
    for (var itemList in _tableList) {
      List<Widget> subTiles = [];
      for (var item in itemList) {
        String tableItem = item;

        if (tableItem.compareTo("#") == 0) {
          subTiles.add(Column(
            children: [DropDownMenu()],
          ));
        } else {
          subTiles.add(Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Text(
              tableItem,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ));
        }
      }

      tiles.add(
        TableRow(children: subTiles)
      );
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FractionColumnWidth(.167),
          1: FractionColumnWidth(.167),
          2: FractionColumnWidth(.167),
          3: FractionColumnWidth(.167),
          4: FractionColumnWidth(.167),
          5: FractionColumnWidth(.167)
        },
        children: _buildTableRowItemList(),
      ),
    );
  }
}
