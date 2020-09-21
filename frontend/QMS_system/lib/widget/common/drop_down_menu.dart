import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {

  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String _dropdownValue = 'LOW';

  var _bgColor = Colors.green;

  var valueColorMapping = {
    "LOW" : Colors.green,
    "MEDIUM" : Colors.amber,
    "HIGH" : Colors.red,
  };

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
                  _bgColor = valueColorMapping[newValue];
                });
              },
              items: <String>['LOW', 'MEDIUM', 'HIGH'].map<DropdownMenuItem<String>>((String value) {
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
