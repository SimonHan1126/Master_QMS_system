import 'package:flutter/material.dart';

class Constants {
  Constants._();

  static const String portfoli = ' QMS.';
  static const String o = 'AC.NZ';

  static const prefix_url = "http://45.77.234.245:8080/qms";
  // static const prefix_url = "http://127.0.0.1:8081";

  static const String base_url = prefix_url + "/api/v1/";
  static const String download_report_url = prefix_url + "/api/v1/fmea/downloadReport";

  // menu items
  static const String menu_procedure = 'Procedure';
  static const String menu_fmea = 'FMEA';
  static const String menu_report = 'Report';
  static const String menu_admin = 'Admin';
  static const String menu_logout = "Logout";

  // dropdown menu tags
  static const String dropdown_tag_risk_procedure = "risk_procedure";
  static const String dropdown_severity_tag_fmea_table = "severity_fmea_table";
  static const String dropdown_probability_tag_fmea_table = "probability_fmea_table";
  static const String dropdown_admin_user_permission = "admin_user_permission";
  static const String dropdown_fmea_type_of_action = "fmea_type_of_action";
  static const String dropdown_select_a_risk_procedure = "select_a_risk_procedure";

  static const String approved = "Approved";
  static const String unapproved = "Unapproved";

  // user_permission
  static const int user_permission_team_member = 0;
  static const int user_permission_manager = 1;
  static const int user_permission_qa = 2;
  static const int user_permission_admin = 100;

  static const List<String> user_permission_string_list = [
    "Team member",
    "Manager",
    "QA",
    "ADMIN"
  ];

  static const Map<String, int> map_permission = {
    "Team member" : 0,
    "Manager" : 1,
    "QA" : 2,
    "ADMIN" : 100
  };

  static const Map<int, String> map_permission_reverse = {
    0 : "Team member",
    1 : "Manager",
    2 : "QA",
    100 : "ADMIN"
  };

  static const Map<String, MaterialColor> map_permission_color = {
    "Team member" : Colors.amber,
    "Manager" : Colors.cyan,
    "QA" : Colors.indigo,
    "ADMIN" : Colors.red
  };

  static const Map<int, MaterialColor> map_permission_int_color = {
    0 : Colors.amber,
    1 : Colors.cyan,
    2 : Colors.indigo,
    100 :  Colors.red
  };

  static const List<String> fmea_type_of_action_list = [
    "Design",
    "Prevention",
    "Information",
  ];

  static const Map<String, MaterialColor> map_fmea_type_of_action_color = {
    "Design" : Colors.amber,
    "Prevention" : Colors.cyan,
    "Information" : Colors.indigo,
  };

  static const Map<String, String> map_risk_procedure_sub_title = {
    "harm" : "Harm",
    "severity" : "Severity",
    "severityDescription" : "Severity Description",
    "probability" : "Probability",
    "probabilityDescription" :  "Probability Description"
  };

  static const Map<String, String> map_fmea_table_sub_title = {
    "selectARiskProcedure"        : "Risk Procedure Harm",
    "hazardClass"                 : "Hazard Class",
    "sourceId"                    : "Source Id",
    "foreseeableSequenceOfEvents" : "Foreseeable Sequence of Events",
    "hazardousSituation"          : "Hazardous Situation",
    "harm"                        : "Harm",
    "severityOfHarm"              : "Severity of Harm",
    "probability"                 : "Probability",
    "riskPriority"                : "Risk Priority",
    "recommendingAction"          : "Recommending Action",
    "typeOfAction"                : "Type of Action",
    "actionDone"                  : "Action Done",
    "severityOfHarm2"             : "Severity Of Harm 2",
    "probability2"                : "Probability 2",
    "residualRisk"                : "Residual Risk",
  };

  static const Map<String, MaterialColor> map_severity_probability_level_to_color = {
    "LOW" : Colors.green,
    "MEDIUM" : Colors.amber,
    "HIGH" : Colors.red,
  };

  static const List<String> list_severity_probability_level = ["LOW","MEDIUM","HIGH"];

  static const Map<String, String> map_severity_probability_tag = {
    "severity" : "0",
    "probability" : "1",
    "severityDescription" : "2",
    "probabilityDescription" : "3"
  };
}