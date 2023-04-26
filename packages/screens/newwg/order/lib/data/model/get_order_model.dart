import 'dart:convert';

GetOrderModel getOrderModelFromJson(String str) => GetOrderModel.fromJson(json.decode(str));

String getOrderModelToJson(GetOrderModel data) => json.encode(data.toJson());

class GetOrderModel {
    GetOrderModel({
        this.messages,
        this.data,
        this.errors,
        this.code,
    });

    String? messages;
    GetOrderModelData? data;
    dynamic errors;
    int? code;

    factory GetOrderModel.fromJson(Map<String, dynamic> json) => GetOrderModel(
        messages: json["messages"],
        data: json["data"] == null ? null : GetOrderModelData.fromJson(json["data"]),
        errors: json["errors"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "messages": messages,
        "data": data?.toJson(),
        "errors": errors,
        "code": code,
    };
}

class GetOrderModelData {
    GetOrderModelData({
        this.prospectId,
        this.groupCategoryId,
        this.groupCategoryCode,
        this.groupCategoryName,
        this.assets,
        this.croId,
        this.croName,
        this.supplierId,
        this.supplierName,
        this.supplierAddress,
        this.userId,
        this.customerId,
        this.customerName,
        this.customerLimitCategory,
        this.customerMobilePhone,
        this.latitude,
        this.longitude,
        this.sourceApplication,
        this.branchId,
        this.isNewWg,
        this.isEditable,
    });

    String? prospectId;
    int? groupCategoryId;
    String? groupCategoryCode;
    String? groupCategoryName;
    List<GetOrderAsset>? assets;
    String? croId;
    String? croName;
    String? supplierId;
    String? supplierName;
    String? supplierAddress;
    String? userId;
    String? customerId;
    String? customerName;
    String? customerLimitCategory;
    String? customerMobilePhone;
    String? latitude;
    String? longitude;
    String? sourceApplication;
    String? branchId;
    bool? isNewWg;
    bool? isEditable;

    factory GetOrderModelData.fromJson(Map<String, dynamic> json) => GetOrderModelData(
        prospectId: json["prospect_id"],
        groupCategoryId: json["group_category_id"],
        groupCategoryCode: json["group_category_code"],
        groupCategoryName: json["group_category_name"],
        assets: json["assets"] == null ? [] : List<GetOrderAsset>.from(json["assets"]!.map((x) => GetOrderAsset.fromJson(x))),
        croId: json["cro_id"],
        croName: json["cro_name"],
        supplierId: json["supplier_id"],
        supplierName: json["supplier_name"],
        supplierAddress: json["supplier_address"],
        userId: json["user_id"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        customerLimitCategory: json["customer_limit_category"],
        customerMobilePhone: json["customer_mobile_phone"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        sourceApplication: json["source_application"],
        branchId: json["branch_id"],
        isNewWg: json["is_new_wg"],
        isEditable: json['is_editable']
    );

    Map<String, dynamic> toJson() => {
        "prospect_id": prospectId,
        "group_category_id": groupCategoryId,
        "group_category_code": groupCategoryCode,
        "group_category_name": groupCategoryName,
        "assets": assets == null ? [] : List<dynamic>.from(assets!.map((x) => x.toJson())),
        "cro_id": croId,
        "cro_name": croName,
        "supplier_id": supplierId,
        "supplier_name": supplierName,
        "supplier_address": supplierAddress,
        "user_id": userId,
        "customer_id": customerId,
        "customer_name": customerName,
        "customer_limit_category": customerLimitCategory,
        "customer_mobile_phone": customerMobilePhone,
        "latitude": latitude,
        "longitude": longitude,
        "source_application": sourceApplication,
        "branch_id": branchId,
        "is_new_wg": isNewWg,
        "is_editable": isEditable,
    };
}

class GetOrderAsset {
    GetOrderAsset({
        this.code,
        this.description,
        this.categoryId,
        this.categoryName,
        this.otr,
        this.qty,
    });

    String? code;
    String? description;
    String? categoryId;
    String? categoryName;
    int? otr;
    int? qty;

    factory GetOrderAsset.fromJson(Map<String, dynamic> json) => GetOrderAsset(
        code: json["code"],
        description: json["description"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        otr: json["otr"],
        qty: json["qty"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "category_id": categoryId,
        "category_name": categoryName,
        "otr": otr,
        "qty": qty,
    };
}
