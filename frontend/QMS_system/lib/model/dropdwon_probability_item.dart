class DropdownProbabilityItem {

  DropdownProbabilityItem({this.fmeaTableId, this.riskProcedureId, this.index, this.probabilityName, this.probabilityLevel, this.fmeaTableKey});

  String fmeaTableId;
  String riskProcedureId;
  int index;
  String probabilityName;
  String probabilityLevel;
  String fmeaTableKey;

  Map<String, dynamic> toJson() =>
      {
        'fmeaTableId' : fmeaTableId,
        'riskProcedureId': riskProcedureId,
        'index': index,
        'probabilityName': probabilityName,
        'probabilityLevel': probabilityLevel,
        'fmeaTableKey': fmeaTableKey,
      };
}