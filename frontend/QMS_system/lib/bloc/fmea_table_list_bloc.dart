import 'dart:async';

import 'package:QMS_system/model/fmea_table.dart';
import 'package:QMS_system/util/api_base_helper.dart';

import 'bloc.dart';

class FMEATableListBloc implements Bloc {

  var _fmeaTableList = List();
  // 1
  final _fmeaTableListController = StreamController<List<FMEATable>>();
  final ApiBaseHelper _helper = ApiBaseHelper();

  Stream<List<FMEATable>> get fmeaTableListStream => _fmeaTableListController.stream;
  StreamSink<List<FMEATable>> get fmeaTableListSink => _fmeaTableListController.sink;

  void getAllFMEATable() async {
    _fmeaTableList = await _helper.get("fmea/getAllFMEATable");
    _fmeaTableListController.sink.add(
        _fmeaTableList.map<FMEATable>((json) => FMEATable.fromJson(json)).toList(growable: false)
    );
  }

  void deleteFMEATable(String fmeaTableId) async{
    _fmeaTableList = await _helper.get("fmea/removeFMEATable?fmeaTableId=$fmeaTableId");
    _fmeaTableListController.sink.add(
        _fmeaTableList.map<FMEATable>((json) => FMEATable.fromJson(json)).toList(growable: false)
    );
  }

  void updateFMEATable(FMEATable newTable) {
    List<FMEATable> list = List();
    _fmeaTableList.asMap().forEach((key, value) {
      FMEATable table = FMEATable.fromJson(value);
      if (table.hazardId == newTable.hazardId) {
        list.add(newTable);
      } else {
        list.add(table);
      }
    });
    _fmeaTableListController.sink.add(list);
  }

  void saveFMEATable(fmeaTable) async {
    final response = await _helper.post("fmea/saveFMEATable", fmeaTable);

    FMEATable responseTable = FMEATable.fromJson(response);
    updateFMEATable(responseTable);
  }

  @override
  void dispose() {
    _fmeaTableListController.close();
  }
}