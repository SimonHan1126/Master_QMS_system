import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {

  final Map<String, MaterialColor> valueColorMapping;

  final Function(String) callback;

  DropDownMenu(this.valueColorMapping, this.callback);

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
    _valueColorMapping = widget.valueColorMapping;
    _valueColorMapping.forEach((key, value) {
      _listValue.add(key);
    });
    if (_listValue.length > 0) {
      _dropdownValue = _listValue[0];
      _bgColor = _valueColorMapping[_dropdownValue];
    }
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
            child: DropdownButton<String>(
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
                widget.callback(newValue);
              },
              items: _listValue.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      )
    );
  }
}
