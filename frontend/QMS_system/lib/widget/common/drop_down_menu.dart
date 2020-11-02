import 'package:QMS_system/constant/constants.dart';
import 'package:QMS_system/model/dropdown_severity_item.dart';
import 'package:QMS_system/model/dropdwon_probability_item.dart';
import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {

  final String _tag;

  final String _id;

  final String _defaultDropdownValue;

  final MaterialColor _defaultBgColor;

  final Map<String, MaterialColor> _valueColorMapping;

  final List<dynamic> _valueDataList;

  final Function(Map<String, dynamic>) _callback;

  DropDownMenu(this._tag, this._id, this._defaultDropdownValue, this._defaultBgColor, this._valueDataList, this._valueColorMapping, this._callback);

  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {

  String _dropdownValue;

  MaterialColor _bgColor;

  Map<String, MaterialColor> _valueColorMapping;

  List<String> _listValue = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dropdownValue = widget._defaultDropdownValue;

    _bgColor = widget._defaultBgColor;
    _valueColorMapping = widget._valueColorMapping;
    _valueColorMapping.forEach((key, value) {
      _listValue.add(key);
    });

    // TODO: need to remove this if statement (Simon)
    if(_dropdownValue.length == 0) {
      _dropdownValue = _listValue[0];
    }

    if (_listValue.length > 0) {
      _bgColor = _valueColorMapping[_dropdownValue];
    }
  }

  List<DropdownMenuItem<String>> _buildDropdownMenuItems() {
    List<DropdownMenuItem<String>> list = [];
    for (int i = 0; i < _listValue.length; i++) {
      list.add(DropdownMenuItem<String>(
        value: _listValue.elementAt(i),
        child: Text(_listValue.elementAt(i)),
      ));
    }
    return list;
  }

  void _dropdownOnChange(String value) {
    if (widget._tag.compareTo(Constants.dropdown_severity_tag_fmea_table) == 0) {
      DropdownSeverityItem targetItem;
      for ( int i = 0; i <  widget._valueDataList.length; i++) {
        DropdownSeverityItem dropdownSeverityItem = widget._valueDataList.elementAt(i);
        if (dropdownSeverityItem.fmeaTableKey.compareTo(widget._id) == 0 && dropdownSeverityItem.severityName.compareTo(value)  == 0) {
          targetItem = dropdownSeverityItem;
          break;
        }
      }
      widget._callback(targetItem.toJson());
    } else if (widget._tag.compareTo(Constants.dropdown_probability_tag_fmea_table) == 0) {
      DropdownProbabilityItem targetItem;
      for ( int i = 0; i <  widget._valueDataList.length; i++) {
        DropdownProbabilityItem dropdownProbabilityItem = widget._valueDataList.elementAt(i);
        if (dropdownProbabilityItem.fmeaTableKey.compareTo(widget._id) == 0 && dropdownProbabilityItem.probabilityName.compareTo(value)  == 0) {
          targetItem = dropdownProbabilityItem;
          break;
        }
      }
      widget._callback(targetItem.toJson());
    } else if (widget._tag.compareTo(Constants.dropdown_admin_user_permission) == 0) {
      widget._callback({"userId" : widget._id, "userPermission" : Constants.map_permission[value]});
    } else if (widget._tag.compareTo(Constants.dropdown_tag_risk_procedure) == 0) {
      List<Map<String, dynamic>> list = widget._valueDataList??[];
      String probabilityId = "";
      String severityId = "";
      for (int i = 0; i < list.length; i++) {
        Map<String, dynamic> itemMap = list[i];
        if (itemMap["tag"].compareTo(Constants.map_severity_probability_tag["severity"]) == 0) {
          severityId = itemMap["id"];
        } else if (itemMap["tag"].compareTo(Constants.map_severity_probability_tag["probability"]) == 0) {
          probabilityId = itemMap["id"];
        }
      }
      widget._callback({"riskLevel" : value, "probabilityId" : probabilityId, "severityId" : severityId});
    } else if (widget._tag.compareTo(Constants.dropdown_fmea_type_of_action) == 0) {
      int currentIndex = _listValue.indexOf(value);
      Map<String, dynamic> typeOfActionMap = widget._valueDataList.elementAt(currentIndex);
      widget._callback(typeOfActionMap);
    }
  }

  DropdownButton _buildDropdownButton() {
    return DropdownButton<String>(
      value: _dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          _dropdownValue = newValue;
          _bgColor = _valueColorMapping[newValue];
        });
        _dropdownOnChange(newValue);
      },
      items: _buildDropdownMenuItems()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _bgColor,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: _bgColor,//Color.fromRGBO(27, 29, 67, 1.00),
          ),
          child: DropdownButtonHideUnderline(
            child: _buildDropdownButton(),
          ),
        ),
      )
    );
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
