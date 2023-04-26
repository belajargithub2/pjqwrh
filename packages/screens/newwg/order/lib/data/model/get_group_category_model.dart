import 'dart:convert';

GetGroupCategoryModel getGroupCategoryResponseFromJson(String str) => GetGroupCategoryModel.fromJson(json.decode(str));

String getGroupCategoryResponseToJson(GetGroupCategoryModel data) => json.encode(data.toJson());

class GetGroupCategoryModel {
  GetGroupCategoryModel({
    this.messages,
    this.data,
    this.errors,
    this.code,
  });

  String? messages;
  List<GroupCategory>? data;
  dynamic errors;
  int? code;

  factory GetGroupCategoryModel.fromJson(Map<String, dynamic> json) => GetGroupCategoryModel(
    messages: json["messages"],
    data: json["data"] == null ? [] : List<GroupCategory>.from(json["data"]!.map((x) => GroupCategory.fromJson(x))),
    errors: json["errors"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "messages": messages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "errors": errors,
    "code": code,
  };
}

class GroupCategory {
  GroupCategory({
    this.id,
    this.code,
    this.name,
    this.isAllowMultiAsset,
    this.notes,
  });

  int? id;
  String? code;
  String? name;
  bool? isAllowMultiAsset;
  String? notes;

  factory GroupCategory.fromJson(Map<String, dynamic> json) => GroupCategory(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    isAllowMultiAsset: json["is_allow_multi_asset"],
    notes: json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "is_allow_multi_asset": isAllowMultiAsset,
    "notes": notes,
  };
}