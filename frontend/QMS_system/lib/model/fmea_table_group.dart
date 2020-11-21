import 'package:QMS_system/model/fmea_table.dart';

class FMEATableGroup {
  String fmeaTableGroupId;
  String riskProcedureId;
  List<FMEATable> fmeaTableList;

  FMEATableGroup({
    this.fmeaTableGroupId,
    this.riskProcedureId,
    this.fmeaTableList,
  });
  FMEATableGroup.fromJson(Map<String, dynamic> json)
      : fmeaTableGroupId = json['fmeaTableGroupId'],
        riskProcedureId = json['riskProcedureId'],
        fmeaTableList = json['fmeaTableList'].map<FMEATable>((json) => FMEATable.fromJson(json)).toList(growable: false);

  Map<String, dynamic> toJson() => {
    'fmeaTableGroupId' : fmeaTableGroupId,
    'riskProcedureId': riskProcedureId,
    'fmeaTableList': fmeaTableList.map<Map<String,dynamic>>((item) => item.toJson()).toList(growable: false),
  };
}