import 'package:QMS_system/bloc/bloc_provider.dart';
import 'package:QMS_system/bloc/risk_procedure_bloc.dart';
import 'package:QMS_system/bloc/risk_procedure_list_bloc.dart';
import 'package:QMS_system/model/risk_procedure.dart';
import 'package:QMS_system/util/snackbar_util.dart';
import 'package:QMS_system/widget/risk_procedure/risk_estimation_table.dart';
import 'package:flutter/material.dart';

class RiskProcedureExpansionPanelWidget extends StatefulWidget {
  RiskProcedureExpansionPanelWidgetState createState() =>  RiskProcedureExpansionPanelWidgetState();
}

class RiskProcedureExpansionPanelWidgetState extends State<RiskProcedureExpansionPanelWidget> {

  final _rpBloc = RiskProcedureBloc();
  final _rpListBloc = RiskProcedureListBloc();

  bool _isExpanded = true;

  Map<String, TextEditingController>  _textEditingControllerMap = {};

  Map<String, String> _textFieldContentMap = {};

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
  }


  @override
  void dispose() {
    super.dispose();
    _rpBloc.dispose();
    _rpListBloc.dispose();
  }

  Widget _buildExpansionPanelItemList(RiskProcedure riskProcedure) {
    List<Widget> tiles = [];
    if(riskProcedure != null) {
      Map<String, dynamic> mapRiskProcedure = riskProcedure.toJson();
      mapRiskProcedure.forEach((key, value) {
        value = value ?? "";
        if (key.compareTo("riskProcedureId") != 0 && key.compareTo("isApprove") != 0) {
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
                    _textFieldContentMap[key + riskProcedure.riskProcedureId] = value;
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


    tiles.add(RiskEstimationTable());

    return ListBody(
      children: tiles,
    );
  }

  _saveInputtedRiskProcedure(BuildContext context, RiskProcedure riskProcedure) async {

    riskProcedure.harm = _textFieldContentMap["harm" + riskProcedure.riskProcedureId];
    riskProcedure.severity = _textFieldContentMap["severity" + riskProcedure.riskProcedureId];
    riskProcedure.severityDescription = _textFieldContentMap["severityDescription" + riskProcedure.riskProcedureId];
    riskProcedure.probability = _textFieldContentMap["probability" + riskProcedure.riskProcedureId];
    riskProcedure.probabilityDescription =  _textFieldContentMap["probabilityDescription" + riskProcedure.riskProcedureId];
    // "isApprove" : false

    _rpBloc.saveRiskProcedure(riskProcedure);
    SnackBarUtil.showSnackBar(context, "save Risk Procedure successfully");
  }

  _saveEmptyRiskProcedure(BuildContext context, RiskProcedure riskProcedure) async {
    _rpBloc.saveRiskProcedure(riskProcedure);
  }

  _removeRisProcedure(BuildContext context, RiskProcedure riskProcedure) async {
    _isExpanded = false;
    _rpListBloc.deleteRiskProcedure(riskProcedure.riskProcedureId);
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
  }

  Widget _buildExpansionPanelList(List<RiskProcedure> rpList) {
    if (rpList == null || rpList.length <= 0) {
      return SizedBox.shrink();
    }

    _initExpansionPanelContentList(rpList);

    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          // _expansionPanelContentList[panelIndex].isExpanded = !isExpanded;
          _isExpanded = !isExpanded;
        });
      },
      children: _expansionPanelContentList.map<ExpansionPanel>((Item item) {
        final RiskProcedure element = item.riskProcedure;
        return ExpansionPanel(
          headerBuilder: (context, isExpandEd) {
            return ListTile(
              title: Text("Risk Procedure " + element.riskProcedureId,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
          isExpanded: _isExpanded,//item.isExpanded,
          canTapOnHeader: true,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _rpListBloc.getAllRiskProcedure();
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

                  return _buildExpansionPanelList(rpList);
                }
            ),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                _isExpanded = false;
              });

              _saveEmptyRiskProcedure(context,RiskProcedure(
                  riskProcedureId: DateTime.now().millisecondsSinceEpoch.toString(),
                  harm: "",
                  severity: "",
                  severityDescription: "",
                  probability: "",
                  probabilityDescription: "",
                  isApprove: false
              ));
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