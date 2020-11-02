import 'dart:async';

import 'package:QMS_system/constant/constants.dart';
import 'package:QMS_system/model/risk_procedure.dart';
import 'package:QMS_system/util/api_base_helper.dart';
import 'package:QMS_system/util/base_util.dart';

import 'bloc.dart';

class RiskProcedureBloc implements Bloc {

  Map<String, dynamic> _riskProcedure;
  // 1
  final _riskProcedureController = StreamController<Map<String, dynamic>>();
  final ApiBaseHelper _helper = ApiBaseHelper();

  Stream<Map<String, dynamic>> get riskProcedureStream => _riskProcedureController.stream;
  StreamSink<Map<String, dynamic>> get riskProcedureSink => _riskProcedureController.sink;

  void initRiskProcedure(RiskProcedure riskProcedure) {
    _riskProcedure = riskProcedure.toJson();
    _riskProcedureController.sink.add(_riskProcedure);
  }

  void saveRiskProcedure() async {
    await _helper.post("risk_procedure/saveRiskProcedure", _riskProcedure);
  }

  void addOneItemForRiskProcedure(String riskProcedureId,String riskProcedureKey) {
    List<Map<String, dynamic>> targetList = [];
    List<Map<String, dynamic>> listRPI = _riskProcedure[riskProcedureKey] ?? [];
    for (int i = 0; i < listRPI.length; i++) {
      targetList.add(listRPI.elementAt(i));
    }
    targetList.add(RiskProcedureItem(
        id: BaseUtil.getCurrentTimestamp(), level: "", name: "",
        tag: Constants.map_severity_probability_tag[riskProcedureKey]).toJson());
    _riskProcedure[riskProcedureKey] = targetList;
    _riskProcedureController.sink.add(_riskProcedure);
  }

  void removeOneItemForRiskProcedure(String riskProcedureId,String riskProcedureKey) {
    _riskProcedure[riskProcedureKey] = _riskProcedure[riskProcedureKey] ?? [];
    _riskProcedure[riskProcedureKey].removeLast();
    _riskProcedureController.sink.add(_riskProcedure);
  }

  void addOneItemDescriptionForRiskProcedure(String riskProcedureId,String riskProcedureKey) {
    String descriptionKey = riskProcedureKey + "Description";

    List<Map<String, dynamic>> targetList = [];
    List<Map<String, dynamic>> listRPI = _riskProcedure[descriptionKey] ?? [];
    for (int i = 0; i < listRPI.length; i++) {
      targetList.add(listRPI.elementAt(i));
    }
    targetList.add(RiskProcedureItemDescription(
        itemId: BaseUtil.getCurrentTimestamp(), description: "", name: "",
        tag: Constants.map_severity_probability_tag[riskProcedureKey]).toJson());
    _riskProcedure[descriptionKey] = targetList;
    _riskProcedureController.sink.add(_riskProcedure);
  }

  void removeOneItemDescriptionForRiskProcedure(String riskProcedureId,String riskProcedureKey) {
    String descriptionKey = riskProcedureKey + "Description";
    _riskProcedure[descriptionKey] = _riskProcedure[descriptionKey] ?? [];
    _riskProcedure[descriptionKey].removeLast();
    _riskProcedureController.sink.add(_riskProcedure);
  }

  void updateOneItemForRiskProcedure(String riskProcedureId,String riskProcedureKey, String riskProcedureItemKey, String riskProcedureItemValue, int index) {
    _riskProcedure[riskProcedureKey] = _riskProcedure[riskProcedureKey] ?? [];
    Map<String, dynamic> mapRiskProcedureItem = _riskProcedure[riskProcedureKey][index];
    mapRiskProcedureItem[riskProcedureItemKey] = riskProcedureItemValue;
    _riskProcedureController.sink.add(_riskProcedure);
  }

  void updateHarmForRiskProcedure(String harm) {
    _riskProcedure["harm"] = harm;
    _riskProcedureController.sink.add(_riskProcedure);
  }

  void updateRiskEstimation(String severityId, String probabilityId, String riskLevel) {
    Map<String,dynamic> mapRiskEstimation = _riskProcedure["mapRiskEstimation"] ?? {};
    String key = BaseUtil.getRiskEstimationKey(probabilityId, severityId);
    mapRiskEstimation[key] = riskLevel;
    _riskProcedure["mapRiskEstimation"] = mapRiskEstimation;
    _riskProcedureController.sink.add(_riskProcedure);
  }

  @override
  void dispose() {
    _riskProcedureController.close();
  }
}