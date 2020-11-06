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
import 'package:QMS_system/widget/common/drop_down_menu.dart';
import 'package:flutter/material.dart';

class FMEASpreadsheetTable extends StatefulWidget {

  final User _user;

  FMEASpreadsheetTable(this._user);

  @override
  State<StatefulWidget> createState() {
    return FMEASpreadsheetTableState();
  }
}

class FMEASpreadsheetTableState extends State<FMEASpreadsheetTable> {

  final FMEATableListBloc _fmeaTableListBloc = FMEATableListBloc();

  List<FMEATable> _listFMEATables = List();

  List<RiskProcedure> _listRiskProcedures = List();
  //key: riskProcedureId
  Map<String, RiskProcedure> _mapRiskProcedures = {};

  //key: fmeaKey + fmeaTableId, value: severity level
  Map<String, String> _severityLevelMap = {};

  //key: fmeaKey + fmeaTableId, value: probability level
  Map<String, String> _probabilityLevelMap = {};

  //key: fmeaKey + fmeaTableId, value: severity id
  Map<String, String> _severityIdMap = {};

  //key: fmeaKey + fmeaTableId, value: probability id
  Map<String, String> _probabilityIdMap = {};

  Map<String, String> _textFieldContentMap = {};

  RiskProcedure _selectedRP;

  @override
  void initState() {
    super.initState();
    _fmeaTableListBloc.getAllFMEATable();
    _initRiskProcedures();
  }

  void _initRiskProcedures() {
    _listRiskProcedures = RiskProcedureData.riskProcedureList;
    if (_listRiskProcedures!=null && _listRiskProcedures.length > 0) {
      _listRiskProcedures.asMap().forEach((key, value) {
        RiskProcedure rp = _listRiskProcedures.elementAt(key);
        _mapRiskProcedures[rp.riskProcedureId] = rp;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _fmeaTableListBloc.dispose();
  }

  _addAnEmptyFMEATable() async {
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
      selectedRPId: "",
    );
    _fmeaTableListBloc.saveFMEATable(fmeaTable);
    _fmeaTableListBloc.getAllFMEATable();
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
    fmeaTable.selectedRPId                = _textFieldContentMap['selectedRPId' + fmeaTable.hazardId];

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
      _fmeaTableListBloc.saveFMEATable(fmeaTable);
      // _updateUI(context, fmeaTable);
    } else {
      // SnackBarUtil.showSnackBar(context, emptyKey + " cannot be empty!!!");
    }
  }

  _removeFMEATable(BuildContext context, FMEATable fmeaTable) async {

    _fmeaTableListBloc.deleteFMEATable(fmeaTable.hazardId);
    // int index = -1;
    // _expansionPanelContentList.asMap().forEach((listIndex, element) {
    //   if(fmeaTable.hazardId.compareTo(element.fmeaTable.hazardId) == 0) {
    //     index = listIndex;
    //   }
    // });
    // setState(() {
    //   if (index >= 0) {
    //     _expansionPanelContentList.removeAt(index);
    //   }
    // });
    // SnackBarUtil.showSnackBar(context, "remove FMEA Table successfully");
  }

  _updateFMEATableByKey(String fmeaTableId, String fmeaTableKey, String fmeaTableValue) {
    for (int i = 0; i < _listFMEATables.length; i++) {
        FMEATable itemTable = _listFMEATables.elementAt(i);
        if (fmeaTableId.compareTo(itemTable.hazardId) == 0) {
          Map<String,dynamic> map = itemTable.toJson();
          map[fmeaTableKey] = fmeaTableValue;
          _fmeaTableListBloc.updateFMEATable(FMEATable.fromJson(map));
          break;
        }
    }
  }

  severityOfHarmCallback(Map<String, dynamic> selectedValue) {
    String fmeaTableKey = selectedValue["fmeaTableKey"]??"";
    String fmeaTableId = selectedValue["fmeaTableId"]??"";
    String key = fmeaTableKey + fmeaTableId;
    String fmeaTableValue = selectedValue["severityName"]??"";
    String severityId = selectedValue["severityId"]??"";
    _updateFMEATableByKey(fmeaTableId, fmeaTableKey, fmeaTableValue);
    _textFieldContentMap[key] = fmeaTableValue;
    setState(() {
      _severityIdMap[key] = severityId;
      _severityLevelMap[key] = selectedValue["severityLevel"]??"";
    });
  }

  Widget _buildSeverityOfHarm(RiskProcedure riskProcedure, String fmeaTableId, String fmeaTableKey, String fmeaTableValue) {
    Map<String, MaterialColor> contentMap = {};
    String severityName = fmeaTableValue ?? "";
    String severityLevel;
    String severityId;
    List<DropdownSeverityItem> dropdownSeverityItemList = List();
    List<RiskProcedureItem> rpSeverityList = riskProcedure.severity??List();
    bool isFindSeverityName = false;
    for (int i = 0; i < rpSeverityList.length; i++) {
      RiskProcedureItem severityItem = rpSeverityList[i];
      contentMap[severityItem.name + ":" + severityItem.level] = Colors.blueGrey;
      if (severityName.compareTo(severityItem.name) == 0) {
        severityLevel = severityItem.level;
        severityId = severityItem.id;
        isFindSeverityName = true;
      }
      DropdownSeverityItem dsi = DropdownSeverityItem(
          fmeaTableId: fmeaTableId,
          severityId: severityItem.id,
          riskProcedureId: riskProcedure.riskProcedureId,
          fmeaTableKey: fmeaTableKey,
          index: i,
          severityName: severityItem.name,
          severityLevel: severityItem.level
      );
      dropdownSeverityItemList.add(dsi);
    }

    if (!isFindSeverityName) {
      severityId = dropdownSeverityItemList[0].severityId;
      severityName = dropdownSeverityItemList[0].severityName;
      severityLevel = dropdownSeverityItemList[0].severityLevel;
    }

    _severityIdMap[fmeaTableKey + fmeaTableId] = severityId;
    _severityLevelMap[fmeaTableKey + fmeaTableId] = severityLevel;
    _textFieldContentMap[fmeaTableKey + fmeaTableId] = severityName;

    String defaultDropdownValue = severityName + ":" + severityLevel;

    return Column(
      children: [DropDownMenu(
          Constants.dropdown_severity_tag_fmea_table,
          fmeaTableKey,
          defaultDropdownValue,
          Colors.red,
          dropdownSeverityItemList,
          contentMap,
          severityOfHarmCallback)
      ],
    );
  }

  probabilityCallback(Map<String, dynamic> selectedValue) {
    String fmeaTableKey = selectedValue["fmeaTableKey"]??"";
    String fmeaTableId = selectedValue["fmeaTableId"]??"";
    String key = fmeaTableKey + fmeaTableId;
    String fmeaTableValue = selectedValue["probabilityName"]??"";
    String probabilityId = selectedValue["probabilityId"]??"";
    _updateFMEATableByKey(fmeaTableId, fmeaTableKey, fmeaTableValue);
    _textFieldContentMap[key] = fmeaTableValue;
    setState(() {
      _probabilityIdMap[key] = probabilityId;
      _probabilityLevelMap[key] = selectedValue["probabilityLevel"]??"";
    });
  }

  Widget _buildProbability(RiskProcedure riskProcedure, String fmeaTableId, String fmeaTableKey, String fmeaTableValue) {
    Map<String, MaterialColor> contentMap = {};
    String probabilityName = fmeaTableValue ?? "";
    String probabilityLevel;
    String probabilityId;
    List<DropdownProbabilityItem> dropdownProbabilityItemList = List();

    List<RiskProcedureItem> rpProbabilityList = riskProcedure.probability??List();
    bool isFindProbabilityName = false;
    for (int i = 0; i < rpProbabilityList.length; i++) {
      RiskProcedureItem probabilityItem = rpProbabilityList[i];
      contentMap[probabilityItem.name + ":" + probabilityItem.level] = Colors.blueGrey;
      if (probabilityName.compareTo(probabilityItem.name) == 0) {
        probabilityLevel = probabilityItem.level;
        probabilityId = probabilityItem.id;
        isFindProbabilityName = true;
      }
      dropdownProbabilityItemList.add(DropdownProbabilityItem(
        fmeaTableId: fmeaTableId,
        riskProcedureId: riskProcedure.riskProcedureId,
        fmeaTableKey: fmeaTableKey,
        index: i,
        probabilityId: probabilityItem.id,
        probabilityName: probabilityItem.name,
        probabilityLevel: probabilityItem.level,
      ));
    }

    if (!isFindProbabilityName) {
      probabilityId = dropdownProbabilityItemList[0].probabilityId;
      probabilityName = dropdownProbabilityItemList[0].probabilityName;
      probabilityLevel = dropdownProbabilityItemList[0].probabilityLevel;
    }

    _probabilityIdMap[fmeaTableKey + fmeaTableId] = probabilityId;
    _probabilityLevelMap[fmeaTableKey + fmeaTableId] = probabilityLevel;
    _textFieldContentMap[fmeaTableKey + fmeaTableId] = probabilityName;

    String defaultDropdownValue = probabilityName + ":" + probabilityLevel;

    return Column(
      children: [
        DropDownMenu(
            Constants.dropdown_probability_tag_fmea_table,
            fmeaTableKey,
            defaultDropdownValue,
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

  Widget _buildTypeOfAction(String fmeaTableId, String fmeaTableKey, String fmeaTableValue) {
    String typeOfAction = fmeaTableValue??"";
    MaterialColor defaultColor = Constants.map_fmea_type_of_action_color[typeOfAction];

    List<Map<String, dynamic>> typeOfActionList = List();
    bool isFindTypeOfAction = false;
    for (int i = 0; i < Constants.fmea_type_of_action_list.length; i++) {
      String typeOfActionValue = Constants.fmea_type_of_action_list[i];
      Map<String, dynamic> itemMap = {
        "fmeaTableId" : "fmeaTable.hazardId",// TO_DO: give a rational variable
        "typeOfActionValue" : typeOfActionValue,
        "fmeaTableKey" : fmeaTableKey
      };
      typeOfActionList.add(itemMap);
      if (typeOfAction.compareTo(typeOfActionValue) == 0) {
        isFindTypeOfAction = true;
      }
    }

    if (!isFindTypeOfAction) {
      typeOfAction = typeOfActionList[0]["typeOfActionValue"];
    }

    _textFieldContentMap[fmeaTableKey + fmeaTableId] = typeOfAction;

    return Column(
      children: [
        DropDownMenu(
            Constants.dropdown_fmea_type_of_action,
            "fmeaTable.hazardId", // TO_DO: give a rational variable
            typeOfAction,
            defaultColor,
            typeOfActionList,
            Constants.map_fmea_type_of_action_color,
            typeOfActionCallback)
      ],
    );
  }

  selectARiskProcedureCallback(Map<String, dynamic> selectedValue) {
    setState(() {
      _selectedRP = selectedValue["riskProcedure"];
    });
    String fmeaTableId = selectedValue["id"]??"";
    for (int i = 0; i < _listFMEATables.length; i++) {
      FMEATable newTable = _listFMEATables[i];
      if (fmeaTableId.compareTo(newTable.hazardId) == 0) {
        newTable.selectedRPId = _selectedRP.riskProcedureId;
        _fmeaTableListBloc.updateFMEATable(newTable);
        break;
      }
    }
  }

  Widget _buildSelectARiskProcedure(String fmeaTableId) {
    Map<String,MaterialColor> mapHarmToColor = {};
    List<MaterialColor> listColors = [
      Colors.lightBlue,
      Colors.lightGreen,
      Colors.teal
    ];
    int loopCount = 0;
    _mapRiskProcedures.forEach((key, value) {
      RiskProcedure riskProcedure = value;
      String harm = riskProcedure.harm??"";
      riskProcedure.harm = harm.length > 0 ? harm : "New Risk Procedure";
      mapHarmToColor[riskProcedure.harm] = listColors.removeAt(loopCount % 2);
      loopCount++;
    });

    return Column(
      children: [
        DropDownMenu(
            Constants.dropdown_select_a_risk_procedure,
            fmeaTableId,
            _listRiskProcedures.elementAt(0).harm,
            listColors.elementAt(0),
            _listRiskProcedures,
            mapHarmToColor,
            selectARiskProcedureCallback
        )
      ],
    );
  }


  Widget _buildSpreadsheetItemWidget(RiskProcedure riskProcedure, String fmeaTableId, String fmeakey, String fmeaValue) {
    Widget spreadSheetItemWidget;
    Map<String,dynamic> mapRiskEstimation = riskProcedure.mapRiskEstimation??{};
    if (fmeakey.compareTo("hazardId") != 0 && fmeakey.compareTo("acceptability") != 0) {
      if (fmeakey.compareTo("severityOfHarm") == 0 || fmeakey.compareTo("severityOfHarm2") == 0 ) {
        spreadSheetItemWidget = _buildSeverityOfHarm(riskProcedure, fmeaTableId, fmeakey, fmeaValue);
      } else if (fmeakey.compareTo("probability") == 0 || fmeakey.compareTo("probability2") == 0) {
        spreadSheetItemWidget = _buildProbability(riskProcedure, fmeaTableId, fmeakey, fmeaValue);
      } else if (fmeakey.compareTo("typeOfAction") == 0) {
        spreadSheetItemWidget = _buildTypeOfAction(fmeaTableId,fmeakey, fmeaValue);
      } else if (fmeakey.compareTo("selectARiskProcedure") == 0) {
        spreadSheetItemWidget = _buildSelectARiskProcedure(fmeaTableId);
      } else {
        Widget childWidget;
        if (fmeakey.compareTo("riskPriority") == 0) {
          String severityKey = "severityOfHarm" + fmeaTableId;
          String probabilityKey = "probability" + fmeaTableId;
          String severityOfHarm = _severityLevelMap[severityKey] ?? "";
          String probability = _probabilityLevelMap[probabilityKey] ?? "";
          String severityId = _severityIdMap[severityKey]??"";
          String probabilityId = _probabilityIdMap[probabilityKey]??"";
          severityOfHarm = severityOfHarm.isEmpty ? "0" : severityOfHarm;
          probability = probability.isEmpty ? "0" : probability;
          int riskPriority = int.parse(severityOfHarm) * int.parse(probability);
          String riskLevel = mapRiskEstimation[BaseUtil.getRiskEstimationKey(probabilityId, severityId)];
          childWidget = Container(
            width: 146.25,
            height: 60.0,
            color: Constants.map_severity_probability_level_to_color[riskLevel],
            child: Center(
              child: Text(riskPriority.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            )
          );
          _textFieldContentMap[fmeakey + fmeaTableId] = riskPriority.toString();
        } else if (fmeakey.compareTo("residualRisk") == 0) {
          String severity2Key = "severityOfHarm2" + fmeaTableId;
          String probability2Key = "probability2" + fmeaTableId;
          String severityOfHarm2 = _severityLevelMap[severity2Key] ?? "";
          String probability2 = _probabilityLevelMap[probability2Key] ?? "";
          String severityId = _severityIdMap[severity2Key]??"";
          String probabilityId = _probabilityIdMap[probability2Key]??"";
          severityOfHarm2 = severityOfHarm2.isEmpty ? "0" : severityOfHarm2;
          probability2 = probability2.isEmpty ? "0" : probability2;
          int residualRisk = int.parse(severityOfHarm2) * int.parse(probability2);
          String riskLevel = mapRiskEstimation[BaseUtil.getRiskEstimationKey(probabilityId, severityId)];
          childWidget = Container(
              width: 146.25,
              height: 60.0,
              color: Constants.map_severity_probability_level_to_color[riskLevel],
              child: Center(
                child: Text(residualRisk.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              )
          );
          _textFieldContentMap[fmeakey + fmeaTableId] = residualRisk.toString();
        } else {
          _textFieldContentMap[fmeakey + fmeaTableId] = fmeaValue;
          childWidget = TextFormField(
            onChanged: (String value) async {
              _textFieldContentMap[fmeakey + fmeaTableId] = value;
            },
            decoration: InputDecoration(
              hintText: fmeaValue,
            ),
          );
        }
        spreadSheetItemWidget = childWidget;
      }
    }
    return spreadSheetItemWidget;
  }

  List<Widget> _buildTableCells(BuildContext context, int passedIndex, List<FMEATable> ftList) {

    List<String> listSubTitleKeys = List();
    List<double> listContentWidth = List();
    Constants.map_fmea_table_sub_title.forEach((key, value) {
      listSubTitleKeys.add(key);
      double textContentWidth = value.length * 15.0 * 0.75;
      if (textContentWidth < 100) {
        textContentWidth = 100;
      }
      listContentWidth.add(textContentWidth);
    });

    String fmeaTableId;
    Map<String,dynamic> mapFMEATable = {};
    FMEATable fmeaTable = FMEATable();
    if (passedIndex > 0) {
      fmeaTable = ftList.elementAt(passedIndex - 1)??FMEATable();
      fmeaTableId = fmeaTable.hazardId;
      String rpId = fmeaTable.selectedRPId??"";
      _selectedRP = rpId.length > 0 ? _mapRiskProcedures[rpId] : _listRiskProcedures[0];
      mapFMEATable = fmeaTable.toJson();
    }

    int listSubTitleLength = listSubTitleKeys.length;
    int columnCount = widget._user.userPermission == Constants.user_permission_qa ? listSubTitleLength + 3 : listSubTitleLength + 2;
    int saveIndex = listSubTitleLength;
    int removeIndex = listSubTitleLength + 1;
    int approveIndex = listSubTitleLength + 2;
    return List.generate(columnCount, (currentGenIndex) {
      var itemBgColor;
      if (passedIndex % 2 == 0) {
        itemBgColor = Colors.grey[400];
      } else {
        itemBgColor = Colors.white;
      }

      Widget itemWidget;
      double itemWidth;
      FontWeight textFontWeight;
      if (currentGenIndex < listSubTitleLength) {
        String key = listSubTitleKeys[currentGenIndex];
        String textContent;
        if (passedIndex < 1) {
          textContent = Constants.map_fmea_table_sub_title[key]??"";
          textFontWeight = FontWeight.bold;
          itemWidget = Text(textContent, style: TextStyle(color: Colors.black54, fontWeight: textFontWeight));
        } else {
          String curFMEAValue = mapFMEATable[key];
          textContent = mapFMEATable[key]??"";
          textFontWeight = FontWeight.normal;
          itemWidget = _buildSpreadsheetItemWidget(_selectedRP, fmeaTableId, key, curFMEAValue);
        }
        itemWidth = listContentWidth[currentGenIndex];
      } else if (currentGenIndex == saveIndex){
        if (passedIndex < 1) {
          textFontWeight = FontWeight.bold;
          itemWidget = Text("SAVE", style: TextStyle(color: Colors.red, fontWeight: textFontWeight));
        } else {
          itemWidget = IconButton(icon: Icon(Icons.save, size: 25.0, color: Color(0xFF50AFC0),), onPressed: () {
            _saveInputtedFMEATable(context, fmeaTable);
          });
        }
        itemWidth = 60.0;
      } else if (currentGenIndex == removeIndex) {
        if (passedIndex < 1) {
          textFontWeight = FontWeight.bold;
          itemWidget = Text("REMOVE", style: TextStyle(color: Colors.red, fontWeight: textFontWeight));
        } else {
          itemWidget = IconButton(icon: Icon(Icons.remove_circle_outline, size: 25.0, color: Color(0xFF50AFC0),), onPressed: () {
            _removeFMEATable(context, fmeaTable);
          });
        }
        itemWidth = 80.0;
      } else if (currentGenIndex == approveIndex) {
        if (passedIndex < 1) {
          textFontWeight = FontWeight.bold;
          itemWidget = Text("APPROVE", style: TextStyle(color: Colors.red, fontWeight: textFontWeight));
        } else {
          itemWidget = IconButton(icon: Icon(Icons.done_outline_rounded, size: 25.0, color: Color(0xFF50AFC0),), onPressed: () {});
        }
        itemWidth = 80.0;
      }

      return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black87),
            color: itemBgColor
        ),
        alignment: Alignment.center,
        width: itemWidth,
        height: 60.0,
        child: itemWidget,
      );
    });
  }

  List<Widget> _buildTableRows(BuildContext context) {

    return List<Widget>.generate(_listFMEATables.length + 1, (rowIndex) {
      return Row(
        children: _buildTableCells(context, rowIndex, _listFMEATables),
      );
    });
  }

  Widget _buildAddButton(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: RaisedButton(
        onPressed: () {
          _addAnEmptyFMEATable();
        },
        color:  Color(0xFF50AFC0),
        child: Text("Add A Column", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
      ),
    );
  }

  Widget _buildDownloadReportButton() {
    return  Padding(
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: RaisedButton(
        onPressed: () {
          // _login();
        },
        color:  Color(0xFF50AFC0),
        child: Text("Download Report", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAddButton(context),
              _buildDownloadReportButton(),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: BlocProvider<FMEATableListBloc>(
                    bloc: _fmeaTableListBloc,
                    child: StreamBuilder(
                      stream: _fmeaTableListBloc.fmeaTableListStream,
                      builder: (context, snapshot) {
                        _listFMEATables = snapshot.data;
                        if (_listFMEATables == null) {
                          return SizedBox.shrink();
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _buildTableRows(context),
                          );
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}