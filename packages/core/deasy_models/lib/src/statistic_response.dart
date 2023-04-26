class StatisticResponse {
  String? message;
  List<StatisticData>? statisticData;

  StatisticResponse({this.message, this.statisticData});

  StatisticResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      statisticData = new List<StatisticData>.empty(growable: true);
      json['data'].forEach((v) {
        statisticData!.add(new StatisticData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.statisticData != null) {
      data['data'] = this.statisticData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatisticData {
  int? weekNumber;
  int? weekCount;

  StatisticData({this.weekNumber, this.weekCount});

  StatisticData.fromJson(Map<String, dynamic> json) {
    weekNumber = json['week_number'];
    weekCount = json['week_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['week_number'] = this.weekNumber;
    data['week_count'] = this.weekCount;
    return data;
  }
}