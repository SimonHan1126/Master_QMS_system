
class RiskProcedure {
  final String riskProcedureId;
  final String harm;
  final int severity;
  final String severityDescription;
  final int probability;
  final String probabilityDescription;
  final bool isApprove;

  RiskProcedure(this.riskProcedureId, this.severity, this.severityDescription, this.probability, this.probabilityDescription, this.isApprove, this.harm);

  RiskProcedure.fromJson(Map<String, dynamic> json)
      : riskProcedureId = json['riskProcedureId'],
        harm = json['harm'],
        severity = json['severity'],
        severityDescription = json['severityDescription'],
        probability = json['probability'],
        probabilityDescription = json['probabilityDescription'],
        isApprove = json['isApprove'];

  Map<String, dynamic> toJson() =>
      {
        'riskProcedureId': riskProcedureId,
        'harm': harm,
        'severity': severity,
        'severityDescription': severityDescription,
        'probability': probability,
        'probabilityDescription': probabilityDescription,
        'isApprove': isApprove,
      };
}