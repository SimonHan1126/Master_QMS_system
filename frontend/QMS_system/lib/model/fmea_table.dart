class FMEATable {
  String selectedRPId; // selected risk procedure Id
  String hazardId;
  String hazardClass;
  String sourceId;
  String foreseeableSequenceOfEvents; //both normal and fault conditions
  String hazardousSituation;
  String harm; //result of hazardous situation
  String severityOfHarm; //1-7
  String probability; // Probability of hazardous situation occurring, Probability of hazardous situation leading to harm (1-7)
  String riskPriority; //Risk Priority Number (SxP)
  String recommendingAction; //Risk Control Method
  String typeOfAction;
  String actionDone;
  String severityOfHarm2;
  String probability2;
  String residualRisk; //(S2xP2)
  bool acceptability;

  FMEATable({
    this.selectedRPId,
    this.hazardId,
    this.hazardClass,
    this.sourceId,
    this.foreseeableSequenceOfEvents,
    this.hazardousSituation,
    this.harm,
    this.severityOfHarm,
    this.probability,
    this.riskPriority,
    this.recommendingAction,
    this.typeOfAction,
    this.actionDone,
    this.severityOfHarm2,
    this.probability2,
    this.residualRisk,
    this.acceptability,
  });

  FMEATable.fromJson(Map<String, dynamic> json)
    : selectedRPId = json['selectedRPId'],
      hazardId = json['hazardId'],
      hazardClass = json['hazardClass'],
      sourceId = json['sourceId'],
      foreseeableSequenceOfEvents = json['foreseeableSequenceOfEvents'],
      hazardousSituation = json['hazardousSituation'],
      harm = json['harm'],
      severityOfHarm = json['severityOfHarm'],
      probability = json['probability'],
      riskPriority = json['riskPriority'],
      recommendingAction = json['recommendingAction'],
      typeOfAction = json['typeOfAction'],
      actionDone = json['actionDone'],
      severityOfHarm2 = json['severityOfHarm2'],
      probability2 = json['probability2'],
      residualRisk = json['residualRisk'],
      acceptability = json['acceptability'];

  Map<String, dynamic> toJson() => {
    'selectedRPId' : selectedRPId,
    'hazardId': hazardId,
    'hazardClass': hazardClass,
    'sourceId': sourceId,
    'foreseeableSequenceOfEvents': foreseeableSequenceOfEvents,
    'hazardousSituation': hazardousSituation,
    'harm': harm,
    'severityOfHarm': severityOfHarm,
    'probability': probability,
    'riskPriority': riskPriority,
    'recommendingAction': recommendingAction,
    'typeOfAction': typeOfAction,
    'actionDone': actionDone,
    'severityOfHarm2': severityOfHarm2,
    'probability2': probability2,
    'residualRisk': residualRisk,
    'acceptability': acceptability,
  };
}
