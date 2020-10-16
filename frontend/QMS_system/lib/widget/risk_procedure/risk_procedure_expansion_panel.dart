import 'package:QMS_system/bloc/bloc_provider.dart';
import 'package:QMS_system/bloc/risk_procedure_list_bloc.dart';
import 'package:QMS_system/model/risk_procedure.dart';
import 'package:QMS_system/util/risk_procedure_data.dart';
import 'package:QMS_system/util/snackbar_util.dart';
import 'package:QMS_system/widget/risk_procedure/risk_estimation_table.dart';
import 'package:flutter/material.dart';

class RiskProcedureExpansionPanelWidget extends StatefulWidget {
  RiskProcedureExpansionPanelWidgetState createState() =>  RiskProcedureExpansionPanelWidgetState();
}

class RiskProcedureExpansionPanelWidgetState extends State<RiskProcedureExpansionPanelWidget> {
  final _rpListBloc = RiskProcedureListBloc();

  int _pressedPanelIndex = -1;
  bool _pressedPanelIsExpanded = false;

  Map<String, String> _subTitleMap = {
    "harm" : "Harm",
    "severity" : "Severity",
    "severityDescription" : "Severity Description",
    "probability" : "Probability",
    "probabilityDescription" :  "Probability Description"
  };

  List<Item> _expansionPanelContentList = [];

  @override
  void initState() {
    super.initState();
    _rpListBloc.getAllRiskProcedure();
  }


  @override
  void dispose() {
    super.dispose();
    _rpListBloc.dispose();
  }

  _updateUI(BuildContext context,RiskProcedure riskProcedure) {
    setState(() {
      int length = _expansionPanelContentList.length;
      _expansionPanelContentList.add(Item(riskProcedure: riskProcedure, index: length));
    });

    SnackBarUtil.showSnackBar(context, "save Risk Procedure successfully");
  }

  _updateInputtedRiskProcedure(BuildContext context, RiskProcedure riskProcedure) async {
    /*
      TO_DO
      1. check each is empty or not
      2. showSnackbar for empty field
     */
    _rpListBloc.saveRiskProcedure(riskProcedure);
    _updateUI(context, riskProcedure);
  }

  _saveEmptyRiskProcedure(BuildContext context) async {
    RiskProcedure riskProcedure = RiskProcedure(
        riskProcedureId: DateTime.now().millisecondsSinceEpoch.toString(),
        harm: "",
        severity: [RiskProcedureItem()],
        severityDescription: [RiskProcedureItemDescription()],
        probability: [RiskProcedureItem()],
        probabilityDescription: [RiskProcedureItemDescription()],
        isApprove: false);
    _rpListBloc.addRiskProcedure(riskProcedure);
    _updateUI(context,riskProcedure);
  }

  _removeRisProcedure(BuildContext context, RiskProcedure riskProcedure) async {
    _pressedPanelIndex = -1;
    int index = -1;
    _expansionPanelContentList.asMap().forEach((listIndex, element) {
      if(riskProcedure.riskProcedureId.compareTo(element.riskProcedure.riskProcedureId) == 0) {
        index = listIndex;
      }
    });
    setState(() {
      if (index >= 0) {
        _expansionPanelContentList.removeAt(index);
      }
    });
    _rpListBloc.deleteRiskProcedure(riskProcedure.riskProcedureId);
    SnackBarUtil.showSnackBar(context, "remove Risk Procedure successfully");
  }

  void _initExpansionPanelContentList(List<RiskProcedure> rpList) {
    _expansionPanelContentList = [];
    rpList.asMap().forEach((index, element) {
      Item item = Item(riskProcedure: element, index: index);
      if (_expansionPanelContentList.asMap().containsKey(index)) {
        _expansionPanelContentList[index] = item;
      } else {
        _expansionPanelContentList.add(item);
      }
    });
    if (_pressedPanelIndex >= 0) {
      _expansionPanelContentList[_pressedPanelIndex].isExpanded = !_pressedPanelIsExpanded;
    }
  }

  Widget _buildSubExpansionPanel(String riskProcedureId, String rpKey, var rpValue) {
    
    List<IconButton> listTitleButtons;

    List<Row> rowList = [];

    if (rpKey.compareTo("severity") == 0 || rpKey.compareTo("probability") == 0) {

      rowList.add(
        Row(
          children: <Widget>[
            Expanded(child: Text(_subTitleMap[rpKey] + " Name",style: TextStyle(fontWeight: FontWeight.w500, color: Colors.lightBlue))),
            Expanded(child: Text(_subTitleMap[rpKey] + " Level",style: TextStyle(fontWeight: FontWeight.w500, color: Colors.lightBlue))),
          ],
        ),
      );
      
      listTitleButtons = [
        IconButton(icon: Icon(Icons.add, size: 25.0, color: Color(0xFF50AFC0),),
          onPressed: () {
            _rpListBloc.addOneItemForRiskProcedure(riskProcedureId, rpKey);
            _rpListBloc.addOneItemDescriptionForRiskProcedure(riskProcedureId, rpKey);
          },
        ),
        IconButton(icon: Icon(Icons.remove, size: 25.0, color: Color(0xFF50AFC0),),
          onPressed: () {
            _rpListBloc.removeOneItemForRiskProcedure(riskProcedureId, rpKey);
            _rpListBloc.removeOneItemDescriptionForRiskProcedure(riskProcedureId, rpKey);
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
            hintText: "Enter a " + _subTitleMap[rpKey] + " name"
          );
        }

        if (level.length > 0) {
          inputDecorationLevel = InputDecoration(
              hintText: level
          );
        } else {
          inputDecorationLevel = InputDecoration(
              hintText: "Enter a " + _subTitleMap[rpKey] + " level"
          );
        }

        rowList.add(
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    onChanged: (String value) async {
                      _rpListBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey, "name", value, i);
                      _rpListBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey + "Description", "name", value, i);
                    },
                    decoration: inputDecorationName
                  ),
                ),
                Expanded(
                  child: TextFormField(
                      onChanged: (String value) async {
                        _rpListBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey, "level", value, i);
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
            Expanded(child: Text(_subTitleMap[rpKey].replaceFirst("Description", "") + " Name",style: TextStyle(fontWeight: FontWeight.w500, color: Colors.lightBlue))),
            Expanded(child: Text(_subTitleMap[rpKey],style: TextStyle(fontWeight: FontWeight.w500, color: Colors.lightBlue))),
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
              hintText: "Enter a " + _subTitleMap[rpKey].replaceFirst("Description", "") + " Name"
          );
        }

        if (description.length > 0) {
          inputDecorationDescription = InputDecoration(
              hintText: description
          );
        } else {
          inputDecorationDescription = InputDecoration(
              hintText: "Enter a " + _subTitleMap[rpKey]
          );
        }

        rowList.add(
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    onChanged: (String value) async {
                      _rpListBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey, "name", value, i);
                      _rpListBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey.replaceFirst("Description", ""), "name", value, i);
                    },
                    decoration: inputDecorationName
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    onChanged: (String value) async {
                      _rpListBloc.updateOneItemForRiskProcedure(riskProcedureId, rpKey, "description", value, i);
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
              title:Text(_subTitleMap[rpKey], style: TextStyle(fontWeight: FontWeight.bold)),
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
          isExpanded: true
        )
      ],
    );
  }

  Widget _buildExpansionPanelItemList(RiskProcedure riskProcedure) {
    List<Widget> tiles = [];
    if(riskProcedure != null) {
      Map<String, dynamic> mapRiskProcedure = riskProcedure.toJson();
      mapRiskProcedure.forEach((key, value) {
        value = value ?? "";
        if (key.compareTo("riskProcedureId") != 0 && key.compareTo("isApprove") != 0) {

          Widget widget;

          if (key.compareTo("harm") != 0) {
            widget = _buildSubExpansionPanel(riskProcedure.riskProcedureId, key, value);
          } else {
            tiles.add(
                Container(
                  padding: EdgeInsets.all(10),
                  child:  Text(_subTitleMap[key.toString()], style: TextStyle(fontWeight: FontWeight.bold)),
                )
            );

            widget = new TextFormField(
              onChanged: (String value) async {
                _rpListBloc.updateHarmForRiskProcedure(riskProcedure.riskProcedureId, value);
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
                child: widget,
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

  Widget _buildExpansionPanelList(List<RiskProcedure> rpList) {
    if (rpList == null || rpList.length <= 0) {
      return SizedBox.shrink();
    }

    _initExpansionPanelContentList(rpList);

    return ExpansionPanelList(
      expansionCallback: (int panelIndex, bool isExpanded) {
        setState(() {
          _pressedPanelIndex = panelIndex;
          _pressedPanelIsExpanded = isExpanded;
        });
      },
      children: _expansionPanelContentList.map<ExpansionPanel>((Item item) {
        final RiskProcedure element = item.riskProcedure;
        element.isApprove??=false;
        final isApproveText = element.isApprove ? "Approved" : "Unapproved";
        return ExpansionPanel(
          headerBuilder: (context, isExpandEd) {
            return ListTile(
              title: RichText(
                text: TextSpan(
                  text: "Risk Procedure " + element.riskProcedureId ,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: " (" + isApproveText + ")",
                        style: TextStyle(color: Colors.red)
                    ),
                  ],
                ),
              ),
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
                      _updateInputtedRiskProcedure(context, element);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      size: 25.0,
                      color: Color(0xFF50AFC0),
                    ),
                    onPressed: () {
                      _removeRisProcedure(context, element);
                    },
                  ),
                ],
              ),
            );
          },
          body: Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
              child: _buildExpansionPanelItemList(element)),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocProvider<RiskProcedureListBloc>(
            bloc: _rpListBloc,
            child: StreamBuilder(
                stream: _rpListBloc.riskProcedureListStream,
                builder: (context, snapshot) {
                  List<RiskProcedure> rpList = snapshot.data;
                  RiskProcedureData.setRiskProcedureList(rpList);
                  return _buildExpansionPanelList(rpList);
                }
            ),
          ),
          FlatButton(
            onPressed: () {
              _saveEmptyRiskProcedure(context);
            },
            child: Text(
                "Add", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF50AFC0))
            ),
          )
        ],
      ),
    );
  }
}

class Item {
  Item({
    this.riskProcedure,
    this.index,
    this.isExpanded = false,
  });

  RiskProcedure riskProcedure;
  int index;
  bool isExpanded;
}