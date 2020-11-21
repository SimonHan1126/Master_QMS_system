import 'package:QMS_system/bloc/bloc_provider.dart';
import 'package:QMS_system/bloc/fmea_table_group_bloc.dart';
import 'package:QMS_system/constant/constants.dart';
import 'package:QMS_system/model/fmea_table.dart';
import 'package:QMS_system/model/fmea_table_group.dart';
import 'package:QMS_system/model/risk_procedure.dart';
import 'package:QMS_system/model/user.dart';
import 'package:QMS_system/util/base_util.dart';
import 'package:QMS_system/util/risk_procedure_data.dart';
import 'package:QMS_system/widget/common/drop_down_menu.dart';
import 'package:QMS_system/widget/common/sub_page_title.dart';
import 'package:QMS_system/widget/fmea_table/fmea_spreadsheet_table.dart';
import 'package:flutter/material.dart';

class FMEATablePage extends StatefulWidget {

  final User _user;

  FMEATablePage(this._user);

  @override
  _FMEATablePageState createState() => _FMEATablePageState();
}

class _FMEATablePageState extends State<FMEATablePage> {

  final FMEATableGroupBloc _fmeaTableGroupBloc = FMEATableGroupBloc();

  Map<String, RiskProcedure> _mapRiskProcedures = {};

  List<RiskProcedure> _listRiskProcedures = List();

  RiskProcedure _selectedRiskProcedure;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initRiskProcedures();
    _getAllFMEATableGroup();
  }

  void _getAllFMEATableGroup() {
    _fmeaTableGroupBloc.getAllFMEATableGroup();
  }

  void _initRiskProcedures() {
    _listRiskProcedures = RiskProcedureData.riskProcedureList;
    if (_listRiskProcedures!=null && _listRiskProcedures.length > 0) {
      _listRiskProcedures.asMap().forEach((key, value) {
        RiskProcedure rp = _listRiskProcedures.elementAt(key);
        _mapRiskProcedures[rp.riskProcedureId] = rp;
      });
    } else {
      _listRiskProcedures = _listRiskProcedures??List();
      _listRiskProcedures.add(RiskProcedure());
    }
    _selectedRiskProcedure = _listRiskProcedures[0];
  }

  void _addAnEmptyFMEATableGroup() {
    String currentRiskProcedureId = _selectedRiskProcedure.riskProcedureId;
    RiskProcedure rp = _mapRiskProcedures[currentRiskProcedureId];
    List<FMEATable> fmeaTableList = List();
    List<RiskProcedureItem> severityList = rp.severity??[];
    List<RiskProcedureItem> probabilityList = rp.probability??[];
    for(int i = 0; i < severityList.length; i++) {
      RiskProcedureItem severityItem = severityList.elementAt(i);
      String severityName = severityItem.name;
      String severityLevel = severityItem.level.isEmpty ? "1" : severityItem.level;
      for(int j = 0; j < probabilityList.length; j++) {
        RiskProcedureItem probabilityItem = probabilityList.elementAt(j);
        String probabilityName = probabilityItem.name;
        String probabilityLevel = probabilityItem.level.isEmpty ? "1" : probabilityItem.level;
        int numberRiskPriority = int.parse(severityLevel) * int.parse(probabilityLevel);
        fmeaTableList.add(FMEATable(
            hazardId: BaseUtil.getCurrentTimestamp(),
            hazardClass: "",
            sourceId: "",
            foreseeableSequenceOfEvents: "",
            hazardousSituation: "",
            harm: "",
            severityOfHarm: severityName,
            probability: probabilityName,
            riskPriority: numberRiskPriority.toString(),
            recommendingAction: "",
            typeOfAction: "",
            actionDone: "",
            severityOfHarm2: severityName,
            probability2: probabilityName,
            residualRisk: numberRiskPriority.toString(),
            selectedRPId: currentRiskProcedureId
        ));
      }
    }
    _fmeaTableGroupBloc.addAFMEATableGroup(FMEATableGroup(
      riskProcedureId: currentRiskProcedureId,
      fmeaTableGroupId: BaseUtil.getCurrentTimestamp(),
      fmeaTableList: fmeaTableList
    ));
  }

  void _removeLastFMEATableGroup() {
    _fmeaTableGroupBloc.removeLastFMEATableGroup();
  }

  void _fmeaSpreadSheetSaveCallback(Map<String, dynamic> map) {
    print("FMEATablePage _fmeaSpreadSheetSaveCallback " + map.toString());
    _fmeaTableGroupBloc.saveAFMEATableToGroup(map["fmeaTableGroupId"], map["fmeaTable"]);
  }

  void _fmeaSpreadSheetRemoveCallback(Map<String, dynamic> map) {
    print("FMEATablePage _fmeaSpreadSheetRemoveCallback " + map.toString());
    _fmeaTableGroupBloc.removeAFMEATableFromGroup(map["fmeaTableGroupId"], map["fmeaTable"]);
    _getAllFMEATableGroup();
  }

  List<Widget> _buildFMEASpreadSheetTables(List<FMEATableGroup> list) {
    List<Widget> widgetList = List();

    list.asMap().forEach((key, value) {
      widgetList.add(
        Text("FMEA table " + (key + 1).toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
      );
      FMEATableGroup fmeaTableGroup = value;
      widgetList.add(FMEASpreadsheetTable(
        widget._user,
        _mapRiskProcedures[fmeaTableGroup.riskProcedureId],
        fmeaTableGroup.fmeaTableGroupId,
        fmeaTableGroup.fmeaTableList,
        _fmeaSpreadSheetSaveCallback,
        _fmeaSpreadSheetRemoveCallback
      ));
    });
    return widgetList;
  }

  selectARiskProcedureCallback(Map<String, dynamic> selectedValue) {
    _selectedRiskProcedure = selectedValue["riskProcedure"]??RiskProcedure();
    print("selectARiskProcedureCallback " + _selectedRiskProcedure.toJson().toString());
  }

  Widget _buildDropdownMenuOfRiskProcedure() {
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
      mapHarmToColor[riskProcedure.harm] = listColors.elementAt(loopCount % 2);
      loopCount++;
    });

    return Container(
      child: Expanded(
        child:  DropDownMenu(
          Constants.dropdown_select_a_risk_procedure,
          "fmeaTableId",
          _listRiskProcedures.elementAt(0).harm,
          listColors.elementAt(0),
          _listRiskProcedures,
          mapHarmToColor,
          selectARiskProcedureCallback
        ),
      ),
    );
  }

  Widget _buildAddAFMEATableGroupButton() {
    return  Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
      child: RaisedButton(
        onPressed: () {
          _addAnEmptyFMEATableGroup();
        },
        color:  Color(0xFF50AFC0),
        child: Text("Add A FMEA Table", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
      ),
    );
  }

  Widget _buildRemoveAFMEATableGroupButton() {
    return  Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
      child: RaisedButton(
        onPressed: () {
          _removeLastFMEATableGroup();
        },
        color:  Color(0xFF50AFC0),
        child: Text("Remove A FMEA Table", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SubPageTitle(title: "FMEA Table Management"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdownMenuOfRiskProcedure(),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAddAFMEATableGroupButton(),
                _buildRemoveAFMEATableGroupButton()
              ],
            ),
            BlocProvider<FMEATableGroupBloc>(
              bloc: _fmeaTableGroupBloc,
              child: StreamBuilder(
                stream: _fmeaTableGroupBloc.fmeaTableListStream,
                builder: (context, snapshot) {
                  List<FMEATableGroup> list = snapshot.data;
                  if (list == null) {
                    return SizedBox.shrink();
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildFMEASpreadSheetTables(list),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}