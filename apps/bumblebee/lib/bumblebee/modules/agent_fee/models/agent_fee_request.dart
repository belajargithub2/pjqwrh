import 'dart:convert';

import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/models/response_get_agent_fee.dart';

RequestGetAgentFee requestGetAgentFeeFromJson(String str) => RequestGetAgentFee.fromJson(json.decode(str));

String requestGetAgentFeeToJson(RequestGetAgentFee data) => json.encode(data.toJson());

class RequestGetAgentFee {
  RequestGetAgentFee({
    required this.startDate,
    required this.endDate,
    this.incentives,
  });

  String startDate;
  String endDate;
  List<Incentive>? incentives;

  factory RequestGetAgentFee.fromJson(Map<String, dynamic> json) => RequestGetAgentFee(
    startDate: json["start_date"],
    endDate: json["end_date"],
    incentives: json["incentives"] == null ? [] : List<Incentive>.from(json["incentives"]!.map((x) => Incentive.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "start_date": startDate,
    "end_date": endDate,
    "incentives": incentives == null ? [] : List<dynamic>.from(incentives!.map((x) => x.toJson())),
  };
}
