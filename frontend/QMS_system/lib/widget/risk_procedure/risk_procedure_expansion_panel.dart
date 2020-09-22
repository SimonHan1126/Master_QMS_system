import 'package:QMS_system/bloc/bloc_provider.dart';
import 'package:QMS_system/bloc/risk_procedure_bloc.dart';
import 'package:QMS_system/model/risk_procedure.dart';
import 'package:QMS_system/widget/risk_procedure/risk_estimation_table.dart';
import 'package:flutter/material.dart';

class RiskProcedureExpansionPanelWidget extends StatefulWidget {
  RiskProcedureExpansionPanelWidgetState createState() =>  RiskProcedureExpansionPanelWidgetState();
}

class RiskProcedureExpansionPanelWidgetState extends State<RiskProcedureExpansionPanelWidget> {

  final _bloc = RiskProcedureBloc();

  bool _isExpanded = false;

  Map<String, TextEditingController>  _textEditingControllerMap = {};

  Map<String, String> _subTitleMap = {
    "harm" : "Harm",
    "severity" : "Severity",
    "severityDescription" : "Severity Description",
    "probability" : "Probability",
    "probabilityDescription" :  "Probability Description"
  };

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
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

  _saveRiskProcedure() async {
    print("this is _saveRiskProcedure 1111111");

    var riskProcedureObj = {
      "riskProcedureId" : DateTime.now().millisecondsSinceEpoch.toString(),
      "harm" : _textEditingControllerMap["harm"].text,
      "severity" : _textEditingControllerMap["severity"].text,
      "severityDescription" : _textEditingControllerMap["severityDescription"].text,
      "probability" : _textEditingControllerMap["probability"].text,
      "probabilityDescription" :  _textEditingControllerMap["probabilityDescription"].text
      // "isApprove" : false
    };
    //
    // RiskProcedure rp = RiskProcedure(
    //     DateTime.now().millisecondsSinceEpoch.toString(),
    //     int.parse(_textEditingControllerMap["severity"].text),
    //     _textEditingControllerMap["severityDescription"].text,
    //     int.parse(_textEditingControllerMap["probability"].text),
    //     _textEditingControllerMap["probabilityDescription"].text,
    //     false,
    //     _textEditingControllerMap["harm"].text
    // );
    print("this is _saveRiskProcedure 2222 " + riskProcedureObj.toString());
    _bloc.saveRiskProcedure(riskProcedureObj);
  }

  Widget build(BuildContext context) {

    _bloc.submitQuery();
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ExpansionPanelList(
            children: <ExpansionPanel>[
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text("Risk Procedure", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
                            _saveRiskProcedure();
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
                  // child: _buildExpansionPanelItemList(null),
                  child: BlocProvider<RiskProcedureBloc>(
                    bloc: _bloc,
                    child: StreamBuilder(
                      stream: _bloc.riskProcedureStream,
                      builder: (context, snapshot) {
                        return _buildExpansionPanelItemList(snapshot.data);
                      },
                    )
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