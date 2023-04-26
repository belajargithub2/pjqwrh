class MerchantRankingListResponse {
  List<MerchantRankingData>? merchantRankingData;
  String? message;

  MerchantRankingListResponse({this.merchantRankingData, this.message});

  MerchantRankingListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      merchantRankingData = new List<MerchantRankingData>.empty(growable: true);
      json['data'].forEach((v) {
        merchantRankingData!.add(new MerchantRankingData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.merchantRankingData != null) {
      data['data'] = this.merchantRankingData!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class MerchantRankingData {
  double? percentage;
  String? name;

  MerchantRankingData({
    this.percentage,
    this.name
  });

  MerchantRankingData.fromJson(Map<String, dynamic> json) {
    percentage = json['percentage'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['percentage'] = this.percentage;
    data['name'] = this.name;
    return data;
  }
}