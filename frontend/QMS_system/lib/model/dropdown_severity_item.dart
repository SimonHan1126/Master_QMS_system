class DropdownSeverityItem{

  DropdownSeverityItem({this.fmeaTableId, this.riskProcedureId, this.index, this.severityId, this.severityName, this.severityLevel, this.fmeaTableKey});

  String fmeaTableId;
  String riskProcedureId;
  int index;
  String severityId;
  String severityName;
  String severityLevel;
  String fmeaTableKey;

  Map<String, dynamic> toJson() =>
      {
        'fmeaTableId' : fmeaTableId,
        'riskProcedureId': riskProcedureId,
        'index': index,
        'severityId': severityId,
        'severityName': severityName,
        'severityLevel': severityLevel,
        'fmeaTableKey': fmeaTableKey,
      };
}