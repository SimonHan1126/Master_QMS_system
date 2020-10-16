import 'package:QMS_system/bloc/bloc_provider.dart';
import 'package:QMS_system/bloc/fmea_table_list_bloc.dart';
import 'package:QMS_system/constant/strings.dart';
import 'package:QMS_system/model/dropdown_severity_item.dart';
import 'package:QMS_system/model/fmea_table.dart';
import 'package:QMS_system/model/risk_procedure.dart';
import 'package:QMS_system/util/risk_procedure_data.dart';
import 'package:QMS_system/util/snackbar_util.dart';
import 'package:QMS_system/widget/common/drop_down_menu.dart';
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
    "hazardClass"                 : "Hazard Class",
    "sourceId"                    : "Source Id",
    "foreseeableSequenceOfEvents" : "Foreseeable Sequence of Events",
    "hazardousSituation"          : "Hazardous Situation",
    "harm"                        : "Harm",
    "severityOfHarm"              : "Severity of Harm",
    "probability"                 : "Probability",
    "riskPriority"                : "Risk Priority",
    "recommendingAction"          : "Recommending Action",
    "typeOfAction"                : "Type of Action",
    "actionDone"                  : "Action Done",
    "severityOfHarm2"             : "Severity Of Harm 2",
    "probability2"                : "Probability 2",
    "residualRisk"                : "Residual Risk",
  };

  List<Item> _expansionPanelContentList = [];

  List<DropdownSeverityItem> _dropdownSeverityItemList = [];

  Map<String, RiskProcedure> _mapRiskProcedures = {};

  @override
  void initState() {
    super.initState();
    _ftListBloc.getAllFMEATable();
    _initRiskProcedures();
  }


  @override
  void dispose() {
    super.dispose();
    _ftListBloc.dispose();
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

  _updateUI(BuildContext context, FMEATable fmeaTable) {
    setState(() {
      int length = _expansionPanelContentList.length;
      _expansionPanelContentList.add(Item(fmeaTable: fmeaTable, index: length));
    });

    SnackBarUtil.showSnackBar(context, "save FMEA table successfully");
  }

  _saveEmptyFMEATable(BuildContext context) async {
    FMEATable fmeaTable = FMEATable(
      hazardId: DateTime.now().millisecondsSinceEpoch.toString(),
      hazardClass: "",
      sourceId: "",
      foreseeableSequenceOfEvents: "",
      hazardousSituation: "",
      harm: "",
      severityOfHarm: "",
      probability: "",
      riskPriority: "",
      recommendingAction: "",
      typeOfAction: "",
      actionDone: "",
      severityOfHarm2: "",
      probability2: "",
      residualRisk: "",
    );
    _ftListBloc.saveFMEATable(fmeaTable);
    _updateUI(context, fmeaTable);
  }

  _saveInputtedFMEATable(BuildContext context,FMEATable fmeaTable) async {

    fmeaTable.hazardClass                 = _textFieldContentMap['hazardClass' + fmeaTable.hazardId];
    fmeaTable.sourceId                    = _textFieldContentMap['sourceId' + fmeaTable.hazardId];
    fmeaTable.foreseeableSequenceOfEvents = _textFieldContentMap['foreseeableSequenceOfEvents' + fmeaTable.hazardId];
    fmeaTable.hazardousSituation          = _textFieldContentMap['hazardousSituation' + fmeaTable.hazardId];
    fmeaTable.harm                        = _textFieldContentMap['harm' + fmeaTable.hazardId];
    fmeaTable.severityOfHarm              = _textFieldContentMap['severityOfHarm' + fmeaTable.hazardId];
    fmeaTable.probability                 = _textFieldContentMap['probability' + fmeaTable.hazardId];
    fmeaTable.riskPriority                = _textFieldContentMap['riskPriority' + fmeaTable.hazardId];
    fmeaTable.recommendingAction          = _textFieldContentMap['recommendingAction' + fmeaTable.hazardId];
    fmeaTable.typeOfAction                = _textFieldContentMap['typeOfAction' + fmeaTable.hazardId];
    fmeaTable.actionDone                  = _textFieldContentMap['actionDone' + fmeaTable.hazardId];
    fmeaTable.severityOfHarm2             = _textFieldContentMap['severityOfHarm2' + fmeaTable.hazardId];
    fmeaTable.probability2                = _textFieldContentMap['probability2' + fmeaTable.hazardId];
    fmeaTable.residualRisk                = _textFieldContentMap['residualRisk' + fmeaTable.hazardId];

    // Map<String, dynamic> mapFMEATable = fmeaTable.toJson();

    bool isAnyFieldTEmpty = false;
    String emptyKey = "";
    // mapFMEATable.forEach((key, value) {
    //   String sValue = value;
    //   sValue??="";
    //   if (sValue.length <= 0 && key != "hazardId" && key != "acceptability") {
    //     emptyKey = _subTitleMap[key];
    //     isAnyFieldTEmpty = true;
    //   }
    // });

    if(!isAnyFieldTEmpty) {
      _ftListBloc.saveFMEATable(fmeaTable);
      _updateUI(context, fmeaTable);
    } else {
      SnackBarUtil.showSnackBar(context, emptyKey + " cannot be empty!!!");
    }
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

  severityOfHarmCallback(String selectedValue) {
    print("this is fmea_table_expansion_panel severityOfHarmCallback selectedValue " + selectedValue);
  }

  Widget _buildSeverityOfHarm() {
    Map<String, MaterialColor> contentMap = {};
    print("this is _buildSeverityOfHarm _mapRiskProcedures " + _mapRiskProcedures.toString());
    _mapRiskProcedures.forEach((key, value) {
      RiskProcedure riskProcedure = value;
      List<RiskProcedureItem> rpSeverityList = riskProcedure.severity;
      List<RiskProcedureItemDescription> rpSeverityDescriptionList = riskProcedure.severityDescription;
      for (int i = 0; i < rpSeverityList.length; i++) {
        RiskProcedureItem severityItem = rpSeverityList[i];
        RiskProcedureItemDescription severityDescriptionItem = rpSeverityDescriptionList[i];
        contentMap[severityItem.name] = Colors.blueGrey;
        _dropdownSeverityItemList.add(DropdownSeverityItem(
          riskProcedureId: riskProcedure.riskProcedureId,
          index: i,
          severityName: severityItem.name,
          severityLevel: severityItem.level,
          severityDescription: severityDescriptionItem.description
        ));
      }
    });

    return Column(
      children: [DropDownMenu(Strings.dropdown_severity_tag_fmea_table, _dropdownSeverityItemList,contentMap, severityOfHarmCallback)],
    );
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
                child:  Text(_subTitleMap[key], style: TextStyle(fontWeight: FontWeight.bold)),
              )
          );
          Widget widget;
          if (key.compareTo("severityOfHarm") == 0) {
            widget = _buildSeverityOfHarm();
          } else {
            widget = Card(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: new TextFormField(
                  controller: _textEditingControllerMap[key],
                  onChanged: (String value) async {
                    _textFieldContentMap[key + fmeaTable.hazardId] = value;
                  },
                  decoration: new InputDecoration(
                    hintText: "Enter " + _subTitleMap[key],
                  ),
                ),
              ),
            );
          }

          tiles.add(widget);
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
                      _saveInputtedFMEATable(context, element);
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

  void _initRiskProcedures() {
    List<RiskProcedure> list = RiskProcedureData.riskProcedureList;
    print("this is _initRiskProcedures list " + list.toString());
    if (list!=null && list.length > 0) {
      list.asMap().forEach((key, value) {
        print("this is _initRiskProcedures key " + key.toString() + " harm " + value.harm);
        RiskProcedure rp = list.elementAt(key);
        _mapRiskProcedures[rp.riskProcedureId] = rp;
      });
    }
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
          ),
          FlatButton(
            onPressed: () {
              _saveEmptyFMEATable(context);
            },
            child: Text("Add",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF50AFC0))),
          )
        ],
      ),
    );
  }
}

class Item {
  Item({this.fmeaTable, this.index, this.isExpanded = false,});

  FMEATable fmeaTable;
  int index;
  bool isExpanded;
}



