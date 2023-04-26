
import 'package:meta/meta.dart';
import 'dart:convert';

WordsResponseModel wordsResponseModelFromJson(String str) => WordsResponseModel.fromJson(json.decode(str));

class WordsResponseModel {
  WordsResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int? code;
  String? message;
  WordData? data;

  factory WordsResponseModel.fromJson(Map<String, dynamic> json) => WordsResponseModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : WordData.fromJson(json["data"]),
  );


}

class WordData {
  WordData({
    required this.body,
    required this.footer,
    required this.header,
  });

  String? body;
  String? footer;
  String? header;

  factory WordData.fromJson(Map<String, dynamic> json) => WordData(
    body: json["body"] == null ? null : json["body"],
    footer: json["footer"] == null ? null : json["footer"],
    header: json["header"] == null ? null : json["header"],
  );


}
