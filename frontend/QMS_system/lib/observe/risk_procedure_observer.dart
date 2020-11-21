import 'dart:async';

import 'package:QMS_system/util/base_util.dart';

class RiskProcedureObserver extends StreamView<RiskProcedureObserver> {

  RiskProcedureObserver._(this._controller) : super(_controller.stream);

  factory RiskProcedureObserver() => RiskProcedureObserver._(StreamController());

  final StreamController<RiskProcedureObserver> _controller;

  Map<String, bool> _isSeverityBeModifiedMap = {};
  Map<String, bool> get isSeverityBeModifiedMap => _isSeverityBeModifiedMap;

  Map<String, bool> _isProbabilityBeModifiedMap = {};
  Map<String, bool> get isProbabilityBeModifiedMap => _isProbabilityBeModifiedMap;

  Future<void> close() => _controller.close();

  void setIsSeverityBeModifiedMap (String riskProcedureId, String severityId) {
    print("rp observer setIsSeverityBeModifiedMap riskProcedureId " + riskProcedureId   + " severityId " + severityId);
    String riskProcedureObserverMapKey = BaseUtil.getIsSeverityBeModifiedMapKey(riskProcedureId,severityId);
    _isSeverityBeModifiedMap[riskProcedureObserverMapKey] = true;
    _controller.add(this);
  }

  void setIsProbabilityBeModifiedMap (String riskProcedureId, String probabilityId) {
    print("rp observer setIsProbabilityBeModifiedMap riskProcedureId " + riskProcedureId   + " probabilityId " + probabilityId);
    String riskProcedureObserverMapKey = BaseUtil.getIsProbabilityBeModifiedMapKey(riskProcedureId, probabilityId);
    _isProbabilityBeModifiedMap[riskProcedureObserverMapKey] = true;
    _controller.add(this);
  }

  void clearIsSeverityProbabilityBeModifiedMap() {
    _isSeverityBeModifiedMap = {};
    _isProbabilityBeModifiedMap = {};
    _controller.add(this);
  }

}