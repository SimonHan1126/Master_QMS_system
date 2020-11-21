import 'dart:async';

import 'package:QMS_system/model/fmea_table.dart';
import 'package:QMS_system/model/fmea_table_group.dart';
import 'package:QMS_system/util/api_base_helper.dart';

import 'bloc.dart';

class FMEATableGroupBloc implements Bloc {

  var _fmeaTableGroupList = List();
  // 1
  final _fmeaTableGroupListController = StreamController<List<FMEATableGroup>>();
  final ApiBaseHelper _helper = ApiBaseHelper();

  Stream<List<FMEATableGroup>> get fmeaTableListStream => _fmeaTableGroupListController.stream;
  StreamSink<List<FMEATableGroup>> get fmeaTableListSink => _fmeaTableGroupListController.sink;

  void _fmeaTableGroupListControllerSink(var list) {
    _fmeaTableGroupListController.sink.add(
        list.map<FMEATableGroup>((json) => FMEATableGroup.fromJson(json)).toList(growable: false)
    );
  }

  void getAllFMEATableGroup() async {
    _fmeaTableGroupList = await _helper.get("fmeaTableGroup/getAllFMEATableGroup");
    _fmeaTableGroupListControllerSink(_fmeaTableGroupList);
  }

  void removeLastFMEATableGroup() async{
    print("FMEATableGroupBloc removeLastFMEATableGroup ------- 111111");
    if (_fmeaTableGroupList == null || _fmeaTableGroupList.length <= 0) {
      return;
    }
    print("FMEATableGroupBloc removeLastFMEATableGroup ------- 2222222");
    var fmeaTableGroup = _fmeaTableGroupList.elementAt(_fmeaTableGroupList.length - 1);
    print("FMEATableGroupBloc removeLastFMEATableGroup ------- 3333333 fmeaTableGroup " + fmeaTableGroup.toString());
    print("FMEATableGroupBloc removeLastFMEATableGroup ------- 44444444 fmeaTableGroupId " +  fmeaTableGroup["fmeaTableGroupId"]);
    _fmeaTableGroupList = await _helper.get("fmeaTableGroup/removeFMEATableGroup?fmeaTableGroupId=" + fmeaTableGroup["fmeaTableGroupId"]);
    print("FMEATableGroupBloc removeLastFMEATableGroup ------- 55555555 " + _fmeaTableGroupList.toString());
    _fmeaTableGroupListControllerSink(_fmeaTableGroupList);
  }

  // void updateFMEATable(Map<String, dynamic> mapFMEATable) {
  //   for (int i = 0; i < _fmeaTableGroupList.length; i++) {
  //     Map<String, dynamic> itemRP = _fmeaTableGroupList[i];
  //     if (itemRP["hazardId"] == mapFMEATable["hazardId"]) {
  //       _fmeaTableGroupList[i] = mapFMEATable;
  //       break;
  //     }
  //   }
  //
  //   _fmeaTableGroupListControllerSink(_fmeaTableGroupList);
  // }

  void removeAFMEATableFromGroup(String fmeaTableGroupId, FMEATable fmeaTable) async {
    FMEATableGroup fmeaTableGroup;
    for(int i = 0; i < _fmeaTableGroupList.length; i++) {
      FMEATableGroup itemFTG = FMEATableGroup.fromJson(_fmeaTableGroupList.elementAt(i));
      if (itemFTG.fmeaTableGroupId.compareTo(fmeaTableGroupId) == 0) {
        fmeaTableGroup = itemFTG;
        break;
      }
    }
    if (fmeaTableGroup == null) {
      return;
    }

    List<FMEATable> fmeaTableList = List();
    fmeaTableGroup.fmeaTableList = fmeaTableGroup.fmeaTableList??[];
    for (int i = 0; i < fmeaTableGroup.fmeaTableList.length; i++) {
      FMEATable itemFT = fmeaTableGroup.fmeaTableList.elementAt(i);
      if (itemFT.hazardId.compareTo(fmeaTable.hazardId) != 0) {
        fmeaTableList.add(itemFT);
      }
    }

    fmeaTableGroup.fmeaTableList = fmeaTableList;

    final response = await _helper.post("fmeaTableGroup/saveFMEATableGroup", fmeaTableGroup);
    print("removeAFMEATableFromGroup response " + response.toString());
    // updateFMEATable(response);
    _fmeaTableGroupList = response;
    _fmeaTableGroupListControllerSink(_fmeaTableGroupList);
  }

  void saveAFMEATableToGroup(String fmeaTableGroupId, FMEATable fmeaTable) async {
    FMEATableGroup fmeaTableGroup;
    for(int i = 0; i < _fmeaTableGroupList.length; i++) {
      FMEATableGroup itemFTG = FMEATableGroup.fromJson(_fmeaTableGroupList.elementAt(i));
      if (itemFTG.fmeaTableGroupId.compareTo(fmeaTableGroupId) == 0) {
        fmeaTableGroup = itemFTG;
        break;
      }
    }
    if (fmeaTableGroup == null) {
      return;
    }

    bool isFind = false;
    fmeaTableGroup.fmeaTableList = fmeaTableGroup.fmeaTableList??[];
    for (int i = 0; i < fmeaTableGroup.fmeaTableList.length; i++) {
      FMEATable itemFT = fmeaTableGroup.fmeaTableList.elementAt(i);
      if (itemFT.hazardId.compareTo(fmeaTable.hazardId) == 0) {
        fmeaTableGroup.fmeaTableList[i] = fmeaTable;
        isFind = true;
        break;
      }
    }

    if (!isFind) {
      fmeaTableGroup.fmeaTableList.add(fmeaTable);
    }
    final response = await _helper.post("fmeaTableGroup/saveFMEATableGroup", fmeaTableGroup);
    print("saveAFMEATableToGroup response " + response.toString());
    // updateFMEATable(response);
    _fmeaTableGroupList = response;
    _fmeaTableGroupListControllerSink(_fmeaTableGroupList);
  }

  void addAFMEATableGroup(fmeaTableGroup) async {
    final response = await _helper.post("fmeaTableGroup/saveFMEATableGroup", fmeaTableGroup);
    _fmeaTableGroupList = response;
    _fmeaTableGroupListControllerSink(_fmeaTableGroupList);
  }

  // void approveFMEATable(String fmeaTableId) async {
  //   final response = await _helper.post("approve/approveFMEATable", fmeaTableId);
  //   if (response is Map<String, dynamic>) {
  //     updateFMEATable(response);
  //   }
  // }

  @override
  void dispose() {
    _fmeaTableGroupListController.close();
  }
}