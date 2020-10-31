import 'package:QMS_system/constant/constants.dart';
import 'package:QMS_system/model/risk_procedure.dart';
import 'package:QMS_system/widget/risk_procedure/risk_estimation_table.dart';
import 'package:flutter/material.dart';

class RiskProcedureEditDialog extends StatefulWidget {

  final RiskProcedure _riskProcedure;

  const RiskProcedureEditDialog(this._riskProcedure);

  @override
  RiskProcedureEditDialogState createState() => new RiskProcedureEditDialogState();
}

class RiskProcedureEditDialogState extends State<RiskProcedureEditDialog> {

  Widget _buildSubExpansionPanel(String riskProcedureId, String rpKey, var rpValue) {

    List<IconButton> listTitleButtons;

    List<Row> rowList = [];

    if (rpKey.compareTo("severity") == 0 || rpKey.compareTo("probability") == 0) {

      rowList.add(
        Row(
          children: <Widget>[
            Expanded(child: Text(Constants.map_risk_procedure_sub_title[rpKey] + " Name",style: TextStyle(fontWeight: FontWeight.w500, color: Colors.lightBlue))),
            Expanded(child: Text(Constants.map_risk_procedure_sub_title[rpKey] + " Level",style: TextStyle(fontWeight: FontWeight.w500, color: Colors.lightBlue))),
          ],
        ),
      );

      listTitleButtons = [
        IconButton(icon: Icon(Icons.add, size: 25.0, color: Color(0xFF50AFC0),),
          onPressed: () {
            // _rpListBloc.addOneItemForRiskProcedure(riskProcedureId, rpKey);
            // _rpListBloc.addOneItemDescriptionForRiskProcedure(riskProcedureId, rpKey);
          },
        ),
        IconButton(icon: Icon(Icons.remove, size: 25.0, color: Color(0xFF50AFC0),),
          onPressed: () {
            // _rpListBloc.removeOneItemForRiskProcedure(riskProcedureId, rpKey);
            // _rpListBloc.removeOneItemDescriptionForRiskProcedure(riskProcedureId, rpKey);
          },
        ),
      ];

      for(int i = 0; i < rpValue.length; i ++) {
        RiskProcedureItem item = rpValue[i];
        String name = item.name ?? "";
        String level = item.level ?? "";

        InputDecoration inputDecorationName;
        InputDecoration inputDecorationLevel;
        if (name.length > 0) {
          inputDecorationName = InputDecoration(
              hintText: name
          );
        } else {
          inputDecorationName = InputDecoration(
              hintText: "Enter a " + Constants.map_risk_procedure_sub_title[rpKey] + " name"
          );
        }

        if (level.length > 0) {
          inputDecorationLevel = InputDecoration(
              hintText: level
          );
        } else {
          inputDecorationLevel = InputDecoration(
              hintText: "Enter a " + Constants.map_risk_procedure_sub_title[rpKey] + " level"
          );
        }

        rowList.add(
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                      onChanged: (String value) async {
                        // _rpListBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey, "name", value, i);
                        // _rpListBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey + "Description", "name", value, i);
                      },
                      decoration: inputDecorationName
                  ),
                ),
                Expanded(
                  child: TextFormField(
                      onChanged: (String value) async {
                        // _rpListBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey, "level", value, i);
                      },
                      decoration: inputDecorationLevel
                  ),
                ),
              ],
            )
        );
      }
    } else {
      listTitleButtons = [];

      rowList.add(
        Row(
          children: <Widget>[
            Expanded(child: Text(Constants.map_risk_procedure_sub_title[rpKey].replaceFirst("Description", "") + " Name",style: TextStyle(fontWeight: FontWeight.w500, color: Colors.lightBlue))),
            Expanded(child: Text(Constants.map_risk_procedure_sub_title[rpKey],style: TextStyle(fontWeight: FontWeight.w500, color: Colors.lightBlue))),
          ],
        ),
      );

      for(int i = 0; i < rpValue.length; i ++) {
        RiskProcedureItemDescription itemDescription = rpValue[i];
        String name = itemDescription.name ?? "";
        String description = itemDescription.description ?? "";

        InputDecoration inputDecorationName;
        InputDecoration inputDecorationDescription;
        if (name.length > 0) {
          inputDecorationName = InputDecoration(
              hintText: name
          );
        } else {
          inputDecorationName = InputDecoration(
              hintText: "Enter a " + Constants.map_risk_procedure_sub_title[rpKey].replaceFirst("Description", "") + " Name"
          );
        }

        if (description.length > 0) {
          inputDecorationDescription = InputDecoration(
              hintText: description
          );
        } else {
          inputDecorationDescription = InputDecoration(
              hintText: "Enter a " + Constants.map_risk_procedure_sub_title[rpKey]
          );
        }

        rowList.add(
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                      onChanged: (String value) async {
                        // _rpListBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey, "name", value, i);
                        // _rpListBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey.replaceFirst("Description", ""), "name", value, i);
                      },
                      decoration: inputDecorationName
                  ),
                ),
                Expanded(
                  child: TextFormField(
                      onChanged: (String value) async {
                        // _rpListBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey, "description", value, i);
                      },
                      decoration: inputDecorationDescription

                  ),
                ),
              ],
            )
        );
      }
    }

    return ExpansionPanelList(
      expansionCallback: (int panelIndex, bool isExpanded) {},
      children: [
        ExpansionPanel(
          headerBuilder: (context, isExpandEd) {
            return ListTile(
              title:Text(Constants.map_risk_procedure_sub_title[rpKey], style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: listTitleButtons,
              ),
            );
          },
          body: Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
            child: ListBody(
              children: rowList,
            ),
          ),
          isExpanded: true,

        )
      ],
    );
  }

  Widget _buildRiskProcedureEditDialog(RiskProcedure riskProcedure) {
    List<Widget> tiles = [];
    if(riskProcedure != null) {
      Map<String, dynamic> mapRiskProcedure = riskProcedure.toJson();
      mapRiskProcedure.forEach((key, value) {
        value = value ?? "";
        if (key.compareTo("riskProcedureId") != 0 && key.compareTo("isApprove") != 0) {

          Widget itemWidget;

          if (key.compareTo("harm") != 0) {
            itemWidget = _buildSubExpansionPanel(riskProcedure.riskProcedureId, key, value);
          } else {
            tiles.add(
                Container(
                  padding: EdgeInsets.all(10),
                  child:  Text(Constants.map_risk_procedure_sub_title[key.toString()], style: TextStyle(fontWeight: FontWeight.bold)),
                )
            );

            itemWidget = new TextFormField(
              onChanged: (String value) async {
                // _rpListBloc.updateHarmForRiskProcedure(riskProcedure.riskProcedureId, value);
              },
              decoration: new InputDecoration(
                labelText: value.toString(),
              ),
            );
          }

          tiles.add(
            Card(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: itemWidget,
              ),
            ),
          );
        }
      });
    }

    tiles.add(RiskEstimationTable(riskProcedure));

    return ListBody(
      children: tiles,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Edit Risk Procedure'),
        actions: [
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: new Text('SAVE'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: _buildRiskProcedureEditDialog(widget._riskProcedure),
      ),
    );
  }
}