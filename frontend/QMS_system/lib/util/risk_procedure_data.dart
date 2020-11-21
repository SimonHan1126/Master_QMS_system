
import 'package:QMS_system/model/risk_procedure.dart';

import 'base_util.dart';

class RiskProcedureData {

  static List<RiskProcedure> _list;

  static void setRiskProcedureList(List<RiskProcedure> list) {
    _list = list;
  }

  static List<RiskProcedure> get riskProcedureList => _list;

  static Map<String, bool> _isSeverityBeModifiedMap = {};
  static Map<String, bool> get isSeverityBeModifiedMap => _isSeverityBeModifiedMap;

  static Map<String, bool> _isProbabilityBeModifiedMap = {};
  static Map<String, bool> get isProbabilityBeModifiedMap => _isProbabilityBeModifiedMap;

  static void setIsSeverityBeModifiedMap (String riskProcedureId, String severityId) {
    print("rp observer setIsSeverityBeModifiedMap riskProcedureId " + riskProcedureId   + " severityId " + severityId);
    String riskProcedureObserverMapKey = BaseUtil.getIsSeverityBeModifiedMapKey(riskProcedureId,severityId);
    _isSeverityBeModifiedMap[riskProcedureObserverMapKey] = true;
  }

  static void setIsProbabilityBeModifiedMap (String riskProcedureId, String probabilityId) {
    print("rp observer setIsProbabilityBeModifiedMap riskProcedureId " + riskProcedureId   + " probabilityId " + probabilityId);
    String riskProcedureObserverMapKey = BaseUtil.getIsProbabilityBeModifiedMapKey(riskProcedureId, probabilityId);
    _isProbabilityBeModifiedMap[riskProcedureObserverMapKey] = true;
  }

  static void clearIsSeverityProbabilityBeModifiedMap() {
    _isSeverityBeModifiedMap = {};
    _isProbabilityBeModifiedMap = {};
  }
}