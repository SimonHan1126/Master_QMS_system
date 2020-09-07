
class RiskProcedure {
  final int riskProcedureId;
  final int severity;
  final String severityDescription;
  final int probability;
  final String probabilityDescription;
  final bool isApprove;

  RiskProcedure(this.riskProcedureId, this.severity, this.severityDescription, this.probability, this.probabilityDescription, this.isApprove);

  RiskProcedure.fromJson(Map<String, dynamic> json)
      : riskProcedureId = json['riskProcedureId'],
        severity = json['severity'],
        severityDescription = json['severityDescription'],
        probability = json['probability'],
        probabilityDescription = json['probabilityDescription'],
        isApprove = json['isApprove'];

  Map<String, dynamic> toJson() =>
      {
        'riskProcedureId': riskProcedureId,
        'severity': severity,
        'severityDescription': severityDescription,
        'probability': probability,
        'probabilityDescription': probabilityDescription,
        'isApprove': isApprove,
      };
}