import 'package:dailycheckin/core/model/setting_data_model.dart';

class SettingModel {
  List<SettingDataModel>? data;
  int? code;
  String? error;

  SettingModel({this.data, this.code});

  SettingModel.withError(String errorMessage){
    error = errorMessage;
  }

  SettingModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SettingDataModel>[];
      json['data'].forEach((v) {
        data!.add(SettingDataModel.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    return data;
  }
}
