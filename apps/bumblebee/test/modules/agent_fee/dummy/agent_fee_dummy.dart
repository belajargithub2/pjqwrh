import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/models/response_get_agent_fee.dart';

final requestGetAgentFee = {
  "start_date": "2021-01-01",
  "end_date": "2021-01-31"
};

final responseGetAgentFee = ResponseGetAgentFee(
    code: 200,
    message: "Success",
    data: ResponseGetAgentFeeData(
      error: null,
      message: "success",
      data: DataData(
        incentives: [
          Incentive(
            afterTax: 1,
            beforeTax: 1,
          ),
          Incentive(
            afterTax: 1,
            beforeTax: 1,
          ),
        ]
      )
    ));
