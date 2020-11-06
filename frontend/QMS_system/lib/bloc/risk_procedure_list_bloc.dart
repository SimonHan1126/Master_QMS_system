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

  void getAllRiskProcedure() async {
    _riskProcedureList = await _helper.get("risk_procedure/getAllRiskProcedure");
    _riskProcedureListController.sink.add(
        _riskProcedureList.map<RiskProcedure>((json) => RiskProcedure.fromJson(json)).toList(growable: false)
    );
  }

  void deleteRiskProcedure(String riskProcedureId) async{
    _riskProcedureList = await _helper.get("risk_procedure/removeRiskProcedure?riskProcedureId=$riskProcedureId");
    _riskProcedureListController.sink.add(
        _riskProcedureList.map<RiskProcedure>((json) => RiskProcedure.fromJson(json)).toList(growable: false)
    );
  }

  void addRiskProcedure(RiskProcedure riskProcedure) async {
    final response = await _helper.post("risk_procedure/saveRiskProcedure", riskProcedure);
    _riskProcedureList.add(response);
    _riskProcedureListController.sink.add(
        _riskProcedureList.map<RiskProcedure>((json) => RiskProcedure.fromJson(json)).toList(growable: false)
    );
  }

  void saveRiskProcedure(RiskProcedure riskProcedure) async {
    final response = await _helper.post("risk_procedure/saveRiskProcedure", riskProcedure);
    RiskProcedure responsedRP= RiskProcedure.fromJson(response);
    List<RiskProcedure> list = List();
    _riskProcedureList.asMap().forEach((key, value) {
      RiskProcedure itemRP = RiskProcedure.fromJson(value);
      if (itemRP.riskProcedureId == responsedRP.riskProcedureId) {
        list.add(responsedRP);
      } else {
        list.add(itemRP);
      }
    });
    _riskProcedureListController.sink.add(list);
  }

  void addOneItemForRiskProcedure(String riskProcedureId,String riskProcedureKey) {
    for (int i = 0; i < _riskProcedureList.length; i++) {
      if(riskProcedureId.compareTo(_riskProcedureList[i]["riskProcedureId"]) == 0) {
        _riskProcedureList[i][riskProcedureKey].add(RiskProcedureItem().toJson());
        break;
      }
    }
    _riskProcedureListController.sink.add(
        _riskProcedureList.map<RiskProcedure>((json) => RiskProcedure.fromJson(json)).toList(growable: false)
    );
  }

  void removeOneItemForRiskProcedure(String riskProcedureId,String riskProcedureKey) {
    for (int i = 0; i < _riskProcedureList.length; i++) {
      if(riskProcedureId.compareTo(_riskProcedureList[i]["riskProcedureId"]) == 0) {
        _riskProcedureList[i][riskProcedureKey].removeLast();
        break;
      }
    }
    _riskProcedureListController.sink.add(
        _riskProcedureList.map<RiskProcedure>((json) => RiskProcedure.fromJson(json)).toList(growable: false)
    );
  }

  void addOneItemDescriptionForRiskProcedure(String riskProcedureId,String riskProcedureKey) {
    for (int i = 0; i < _riskProcedureList.length; i++) {
      if(riskProcedureId.compareTo(_riskProcedureList[i]["riskProcedureId"]) == 0) {
        _riskProcedureList[i][riskProcedureKey + "Description"].add(RiskProcedureItemDescription().toJson());
        break;
      }
    }
    _riskProcedureListController.sink.add(
        _riskProcedureList.map<RiskProcedure>((json) => RiskProcedure.fromJson(json)).toList(growable: false)
    );
  }
  void removeOneItemDescriptionForRiskProcedure(String riskProcedureId,String riskProcedureKey) {
    for (int i = 0; i < _riskProcedureList.length; i++) {
      if(riskProcedureId.compareTo(_riskProcedureList[i]["riskProcedureId"]) == 0) {
        _riskProcedureList[i][riskProcedureKey + "Description"].removeLast();
        break;
      }
    }
    _riskProcedureListController.sink.add(
        _riskProcedureList.map<RiskProcedure>((json) => RiskProcedure.fromJson(json)).toList(growable: false)
    );
  }

  void updateOneItemForRiskProcedure(String riskProcedureId,String riskProcedureKey, String riskProcedureItemKey, String riskProcedureItemValue, int index) {
    for (int i = 0; i < _riskProcedureList.length; i++) {
      if(riskProcedureId.compareTo(_riskProcedureList[i]["riskProcedureId"]) == 0) {
        Map<String, dynamic> mapRiskProcedureItem = _riskProcedureList[i][riskProcedureKey][index];
        mapRiskProcedureItem[riskProcedureItemKey] = riskProcedureItemValue;
        break;
      }
    }
    _riskProcedureListController.sink.add(
        _riskProcedureList.map<RiskProcedure>((json) => RiskProcedure.fromJson(json)).toList(growable: false)
    );
  }

  void updateHarmForRiskProcedure(String riskProcedureId, String harm) {
    for (int i = 0; i < _riskProcedureList.length; i++) {
      if(riskProcedureId.compareTo(_riskProcedureList[i]["riskProcedureId"]) == 0) {

        _riskProcedureList[i]["harm"] = harm;
        break;
      }
    }
    _riskProcedureListController.sink.add(
        _riskProcedureList.map<RiskProcedure>((json) => RiskProcedure.fromJson(json)).toList(growable: false)
    );
  }

  @override
  void dispose() {
    _riskProcedureListController.close();
  }
}