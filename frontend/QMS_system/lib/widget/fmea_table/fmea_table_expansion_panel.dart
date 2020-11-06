import 'package:QMS_system/bloc/bloc_provider.dart';
import 'package:QMS_system/bloc/fmea_table_list_bloc.dart';
import 'package:QMS_system/constant/constants.dart';
import 'package:QMS_system/model/dropdown_severity_item.dart';
import 'package:QMS_system/model/dropdwon_probability_item.dart';
import 'package:QMS_system/model/fmea_table.dart';
import 'package:QMS_system/model/risk_procedure.dart';
import 'package:QMS_system/model/user.dart';
import 'package:QMS_system/util/base_util.dart';
import 'package:QMS_system/util/risk_procedure_data.dart';
import 'package:QMS_system/util/snackbar_util.dart';
import 'package:QMS_system/widget/common/drop_down_menu.dart';
import 'package:flutter/material.dart';

class FMEATableExpansionPanelWidget extends StatefulWidget {

  final User _user;

  FMEATableExpansionPanelWidget(this._user);

  FMEATableExpansionPanelWidgetState createState() =>  FMEATableExpansionPanelWidgetState();
}

class FMEATableExpansionPanelWidgetState extends State<FMEATableExpansionPanelWidget> {

  final _ftListBloc = FMEATableListBloc();

  int _pressedPanelIndex = -1;
  bool _pressedPanelIsExpanded = false;

  Map<String, TextEditingController>  _textEditingControllerMap = {};

  Map<String, String> _textFieldContentMap = {};

  List<Item> _expansionPanelContentList = List();

  //key: riskProcedureId
  Map<String, RiskProcedure> _mapRiskProcedures = {};

  //key: fmeaKey + fmeaTableId, value: severity level
  Map<String, String> _severityLevelMap = {};

  //key: fmeaKey + fmeaTableId, value: probability level
  Map<String, String> _probabilityLevelMap = {};

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
    _expansionPanelContentList = List();
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
      hazardId: BaseUtil.getCurrentTimestamp(),
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

  _removeFMEATable(BuildContext context, FMEATable fmeaTable) async {

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
    SnackBarUtil.showSnackBar(context, "remove FMEA Table successfully");
  }

  severityOfHarmCallback(Map<String, dynamic> selectedValue) {
    String key = selectedValue["fmeaTableKey"] + selectedValue["fmeaTableId"];
    _textFieldContentMap[key] = selectedValue["severityName"];
    setState(() {
      _severityLevelMap[key] = selectedValue["severityLevel"];
    });
  }

  Widget _buildSeverityOfHarm(FMEATable fmeaTable, String fmeaTableKey) {
    Map<String, MaterialColor> contentMap = {};
    Map<String, dynamic> fmeaTableMap = fmeaTable.toJson();
    String severityName = fmeaTableMap[fmeaTableKey];
    String severityLevel;
    List<DropdownSeverityItem> dropdownSeverityItemList = List();
    _mapRiskProcedures.forEach((key, value) {
      RiskProcedure riskProcedure = value;
      List<RiskProcedureItem> rpSeverityList = riskProcedure.severity;
      for (int i = 0; i < rpSeverityList.length; i++) {
        RiskProcedureItem severityItem = rpSeverityList[i];
        contentMap[severityItem.name] = Colors.blueGrey;
        if (severityItem.name.compareTo(severityItem.name) == 0) {
          severityLevel = severityItem.level;
        }
        dropdownSeverityItemList.add(DropdownSeverityItem(
          fmeaTableId: fmeaTable.hazardId,
          riskProcedureId: riskProcedure.riskProcedureId,
          fmeaTableKey: fmeaTableKey,
          index: i,
          severityName: severityItem.name,
          severityLevel: severityItem.level
        ));
      }
    });

    severityName = severityName??dropdownSeverityItemList[0].severityName;
    severityLevel = severityLevel??dropdownSeverityItemList[0].severityLevel;
    _severityLevelMap[fmeaTableKey + fmeaTable.hazardId] = severityLevel;
    return Column(
      children: [DropDownMenu(
          Constants.dropdown_severity_tag_fmea_table,
          fmeaTableKey,
          severityName,
          Colors.red,
          dropdownSeverityItemList,
          contentMap,
          severityOfHarmCallback)
      ],
    );
  }

  probabilityCallback(Map<String, dynamic> selectedValue) {
    _textFieldContentMap[selectedValue["fmeaTableKey"] + selectedValue["fmeaTableId"]] = selectedValue["probabilityName"];
    setState(() {
      _probabilityLevelMap[selectedValue["fmeaTableKey"] + selectedValue["fmeaTableId"]] = selectedValue["probabilityLevel"];
    });
  }

  Widget _buildProbability(FMEATable fmeaTable, String fmeaTableKey) {
    Map<String, MaterialColor> contentMap = {};
    Map<String, dynamic> fmeaTableMap = fmeaTable.toJson();
    String probabilityName = fmeaTableMap[fmeaTableKey];
    String probabilityLevel;
    List<DropdownProbabilityItem> dropdownProbabilityItemList = List();
    _mapRiskProcedures.forEach((key, value) {
      RiskProcedure riskProcedure = value;
      List<RiskProcedureItem> rpProbabilityList = riskProcedure.probability;
      for (int i = 0; i < rpProbabilityList.length; i++) {
        RiskProcedureItem probabilityItem = rpProbabilityList[i];
        contentMap[probabilityItem.name] = Colors.blueGrey;
        if (probabilityItem.name.compareTo(probabilityName) == 0) {
          probabilityLevel = probabilityItem.level;
        }
        dropdownProbabilityItemList.add(DropdownProbabilityItem(
          fmeaTableId: fmeaTable.hazardId,
          riskProcedureId: riskProcedure.riskProcedureId,
          fmeaTableKey: fmeaTableKey,
          index: i,
          probabilityName: probabilityItem.name,
          probabilityLevel: probabilityItem.level,
        ));
      }
    });

    probabilityName = probabilityName??dropdownProbabilityItemList[0].probabilityName;
    probabilityLevel = probabilityLevel??dropdownProbabilityItemList[0].probabilityLevel;
    _probabilityLevelMap[fmeaTableKey + fmeaTable.hazardId] = probabilityLevel;
   
    return Column(
      children: [
        DropDownMenu(
            Constants.dropdown_probability_tag_fmea_table,
            fmeaTableKey,
            probabilityName,
            Colors.red,
            dropdownProbabilityItemList,
            contentMap,
            probabilityCallback)
      ],
    );
  }

  typeOfActionCallback(Map<String, dynamic> selectedValue) {
    _textFieldContentMap[selectedValue["fmeaTableKey"] + selectedValue["fmeaTableId"]] = selectedValue["typeOfActionValue"];
  }

  Widget _buildTypeOfAction(FMEATable fmeaTable, String key) {
    String typeOfAction = fmeaTable.typeOfAction??Constants.fmea_type_of_action_list[0];
    MaterialColor defaultColor = Constants.map_fmea_type_of_action_color[typeOfAction];

    List<Map<String, dynamic>> typeOfActionList = List();
    for (int i = 0; i < Constants.fmea_type_of_action_list.length; i++) {
      Map<String, dynamic> itemMap = {
        "fmeaTableId" : fmeaTable.hazardId,
        "typeOfActionValue" : Constants.fmea_type_of_action_list[i],
        "fmeaTableKey" : key
      };
      typeOfActionList.add(itemMap);
    }
    typeOfAction = typeOfAction??typeOfActionList[0];
    _textFieldContentMap[key + fmeaTable.hazardId] = typeOfAction;
    return Column(
      children: [
        DropDownMenu(
          Constants.dropdown_fmea_type_of_action,
          fmeaTable.hazardId,
          typeOfAction,
          defaultColor,
          typeOfActionList,
          Constants.map_fmea_type_of_action_color,
          typeOfActionCallback)
      ],
    );
  }

  Widget _buildExpansionPanelItemList(FMEATable fmeaTable) {
    _severityLevelMap["severityOfHarm" + fmeaTable.hazardId] = _severityLevelMap["severityOfHarm" + fmeaTable.hazardId]??"1";
    _probabilityLevelMap["probability" + fmeaTable.hazardId] = _probabilityLevelMap["probability" + fmeaTable.hazardId]??"1";
    _severityLevelMap["severityOfHarm2" + fmeaTable.hazardId] = _severityLevelMap["severityOfHarm2" + fmeaTable.hazardId]??"1";
    _probabilityLevelMap["probability2" + fmeaTable.hazardId] = _probabilityLevelMap["probability2" + fmeaTable.hazardId]??"1";
    String severityLevel = _severityLevelMap["severityOfHarm" + fmeaTable.hazardId].length > 0 ? _severityLevelMap["severityOfHarm" + fmeaTable.hazardId] : "1";
    String probabilityLevel = _probabilityLevelMap["probability" + fmeaTable.hazardId].length > 0 ? _probabilityLevelMap["probability" + fmeaTable.hazardId] : "1";
    String severity2Level = _severityLevelMap["severityOfHarm2" + fmeaTable.hazardId].length > 0 ? _severityLevelMap["severityOfHarm2" + fmeaTable.hazardId] : "1";
    String probability2Level = _probabilityLevelMap["probability2" + fmeaTable.hazardId].length > 0 ? _probabilityLevelMap["probability2" + fmeaTable.hazardId] : "1";
    List<Widget> tiles = List();
    if(fmeaTable != null) {
      Map<String, dynamic> mapFMEATable = fmeaTable.toJson();
      mapFMEATable.forEach((key, value) {
        value = value ?? "";
        if (key.compareTo("hazardId") != 0 && key.compareTo("acceptability") != 0) {
          _textEditingControllerMap[key] = TextEditingController();
          tiles.add(
              Container(
                padding: EdgeInsets.all(10),
                child:  Text(Constants.map_fmea_table_sub_title[key], style: TextStyle(fontWeight: FontWeight.bold)),
              )
          );
          Widget expansionItemWidget;
          if (key.compareTo("severityOfHarm") == 0 || key.compareTo("severityOfHarm2") == 0 ) {
            expansionItemWidget = _buildSeverityOfHarm(fmeaTable, key);
          } else if (key.compareTo("probability") == 0 || key.compareTo("probability2") == 0) {
            expansionItemWidget = _buildProbability(fmeaTable, key);
          } else if (key.compareTo("typeOfAction") == 0) {
            expansionItemWidget = _buildTypeOfAction(fmeaTable, key);
          } else {
            Widget childWidget;
            if (key.compareTo("riskPriority") == 0) {
              int riskPriority = int.parse(severityLevel) * int.parse(probabilityLevel);
              childWidget = Text(riskPriority.toString());
            } else if (key.compareTo("residualRisk") == 0) {
              int residualRisk = int.parse(severity2Level) * int.parse(probability2Level);
              childWidget = Text(residualRisk.toString());
            } else {
              childWidget = TextFormField(
                controller: _textEditingControllerMap[key],
                onChanged: (String value) async {
                  _textFieldContentMap[key + fmeaTable.hazardId] = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter " + Constants.map_fmea_table_sub_title[key],
                ),
              );
            }

            expansionItemWidget = Card(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: childWidget
              ),
            );
          }

          tiles.add(expansionItemWidget);
        }
      });
    }

    return ListBody(
      children: tiles,
    );
  }

  List<IconButton> _buildItemExpansionPanelButtons(BuildContext context, FMEATable fmeaTable) {
    List<IconButton> list = List();
    list.add(IconButton(icon: Icon(Icons.save, size: 25.0, color: Color(0xFF50AFC0),), onPressed: () {_saveInputtedFMEATable(context, fmeaTable);},));
    list.add(IconButton(icon: Icon(Icons.delete, size: 25.0, color: Color(0xFF50AFC0),), onPressed: () {_removeFMEATable(context, fmeaTable);},));
    if (widget._user.userPermission == Constants.user_permission_qa) {
      list.add(IconButton(icon: Icon(Icons.done_outline_rounded, size: 25.0, color: Color(0xFF50AFC0),), onPressed: () {
        print("approve");
      },));
    }
    return list;
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
                children: _buildItemExpansionPanelButtons(context, element)
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
    if (list!=null && list.length > 0) {
      list.asMap().forEach((key, value) {
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
