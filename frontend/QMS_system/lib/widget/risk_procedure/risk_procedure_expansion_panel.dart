import 'package:flutter/material.dart';

class RiskProcedureExpansionPanelWidget extends StatefulWidget {
  RiskProcedureExpansionPanelWidgetState createState() =>  RiskProcedureExpansionPanelWidgetState();
}

class RiskProcedureExpansionPanelWidgetState extends State<RiskProcedureExpansionPanelWidget> {

  bool _isExpanded = false;

  List _subTitleList = ["Severity","Severity Description", "Probability", "Probability Description"];

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildExpansionPanelItemList() {
    List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
    for (var item in _subTitleList) {
      tiles.add(
        Card(
          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: new TextFormField(
              decoration: new InputDecoration(
                  labelText: item,
                  hintText: item,
                  hintStyle: TextStyle(color: Colors.grey)
              ),
            ),
          ),
        ),
      );
    }
    return tiles;
  }

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ExpansionPanelList(
            children: <ExpansionPanel>[
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text("Risk Procedure"),
                  );
                },
                body: Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
                  child: ListBody(
                    children: _buildExpansionPanelItemList(),

                  ),
                ),
                isExpanded: _isExpanded,
                canTapOnHeader: true,
              ),
            ],
            expansionCallback: (panelIndex, isExpanded) {
              print("this is expansionCallback panelIndex " +
                  panelIndex.toString() +
                  " isExpanded " +
                  isExpanded.toString());
              setState(() {
                _isExpanded = !isExpanded;
              });
            },
            animationDuration: kThemeAnimationDuration,
          ),
        ],
      ),
    );
  }
}