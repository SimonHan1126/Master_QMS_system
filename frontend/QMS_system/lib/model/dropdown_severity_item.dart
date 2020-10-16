class DropdownSeverityItem{

  DropdownSeverityItem({this.riskProcedureId, this.index, this.severityName, this.severityLevel, this.severityDescription});

  String riskProcedureId;
  int index;
  String severityName;
  String severityLevel;
  String severityDescription;

  Map<String, dynamic> toJson() =>
      {
        'riskProcedureId': riskProcedureId,
        'index': index,
        'severityName': severityName,
        'severityLevel': severityLevel,
        'severityDescription': severityDescription,
      };
}