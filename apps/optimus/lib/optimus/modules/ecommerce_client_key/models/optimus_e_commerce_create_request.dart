class OptimusECommerceClientKeyCreateRequest {
  String? callbackUrlOrder;
  String? callbackUrlSignature;
  String? callbackUrlStatus;
  String? createdAt;
  String? key;
  String? name;
  String? supplierId;
  String? supplierName;
  String? updatedAt;

  OptimusECommerceClientKeyCreateRequest(
      {this.callbackUrlOrder,
      this.callbackUrlSignature,
      this.callbackUrlStatus,
      this.createdAt,
      this.key,
      this.name,
      this.supplierId,
      this.supplierName,
      this.updatedAt});

  Map<String, String?> generateRequest() {
    var request = Map<String, String?>();
    request["callback_url_order"] = callbackUrlOrder;
    request["callback_url_signature"] = callbackUrlSignature;
    request["callback_url_status"] = callbackUrlStatus;
    request["created_at"] = createdAt;
    request["key"] = key;
    request["name"] = name;
    request["supplier_id"] = supplierId;
    request["updated_at"] = updatedAt;
    return request;
  }
}
