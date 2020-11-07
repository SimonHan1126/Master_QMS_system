class RiskProcedure{
  String riskProcedureId;
  String harm;
  List<RiskProcedureItem> severity;
  List<RiskProcedureItemDescription> severityDescription;
  List<RiskProcedureItem> probability;
  List<RiskProcedureItemDescription> probabilityDescription;
  Map<String,dynamic> mapRiskEstimation;
  String approve;

  RiskProcedure({this.riskProcedureId, this.severity, this.severityDescription, this.probability, this.probabilityDescription, this.approve, this.harm, this.mapRiskEstimation});

  RiskProcedure.fromJson(Map<String, dynamic> json)
      : riskProcedureId = json['riskProcedureId'],
        harm = json['harm'],
        severity = json['severity'].map<RiskProcedureItem>((json) => RiskProcedureItem.fromJson(json)).toList(growable: false),
        severityDescription = json['severityDescription'].map<RiskProcedureItemDescription>((json) => RiskProcedureItemDescription.fromJson(json)).toList(growable: false),
        probability = json['probability'].map<RiskProcedureItem>((json) => RiskProcedureItem.fromJson(json)).toList(growable: false),
        probabilityDescription = json['probabilityDescription'].map<RiskProcedureItemDescription>((json) => RiskProcedureItemDescription.fromJson(json)).toList(growable: false),
        approve = json['approve'],
        mapRiskEstimation = json['mapRiskEstimation'];

  Map<String, dynamic> toJson() =>
      {
        'riskProcedureId': riskProcedureId,
        'harm': harm,
        'severity': severity.map<Map<String,dynamic>>((item) => item.toJson()).toList(growable: false),
        'severityDescription': severityDescription.map<Map<String,dynamic>>((item) => item.toJson()).toList(growable: false),
        'probability': probability.map<Map<String,dynamic>>((item) => item.toJson()).toList(growable: false),
        'probabilityDescription': probabilityDescription.map<Map<String,dynamic>>((item) => item.toJson()).toList(growable: false),
        'approve': approve,
        'mapRiskEstimation': mapRiskEstimation,
      };
}

class RiskProcedureItem {
  String id;
  String level;
  String name;
  String tag;

  RiskProcedureItem({this.id, this.level, this.name, this.tag});

  RiskProcedureItem.fromJson(Map<String, dynamic> json)
    : level = json['level'],
      name = json['name'],
      id = json["id"],
      tag = json["tag"];

  Map<String, dynamic> toJson() => {
    'level' : level,
    'name' : name,
    'id' : id,
    'tag' : tag
  };
}

class RiskProcedureItemDescription {
  String itemId;
  String name;
  String description;
  String tag;

  RiskProcedureItemDescription({this.itemId, this.description, this.name, this.tag});

  RiskProcedureItemDescription.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        name = json['name'],
        itemId = json["itemId"],
        tag = json["tag"];

  Map<String, dynamic> toJson() => {
    'description' : description,
    'name' : name,
    'itemId' : itemId,
    'tag' : tag
  };
}