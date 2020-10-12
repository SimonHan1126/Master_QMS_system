
class RiskProcedure{
  String riskProcedureId;
  String harm;
  List<RiskProcedureItem> severity;
  List<RiskProcedureItemDescription> severityDescription;
  List<RiskProcedureItem> probability;
  List<RiskProcedureItemDescription> probabilityDescription;
  bool isApprove;

  RiskProcedure({this.riskProcedureId, this.severity, this.severityDescription, this.probability, this.probabilityDescription, this.isApprove, this.harm});

  RiskProcedure.fromJson(Map<String, dynamic> json)
      : riskProcedureId = json['riskProcedureId'],
        harm = json['harm'],
        severity = json['severity'].map<RiskProcedureItem>((json) => RiskProcedureItem.fromJson(json)).toList(growable: false),
        severityDescription = json['severityDescription'].map<RiskProcedureItemDescription>((json) => RiskProcedureItemDescription.fromJson(json)).toList(growable: false),
        probability = json['probability'].map<RiskProcedureItem>((json) => RiskProcedureItem.fromJson(json)).toList(growable: false),
        probabilityDescription = json['probabilityDescription'].map<RiskProcedureItemDescription>((json) => RiskProcedureItemDescription.fromJson(json)).toList(growable: false),
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

class RiskProcedureItem {
  String level;
  String name;

  RiskProcedureItem({this.level, this.name});

  RiskProcedureItem.fromJson(Map<String, dynamic> json)
    : level = json['level'],
      name = json['name'];

  Map<String, dynamic> toJson() => {
    'level' : level,
    'name' : name
  };
}

class RiskProcedureItemDescription {
  String name;
  String description;

  RiskProcedureItemDescription({this.description, this.name});

  RiskProcedureItemDescription.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
    'description' : description,
    'name' : name
  };
}