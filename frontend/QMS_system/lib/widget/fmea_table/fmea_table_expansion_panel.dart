import 'package:QMS_system/bloc/bloc_provider.dart';
import 'package:QMS_system/bloc/fmea_table_list_bloc.dart';
import 'package:QMS_system/model/fmea_table.dart';
import 'package:QMS_system/util/snackbar_util.dart';
import 'package:flutter/material.dart';

class FMEATableExpansionPanelWidget extends StatefulWidget {
  FMEATableExpansionPanelWidgetState createState() =>  FMEATableExpansionPanelWidgetState();
}

class FMEATableExpansionPanelWidgetState extends State<FMEATableExpansionPanelWidget> {

  final _ftListBloc = FMEATableListBloc();

  int _pressedPanelIndex = -1;
  bool _pressedPanelIsExpanded = false;

  Map<String, TextEditingController>  _textEditingControllerMap = {};

  Map<String, String> _textFieldContentMap = {};

  Map<String, String> _subTitleMap = {
    "hazardClass": "Hazard Class",
    "sourceId": "Source Id",
    "foreseeableSequenceOfEvents": "Foreseeable Sequence of Events",
    "hazardousSituation": "Hazardous Situation",
    "harm": "Harm",
    "severityOfHarm": "Severity of Harm",
    "probability": "Probability",
    "riskPriority": "Risk Priority",
    "recommendingAction": "Recommending Action",
    "typeOfAction": "Type of Action",
    "actionDone": "Action Done",
    "severityOfHarm2": "Severity Of Harm 2",
    "probability2": "Probability 2",
    "residualRisk": "Residual Risk",
  };

  List<Item> _expansionPanelContentList = [];

  @override
  void initState() {
    super.initState();
    _ftListBloc.getAllFMEATable();
  }


  @override
  void dispose() {
    super.dispose();
  }

  void _initExpansionPanelContentList(List<FMEATable> rpList) {
    _expansionPanelContentList = [];
    rpList.asMap().forEach((index, element) {
      Item item = Item(fmeaTable: element, index: index);
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

  _updateUI(FMEATable fmeaTable) {
    setState(() {
      int length = _expansionPanelContentList.length;
      _expansionPanelContentList.add(Item(fmeaTable: fmeaTable, index: length));
    });

    SnackBarUtil.showSnackBar(context, "save FMEA table successfully");
  }

  _saveInputtedRiskProcedure(BuildContext context, FMEATable fmeaTable) async {

    // riskProcedure.harm = _textFieldContentMap["harm" + riskProcedure.riskProcedureId];
    // riskProcedure.severity = _textFieldContentMap["severity" + riskProcedure.riskProcedureId];
    // riskProcedure.severityDescription = _textFieldContentMap["severityDescription" + riskProcedure.riskProcedureId];
    // riskProcedure.probability = _textFieldContentMap["probability" + riskProcedure.riskProcedureId];
    // riskProcedure.probabilityDescription =  _textFieldContentMap["probabilityDescription" + riskProcedure.riskProcedureId];
    // riskProcedure.isApprove = false;

    _ftListBloc.saveFMEATable(fmeaTable);
    _updateUI(fmeaTable);
  }

  _removeRisProcedure(BuildContext context, FMEATable fmeaTable) async {

    _ftListBloc.deleteFMEATable(fmeaTable.hazardId);
    int index = -1;
    _expansionPanelContentList.asMap().forEach((listIndex, element) {
      if(fmeaTable.hazardId.compareTo(element.fmeaTable.hazardId) == 0) {
        index = listIndex;
      }
    });
    setState(() {
      if (index >= 0) {
        _expansionPanelContentList.removeAt(index);
      }
    });
    SnackBarUtil.showSnackBar(context, "remove Risk Procedure successfully");
  }

  Widget _buildExpansionPanelItemList(FMEATable fmeaTable) {
    List<Widget> tiles = [];
    if(fmeaTable != null) {
      Map<String, dynamic> mapRiskProcedure = fmeaTable.toJson();
      mapRiskProcedure.forEach((key, value) {
        value = value ?? "";
        if (key.compareTo("hazardId") != 0 && key.compareTo("acceptability") != 0) {
          _textEditingControllerMap[key] = TextEditingController();
          tiles.add(
              Container(
                padding: EdgeInsets.all(10),
                child:  Text(_subTitleMap[key.toString()], style: TextStyle(fontWeight: FontWeight.bold)),
              )
          );
          tiles.add(
            Card(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: new TextFormField(
                  controller: _textEditingControllerMap[key],
                  onChanged: (String value) async {
                    _textFieldContentMap[key + fmeaTable.hazardId] = value;
                  },
                  decoration: new InputDecoration(
                    labelText: value.toString(),
                  ),
                ),
              ),
            ),
          );
        }
      });
    }

    return ListBody(
      children: tiles,
    );
  }

  Widget _buildExpansionPanelList(List<FMEATable> ftList) {
    if (ftList == null || ftList.length <= 0) {
      return SizedBox.shrink();
    }

    _initExpansionPanelContentList(ftList);

    return ExpansionPanelList(
      expansionCallback: (int panelIndex, bool isExpanded) {
        setState(() {
          _pressedPanelIndex = panelIndex;
          _pressedPanelIsExpanded = isExpanded;
        });
      },
      children: _expansionPanelContentList.map<ExpansionPanel>((Item item) {
        final FMEATable element = item.fmeaTable;
        element.acceptability??=false;
        final isApproveText = element.acceptability ? "Approved" : "Unapproved";
        return ExpansionPanel(
          headerBuilder: (context, isExpandEd) {
            return ListTile(
              title: RichText(
                text: TextSpan(
                  text: "FMEA table " + element.hazardId,
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
                      _saveInputtedRiskProcedure(context, element);
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
          BlocProvider<FMEATableListBloc>(
            bloc: _ftListBloc,
            child: StreamBuilder(
              stream: _ftListBloc.fmeaTableListStream,
              builder: (context, snapshot) {
                List<FMEATable> ftList = snapshot.data;
                return _buildExpansionPanelList(ftList);
              },
            ),
          )
        ],
      ),
    );
  }
}

class Item {
  Item({
    this.fmeaTable,
    this.index,
    this.isExpanded = false,
  });

  FMEATable fmeaTable;
  int index;
  bool isExpanded;
}