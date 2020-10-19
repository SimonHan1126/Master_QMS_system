class DropdownSeverityItem{

  DropdownSeverityItem({this.fmeaTableId, this.riskProcedureId, this.index, this.severityName, this.severityLevel, this.fmeaTableKey});

  String fmeaTableId;
  String riskProcedureId;
  int index;
  String severityName;
  String severityLevel;
  String fmeaTableKey;

  Map<String, dynamic> toJson() =>
      {
        'fmeaTableId' : fmeaTableId,
        'riskProcedureId': riskProcedureId,
        'index': index,
        'severityName': severityName,
        'severityLevel': severityLevel,
        'fmeaTableKey': fmeaTableKey,
      };
}