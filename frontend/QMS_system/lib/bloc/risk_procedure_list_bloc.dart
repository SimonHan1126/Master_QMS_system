import 'dart:async';

import 'package:QMS_system/model/risk_procedure.dart';
import 'package:QMS_system/util/api_base_helper.dart';

import 'bloc.dart';

class RiskProcedureListBloc implements Bloc {

  var _riskProcedureList = List();
  // 1
  final _riskProcedureListController = StreamController<List<RiskProcedure>>();
  final ApiBaseHelper _helper = ApiBaseHelper();

  Stream<List<RiskProcedure>> get riskProcedureListStream => _riskProcedureListController.stream;
  StreamSink<List<RiskProcedure>> get riskProcedureListSink => _riskProcedureListController.sink;

  void _riskProcedureListControllerSink(var list) {
    _riskProcedureListController.sink.add(
        list.map<RiskProcedure>((json) {
          return RiskProcedure.fromJson(json);
        }).toList(growable: false)
    );
  }

  void getAllRiskProcedure() async {
    _riskProcedureList = await _helper.get("risk_procedure/getAllRiskProcedure");
    _riskProcedureListControllerSink(_riskProcedureList);
  }

  void deleteRiskProcedure(String riskProcedureId) async{
    _riskProcedureList = await _helper.get("risk_procedure/removeRiskProcedure?riskProcedureId=$riskProcedureId");
    _riskProcedureListControllerSink(_riskProcedureList);
  }

  void addRiskProcedure(RiskProcedure riskProcedure) async {
    final response = await _helper.post("risk_procedure/saveRiskProcedure", riskProcedure);
    _riskProcedureList.add(response);
    _riskProcedureListControllerSink(_riskProcedureList);
  }

  void _updateLocalRiskProcedureList(Map<String,dynamic> mapRiskProcedure) {
    for (int i = 0; i < _riskProcedureList.length; i++) {
      Map<String,dynamic> itemRP = _riskProcedureList[i];
      if (itemRP["riskProcedureId"] == mapRiskProcedure["riskProcedureId"]) {
        _riskProcedureList[i] = mapRiskProcedure;
        break;
      }
    }
    _riskProcedureListControllerSink(_riskProcedureList);
  }

  void saveRiskProcedure(RiskProcedure riskProcedure) async {
    final response = await _helper.post("risk_procedure/saveRiskProcedure", riskProcedure);
    _updateLocalRiskProcedureList(response);
  }

  void addOneItemForRiskProcedure(String riskProcedureId,String riskProcedureKey) {
    for (int i = 0; i < _riskProcedureList.length; i++) {
      if(riskProcedureId.compareTo(_riskProcedureList[i]["riskProcedureId"]) == 0) {
        _riskProcedureList[i][riskProcedureKey].add(RiskProcedureItem().toJson());
        break;
      }
    }
    _riskProcedureListControllerSink(_riskProcedureList);
  }

  void removeOneItemForRiskProcedure(String riskProcedureId,String riskProcedureKey) {
    for (int i = 0; i < _riskProcedureList.length; i++) {
      if(riskProcedureId.compareTo(_riskProcedureList[i]["riskProcedureId"]) == 0) {
        _riskProcedureList[i][riskProcedureKey].removeLast();
        break;
      }
    }
    _riskProcedureListControllerSink(_riskProcedureList);
  }

  void addOneItemDescriptionForRiskProcedure(String riskProcedureId,String riskProcedureKey) {
    for (int i = 0; i < _riskProcedureList.length; i++) {
      if(riskProcedureId.compareTo(_riskProcedureList[i]["riskProcedureId"]) == 0) {
        _riskProcedureList[i][riskProcedureKey + "Description"].add(RiskProcedureItemDescription().toJson());
        break;
      }
    }
    _riskProcedureListControllerSink(_riskProcedureList);
  }
  void removeOneItemDescriptionForRiskProcedure(String riskProcedureId,String riskProcedureKey) {
    for (int i = 0; i < _riskProcedureList.length; i++) {
      if(riskProcedureId.compareTo(_riskProcedureList[i]["riskProcedureId"]) == 0) {
        _riskProcedureList[i][riskProcedureKey + "Description"].removeLast();
        break;
      }
    }
    _riskProcedureListControllerSink(_riskProcedureList);
  }

  void updateOneItemForRiskProcedure(String riskProcedureId,String riskProcedureKey, String riskProcedureItemKey, String riskProcedureItemValue, int index) {
    for (int i = 0; i < _riskProcedureList.length; i++) {
      if(riskProcedureId.compareTo(_riskProcedureList[i]["riskProcedureId"]) == 0) {
        Map<String, dynamic> mapRiskProcedureItem = _riskProcedureList[i][riskProcedureKey][index];
        mapRiskProcedureItem[riskProcedureItemKey] = riskProcedureItemValue;
        break;
      }
    }
    _riskProcedureListControllerSink(_riskProcedureList);
  }

  void updateHarmForRiskProcedure(String riskProcedureId, String harm) {
    for (int i = 0; i < _riskProcedureList.length; i++) {
      if(riskProcedureId.compareTo(_riskProcedureList[i]["riskProcedureId"]) == 0) {
        _riskProcedureList[i]["harm"] = harm;
        break;
      }
    }
    _riskProcedureListControllerSink(_riskProcedureList);
  }

  void approveRiskProcedure(String riskProcedureId) async {
    final response = await _helper.post("approve/approveRiskProcedure", riskProcedureId);
    if (response is Map<String, dynamic>) {
      _updateLocalRiskProcedureList(response);
    }
  }

  @override
  void dispose() {
    _riskProcedureListController.close();
  }
}