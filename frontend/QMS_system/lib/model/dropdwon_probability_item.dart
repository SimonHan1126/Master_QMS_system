class DropdownProbabilityItem {

  DropdownProbabilityItem({this.fmeaTableId, this.riskProcedureId, this.index, this.probabilityId, this.probabilityName, this.probabilityLevel, this.fmeaTableKey});

  String fmeaTableId;
  String riskProcedureId;
  int index;
  String probabilityId;
  String probabilityName;
  String probabilityLevel;
  String fmeaTableKey;

  Map<String, dynamic> toJson() =>
      {
        'fmeaTableId' : fmeaTableId,
        'riskProcedureId': riskProcedureId,
        'index': index,
        'probabilityId': probabilityId,
        'probabilityName': probabilityName,
        'probabilityLevel': probabilityLevel,
        'fmeaTableKey': fmeaTableKey,
      };
}