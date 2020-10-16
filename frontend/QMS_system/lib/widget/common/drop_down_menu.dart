import 'package:QMS_system/model/dropdown_severity_item.dart';
import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {

  final String _tag;

  final Map<String, MaterialColor> _valueColorMapping;

  final List<dynamic> _valueDataList;

  final Function(String) _callback;

  DropDownMenu(this._tag, this._valueDataList, this._valueColorMapping, this._callback);

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
    _valueColorMapping = widget._valueColorMapping;
    _valueColorMapping.forEach((key, value) {
      _listValue.add(key);
    });
    if (_listValue.length > 0) {
      _dropdownValue = _listValue[0];
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
        int currentIndex = _listValue.indexOf(newValue);
        print("##################### this is DropdownButton index " + currentIndex.toString());
        DropdownSeverityItem dropdownSeverityItem = widget._valueDataList.elementAt(currentIndex);
        print("##################### this is DropdownButton " + dropdownSeverityItem.toJson().toString());
        widget._callback(newValue);
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
