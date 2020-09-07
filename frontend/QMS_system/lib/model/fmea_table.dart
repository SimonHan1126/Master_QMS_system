class RMEATable {
  final int hazardId;
  final String hazardClass;
  final String sourceId;
  final String foreseeableSequenceOfEvents; //both normal and fault conditions
  final String hazardousSituation;
  final String harm; //result of hazardous situation
  final int severityOfHarm; //1-7
  final int probability; // Probability of hazardous situation occurring, Probability of hazardous situation leading to harm (1-7)
  final int riskPriority; //Risk Priority Number (SxP)
  final String recommendingAction; //Risk Control Method
  final String typeOfAction;
  final String actionDone;
  final int severityOfHarm2;
  final int probability2;
  final int residualRisk; //(S2xP2)
  final bool acceptability;

  RMEATable(
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
  );

  RMEATable.fromJson(Map<String, dynamic> json)
      : hazardId = json['hazardId'],
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
