import 'dart:async';

import 'package:QMS_system/model/risk_procedure.dart';
import 'package:QMS_system/util/api_base_helper.dart';
import 'bloc.dart';

class RiskProcedureBloc implements Bloc {
  RiskProcedure _riskProcedure;
  RiskProcedure get selectedRiskProcedure => _riskProcedure;

  final _riskProcedureController = StreamController<RiskProcedure>();
  final ApiBaseHelper _helper = ApiBaseHelper();

  Stream<RiskProcedure> get riskProcedureStream => _riskProcedureController.stream;
  StreamSink<RiskProcedure> get riskProcedureSink => _riskProcedureController.sink;

  void submitQuery() async {
    final response = await _helper.get("risk_procedure/findRiskProcedureById?riskProcedureId=78789");
    _riskProcedureController.sink.add(RiskProcedure.fromJson(response));
  }

  @override
  void dispose() {
    _riskProcedureController.close();
  }
}