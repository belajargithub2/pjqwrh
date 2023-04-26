class AdditionalDocumentsSubmitResponse {
  String? messages;
  Data? data;
  dynamic errors;
  int? code;

  AdditionalDocumentsSubmitResponse(
      {this.messages, this.data, this.errors, this.code});

  AdditionalDocumentsSubmitResponse.fromJson(Map<String, dynamic> json) {
    messages = json['messages'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errors = json['errors'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messages'] = messages;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['errors'] = errors;
    data['code'] = code;
    return data;
  }
}

class Data {
  String? customerId;
  String? uploadSource;
  List<CustomerDocument>? customerDocument;

  Data({this.customerId, this.uploadSource, this.customerDocument});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    uploadSource = json['upload_source'];
    if (json['customer_document'] != null) {
      customerDocument = <CustomerDocument>[];
      json['customer_document'].forEach((v) {
        customerDocument!.add(CustomerDocument.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customerId;
    data['upload_source'] = uploadSource;
    if (customerDocument != null) {
      data['customer_document'] =
          customerDocument!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerDocument {
  String? typeId;
  String? url;

  CustomerDocument({this.typeId, this.url});

  CustomerDocument.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type_id'] = typeId;
    data['url'] = url;
    return data;
  }
}
