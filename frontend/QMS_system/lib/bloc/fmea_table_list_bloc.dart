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

  void _fmeaTableListControllerSink(var list) {
    _fmeaTableListController.sink.add(
        list.map<FMEATable>((json) => FMEATable.fromJson(json)).toList(growable: false)
    );
  }

  void getAllFMEATable() async {
    _fmeaTableList = await _helper.get("fmea/getAllFMEATable");
    _fmeaTableListControllerSink(_fmeaTableList);
  }

  void deleteFMEATable(String fmeaTableId) async{
    _fmeaTableList = await _helper.get("fmea/removeFMEATable?fmeaTableId=$fmeaTableId");
    _fmeaTableListControllerSink(_fmeaTableList);
  }

  void updateFMEATable(Map<String, dynamic> mapFMEATable) {
    for (int i = 0; i < _fmeaTableList.length; i++) {
      Map<String, dynamic> itemRP = _fmeaTableList[i];
      if (itemRP["hazardId"] == mapFMEATable["hazardId"]) {
        _fmeaTableList[i] = mapFMEATable;
        break;
      }
    }

    _fmeaTableListControllerSink(_fmeaTableList);
  }

  void saveFMEATable(fmeaTable) async {
    final response = await _helper.post("fmea/saveFMEATable", fmeaTable);
    updateFMEATable(response);
  }

  void addAFMEATable(fmeaTable) async {
    final response = await _helper.post("fmea/saveFMEATable", fmeaTable);
    _fmeaTableList.add(response);
    _fmeaTableListControllerSink(_fmeaTableList);
  }

  void approveFMEATable(String fmeaTableId) async {
    final response = await _helper.post("approve/approveFMEATable", fmeaTableId);
    if (response is Map<String, dynamic>) {
      updateFMEATable(response);
    }
  }

  @override
  void dispose() {
    _fmeaTableListController.close();
  }
}