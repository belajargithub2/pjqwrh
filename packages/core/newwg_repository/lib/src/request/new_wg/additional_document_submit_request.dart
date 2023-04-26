import 'package:deasy_encryptor/deasy_encryptor.dart';

class AdditionalDocumentsSubmitRequest {
  int? customerId;
  String? uploadSource;
  List<CustomerDocument>? customerDocument;

  AdditionalDocumentsSubmitRequest(
      {this.customerId, this.uploadSource, this.customerDocument});

  AdditionalDocumentsSubmitRequest.fromJson(Map<String, dynamic> json) {
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
    const kpHubEncryptkey = "PLATFORMS-APIToEncryptDecryptAPI";

    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customerId == null ? null : AesHelper(key: KeyConstant.platformKey).encrypt(customerId.toString());
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
