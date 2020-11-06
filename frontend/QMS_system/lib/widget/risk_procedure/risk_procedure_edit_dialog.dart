import 'package:QMS_system/bloc/bloc_provider.dart';
import 'package:QMS_system/bloc/risk_procedure_bloc.dart';
import 'package:QMS_system/constant/constants.dart';
import 'package:QMS_system/model/risk_procedure.dart';
import 'package:QMS_system/widget/risk_procedure/risk_estimation_table.dart';
import 'package:flutter/material.dart';

class RiskProcedureEditDialog extends StatefulWidget {

  final RiskProcedure _riskProcedure;

  final Function(Map<String, dynamic>) _callback;

  const RiskProcedureEditDialog(this._riskProcedure, this._callback);

  @override
  RiskProcedureEditDialogState createState() => new RiskProcedureEditDialogState();
}

class RiskProcedureEditDialogState extends State<RiskProcedureEditDialog> {

  final RiskProcedureBloc _riskProcedureBloc = RiskProcedureBloc();


  @override
  void initState() {
    super.initState();
    _riskProcedureBloc.initRiskProcedure(widget._riskProcedure);
  }

  @override
  void dispose() {
    super.dispose();
    _riskProcedureBloc.dispose();
  }

  Widget _buildSubExpansionPanel(String riskProcedureId, String rpKey, var rpValue) {

    List<IconButton> listTitleButtons;

    List<Row> rowList = List();

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
            _riskProcedureBloc.addOneItemForRiskProcedure(riskProcedureId, rpKey);
            _riskProcedureBloc.addOneItemDescriptionForRiskProcedure(riskProcedureId, rpKey);
          },
        ),
        IconButton(icon: Icon(Icons.remove, size: 25.0, color: Color(0xFF50AFC0),),
          onPressed: () {
            _riskProcedureBloc.removeOneItemForRiskProcedure(riskProcedureId, rpKey);
            _riskProcedureBloc.removeOneItemDescriptionForRiskProcedure(riskProcedureId, rpKey);
          },
        ),
      ];

      for(int i = 0; i < rpValue.length; i ++) {
        RiskProcedureItem item = RiskProcedureItem.fromJson(rpValue[i]);
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
                        _riskProcedureBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey, "name", value, i);
                        _riskProcedureBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey + "Description", "name", value, i);
                      },
                      decoration: inputDecorationName
                  ),
                ),
                Expanded(
                  child: TextFormField(
                      onChanged: (String value) async {
                        _riskProcedureBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey, "level", value, i);
                      },
                      decoration: inputDecorationLevel
                  ),
                ),
              ],
            )
        );
      }
    } else {
      listTitleButtons = List();

      rowList.add(
        Row(
          children: <Widget>[
            Expanded(child: Text(Constants.map_risk_procedure_sub_title[rpKey].replaceFirst("Description", "") + " Name",style: TextStyle(fontWeight: FontWeight.w500, color: Colors.lightBlue))),
            Expanded(child: Text(Constants.map_risk_procedure_sub_title[rpKey],style: TextStyle(fontWeight: FontWeight.w500, color: Colors.lightBlue))),
          ],
        ),
      );

      for(int i = 0; i < rpValue.length; i ++) {
        RiskProcedureItemDescription itemDescription = RiskProcedureItemDescription.fromJson(rpValue[i]);
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
                        _riskProcedureBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey, "name", value, i);
                        _riskProcedureBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey.replaceFirst("Description", ""), "name", value, i);
                      },
                      decoration: inputDecorationName
                  ),
                ),
                Expanded(
                  child: TextFormField(
                      onChanged: (String value) async {
                        _riskProcedureBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey, "description", value, i);
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
    List<Widget> tiles = List();
    if(riskProcedure != null) {
      Map<String, dynamic> mapRiskProcedure = riskProcedure.toJson();
      mapRiskProcedure.forEach((key, value) {
        value = value ?? "";
        if (key.compareTo("riskProcedureId") != 0 && key.compareTo("isApprove") != 0 && key.compareTo("mapRiskEstimation") != 0) {

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
                _riskProcedureBloc.updateHarmForRiskProcedure(value);
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

    tiles.add(RiskEstimationTable(riskProcedure, callback, true));

    return ListBody(
      children: tiles,
    );
  }

  callback(Map<String, dynamic> selectedValue) {
    print("this is risk_estimation_edit_dialog selectedValue " + selectedValue.toString());
    String riskLevel = selectedValue["riskLevel"];
    String probabilityId = selectedValue["probabilityId"];
    String severityId = selectedValue["severityId"];
    _riskProcedureBloc.updateRiskEstimation(severityId, probabilityId, riskLevel);
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Edit Risk Procedure'),
        actions: [
          new FlatButton(
            onPressed: () {
              _riskProcedureBloc.saveRiskProcedure();
              widget._callback({"" : ""});
              Navigator.of(context).pop();
            },
            child: new Text('SAVE'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: BlocProvider<RiskProcedureBloc>(
          bloc: _riskProcedureBloc,
          child: StreamBuilder(
            stream: _riskProcedureBloc.riskProcedureStream,
            builder: (context, snapshot) {
              Map<String,dynamic> mapRiskProcedure = snapshot.data;
              if (mapRiskProcedure == null) {
                return SizedBox.shrink();
              } else {
                return _buildRiskProcedureEditDialog(RiskProcedure.fromJson(mapRiskProcedure));
              }
            }
          ),
        ),
      ),
    );
  }
}