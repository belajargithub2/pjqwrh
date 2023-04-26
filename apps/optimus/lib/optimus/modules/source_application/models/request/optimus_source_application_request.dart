class OptimusSourceAppRequest {
  String? id;
  String? callbackUrlOrder;
  String? callbackUrlSignature;
  String? callbackUrlStatus;
  String? createdAt;
  String? deleteAt;
  String? sourceApplication;
  String? updatedAt;

  OptimusSourceAppRequest(
      {this.id,
        this.callbackUrlOrder,
        this.callbackUrlSignature,
        this.callbackUrlStatus,
        this.createdAt,
        this.deleteAt,
        this.sourceApplication,
        this.updatedAt});

  Map<String, String?> generateRequest() {
    var request = Map<String, String?>();
    request["id"] = id;
    request["callback_url_order"] = callbackUrlOrder;
    request["callback_url_signature"] = callbackUrlSignature;
    request["callback_url_status"] = callbackUrlStatus;
    request["created_at"] = createdAt;
    request["delete_at"] = deleteAt;
    request["source_application"] = sourceApplication;
    request["updated_at"] = updatedAt;
    return request;
  }
}