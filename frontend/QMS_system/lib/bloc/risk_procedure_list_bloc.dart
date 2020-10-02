import 'dart:async';

import 'package:QMS_system/model/risk_procedure.dart';
import 'package:QMS_system/util/api_base_helper.dart';

import 'bloc.dart';

class RiskProcedureListBloc implements Bloc {

  var _riskProcedureList = [];
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

  void saveRiskProcedure(riskProcedure) async {
    final response = await _helper.post("risk_procedure/saveRiskProcedure", riskProcedure);
    _riskProcedureList.add(response);
    _riskProcedureListController.sink.add(
        _riskProcedureList.map<RiskProcedure>((json) => RiskProcedure.fromJson(json)).toList(growable: false)
    );
  }

  @override
  void dispose() {
    _riskProcedureListController.close();
  }
}