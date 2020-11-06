import 'package:QMS_system/bloc/bloc_provider.dart';
import 'package:QMS_system/bloc/risk_procedure_list_bloc.dart';
import 'package:QMS_system/constant/constants.dart';
import 'package:QMS_system/model/risk_procedure.dart';
import 'package:QMS_system/model/user.dart';
import 'package:QMS_system/util/base_util.dart';
import 'package:QMS_system/util/risk_procedure_data.dart';
import 'package:QMS_system/util/snackbar_util.dart';
import 'package:QMS_system/widget/risk_procedure/risk_estimation_table.dart';
import 'package:QMS_system/widget/risk_procedure/risk_procedure_edit_dialog.dart';
import 'package:flutter/material.dart';

class RiskProcedureExpansionPanelWidget extends StatefulWidget {

  final User _user;

  RiskProcedureExpansionPanelWidget(this._user);

  RiskProcedureExpansionPanelWidgetState createState() =>  RiskProcedureExpansionPanelWidgetState();
}

class RiskProcedureExpansionPanelWidgetState extends State<RiskProcedureExpansionPanelWidget> {
  final _rpListBloc = RiskProcedureListBloc();

  int _pressedPanelIndex = -1;
  bool _pressedPanelIsExpanded = false;

  List<Item> _expansionPanelContentList = List();

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

  _saveEmptyRiskProcedure(BuildContext context) async {
    RiskProcedure riskProcedure = RiskProcedure(
      riskProcedureId: BaseUtil.getCurrentTimestamp(),
      harm: "",
      severity: [RiskProcedureItem(
        id: BaseUtil.getCurrentTimestamp(), level: "", name: "",
        tag: Constants.map_severity_probability_tag["severity"])],
      severityDescription: [RiskProcedureItemDescription(
        itemId: BaseUtil.getCurrentTimestamp(), description: "", name: "",
        tag: Constants.map_severity_probability_tag["severityDescription"])],
      probability: [RiskProcedureItem(
        id: BaseUtil.getCurrentTimestamp(), level: "", name: "",
        tag: Constants.map_severity_probability_tag["probability"])],
      probabilityDescription: [RiskProcedureItemDescription(
        itemId: BaseUtil.getCurrentTimestamp(), description: "", name: "",
        tag: Constants.map_severity_probability_tag["probabilityDescription"])],
      mapRiskEstimation: {},
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
    _expansionPanelContentList = List();
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

  Widget _buildProcedureDisplayUI(String riskProcedureId, String rpKey, var rpValue) {

    List<IconButton> listTitleButtons = List();

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

      for(int i = 0; i < rpValue.length; i ++) {
        RiskProcedureItem item = RiskProcedureItem.fromJson(rpValue[i]);
        String name = item.name ?? "";
        String level = item.level ?? "";

        rowList.add(
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(name),
                ),
                Expanded(
                  child: Text(level)
                ),
              ],
            )
        );
      }
    } else {
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

        rowList.add(
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(name)
                ),
                Expanded(
                  child: Text(description)
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

  Widget _buildExpansionPanelItemList(RiskProcedure riskProcedure) {
    List<Widget> tiles = List();
    if(riskProcedure != null) {
      Map<String, dynamic> mapRiskProcedure = riskProcedure.toJson();
      mapRiskProcedure.forEach((key, value) {
        value = value ?? "";
        if (key.compareTo("riskProcedureId") != 0 && key.compareTo("isApprove") != 0 && key.compareTo("mapRiskEstimation") != 0) {

          Widget widget;

          if (key.compareTo("harm") != 0) {
            widget = _buildProcedureDisplayUI(riskProcedure.riskProcedureId, key, value);
          } else {
            tiles.add(
                Container(
                  padding: EdgeInsets.all(10),
                  child:  Text(Constants.map_risk_procedure_sub_title[key.toString()], style: TextStyle(fontWeight: FontWeight.bold)),
                )
            );

            widget = Text(value.toString());
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

    tiles.add(RiskEstimationTable(riskProcedure, callback, false));

    return ListBody(
      children: tiles,
    );
  }

  callback(Map<String, dynamic> selectedValue) {
    _rpListBloc.getAllRiskProcedure();
  }

  _showDialog(RiskProcedure riskProcedure) {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return Container(
          child: RiskProcedureEditDialog(riskProcedure, callback),
        );
      },
      fullscreenDialog: true,
    ));
  }

  List<IconButton> _buildItemExpansionPanelButtons(BuildContext context, RiskProcedure riskProcedure) {
    List<IconButton> list = List();
    list.add(IconButton(icon: Icon(Icons.delete, size: 25.0, color: Color(0xFF50AFC0),), onPressed: () {_removeRisProcedure(context, riskProcedure);},));
    list.add(IconButton(icon: Icon(Icons.edit, size: 25.0, color: Color(0xFF50AFC0),), onPressed: () { _showDialog(riskProcedure); },));

    if (widget._user.userPermission == Constants.user_permission_qa) {
      list.add(IconButton(icon: Icon(Icons.done_outline_rounded, size: 25.0, color: Color(0xFF50AFC0),), onPressed: () {
        print("approve");
      },));
    }
    return list;
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
        String harm = element.harm.length > 0 ? element.harm : "New Risk Procedure";
        return ExpansionPanel(
          headerBuilder: (context, isExpandEd) {
            return ListTile(
              title: RichText(
                text: TextSpan(
                  text: harm ,
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