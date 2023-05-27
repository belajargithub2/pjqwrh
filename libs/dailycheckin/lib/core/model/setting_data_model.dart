
class SettingDataModel {
  String? name;
  String? payload;
  String? enabled;

  SettingDataModel({this.name, this.payload, this.enabled});

  SettingDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    payload = json['payload'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['payload'] = payload;
    data['enabled'] = enabled;
    return data;
  }
}