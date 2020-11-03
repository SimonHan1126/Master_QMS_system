import 'package:QMS_system/bloc/bloc_provider.dart';
import 'package:QMS_system/bloc/fmea_table_list_bloc.dart';
import 'package:QMS_system/constant/constants.dart';
import 'package:QMS_system/model/fmea_table.dart';
import 'package:flutter/material.dart';

class FMEASpreadsheetTable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FMEASpreadsheetTableState();
  }
}

class FMEASpreadsheetTableState extends State<FMEASpreadsheetTable> {

  final FMEATableListBloc _fmeaTableListBloc = FMEATableListBloc();

  @override
  void initState() {
    super.initState();
    _fmeaTableListBloc.getAllFMEATable();
  }


  @override
  void dispose() {
    super.dispose();
    _fmeaTableListBloc.dispose();
  }

  List<Widget> _buildTableCells(int passedIndex, List<FMEATable> ftList) {

    List<String> listSubTitleKeys = [];
    List<double> listContentWidth = [];
    Constants.map_fmea_table_sub_title.forEach((key, value) {
      listSubTitleKeys.add(key);
      double textContentWidth = value.length * 15.0 * 0.75;
      if (textContentWidth < 100) {
        textContentWidth = 100;
      }
      listContentWidth.add(textContentWidth);
    });

    return List.generate(listSubTitleKeys.length, (currentGenIndex) {
      String key = listSubTitleKeys[currentGenIndex];
      String textContent;
      FontWeight textFontWeight;
      var itemBgColor;

      if (passedIndex < 1) {
        textContent = Constants.map_fmea_table_sub_title[key]??"";
        textFontWeight = FontWeight.bold;
      } else {
        FMEATable fmeaTable = ftList.elementAt(passedIndex - 1);
        Map<String,dynamic> mapFMEATable = fmeaTable.toJson();
        textContent = mapFMEATable[key]??"";
        textFontWeight = FontWeight.normal;
      }

      if (passedIndex % 2 == 0) {
        itemBgColor = Colors.grey[400];
      } else {
        itemBgColor = Colors.white;
      }

      return Container(
        alignment: Alignment.center,
        width: listContentWidth[currentGenIndex],
        height: 60.0,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black87),
          color: itemBgColor
        ),
        child: Text(textContent, style: TextStyle(color: Colors.black54, fontWeight: textFontWeight)),
      );
    });
  }

  List<Widget> _buildTableRows(List<FMEATable> ftList) {

    return List<Widget>.generate(1 + ftList.length, (rowIndex) {
      return Row(
        children: _buildTableCells(rowIndex, ftList),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
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
                      List<FMEATable> ftList = snapshot.data;
                      if (ftList == null) {
                        return SizedBox.shrink();
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildTableRows(ftList),
                        );
                      }
                    },
                  ),
              ),
            ),
          )
        ],
      ),
    );
  }
}