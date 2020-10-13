
import 'package:QMS_system/model/risk_procedure.dart';

class RiskProcedureData {

  static List<RiskProcedure> _list;

  static void setRiskProcedureList(List<RiskProcedure> list) {
    _list = list;
  }

  static List<RiskProcedure> get riskProcedureList => _list;
}