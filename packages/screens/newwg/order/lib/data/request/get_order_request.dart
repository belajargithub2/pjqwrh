import 'dart:convert';

GetOrderRequest getOrderRequestFromJson(String str) => GetOrderRequest.fromJson(json.decode(str));

String getOrderRequestToJson(GetOrderRequest data) => json.encode(data.toJson());

class GetOrderRequest {
    GetOrderRequest({
        this.prospectId,
        this.sourceApplication,
    });

    String? prospectId;
    String? sourceApplication;

    factory GetOrderRequest.fromJson(Map<String, dynamic> json) => GetOrderRequest(
        prospectId: json["prospect_id"],
        sourceApplication: json["source_application"],
    );

    Map<String, dynamic> toJson() => {
        "prospect_id": prospectId,
        "source_application": sourceApplication,
    };
}
