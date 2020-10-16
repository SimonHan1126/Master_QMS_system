class DropdownProbabilityItem {

  DropdownProbabilityItem({this.riskProcedureId, this.index, this.probabilityName, this.probabilityLevel, this.probabilityDescription});

  String riskProcedureId;
  int index;
  String probabilityName;
  String probabilityLevel;
  String probabilityDescription;

  Map<String, dynamic> toJson() =>
      {
        'riskProcedureId': riskProcedureId,
        'index': index,
        'probabilityName': probabilityName,
        'probabilityLevel': probabilityLevel,
        'probabilityDescription': probabilityDescription,
      };
}