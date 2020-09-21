import 'package:QMS_system/widget/risk_procedure/risk_estimation_table.dart';
import 'package:flutter/material.dart';

class RiskProcedureExpansionPanelWidget extends StatefulWidget {
  RiskProcedureExpansionPanelWidgetState createState() =>  RiskProcedureExpansionPanelWidgetState();
}

class RiskProcedureExpansionPanelWidgetState extends State<RiskProcedureExpansionPanelWidget> {

  bool _isExpanded = false;

  List _subTitleList = ["Harm", "Severity","Severity Description", "Probability", "Probability Description"];

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildExpansionPanelItemList() {
    List<Widget> tiles = [];
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
    tiles.add(RiskEstimationTable());
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
                    title: Text("Risk Procedure", style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.save,
                            size: 25.0,
                            color: Color(0xFF50AFC0),
                          ),
                          onPressed: () {
                            print("this is save Button");
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 25.0,
                            color: Color(0xFF50AFC0),
                          ),
                          onPressed: () {
                            print("this is delete Button");
                          },
                        ),
                      ],
                    ),
                  );
                },
                body: Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
                  child: ListBody(
                    children: _buildExpansionPanelItemList()
                  ),
                ),
                isExpanded: _isExpanded,
                canTapOnHeader: true,
              ),
            ],
            expansionCallback: (panelIndex, isExpanded) {
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