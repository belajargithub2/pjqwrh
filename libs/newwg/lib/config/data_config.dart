class DataConfig {
  String croId = "";
  String croName = "";
  String supplierId = "";
  String supplierName = "";
  String supplierAddress = "";
  String supplierKey = "";
  String prospectId = "";
  String branchId = "";
  bool isNewWg = true;
  bool isShowIndicator = true;
  bool isEditOrder = false;

  DataConfig._();

  static final instance = DataConfig._();

  fromJson(Map json) {
    croId = json['cro_id'] ?? croId;
    croName = json['cro_name'] ?? croName;
    supplierId = json['supplier_id'] ?? supplierId;
    supplierName = json['supplier_name'] ?? supplierName;
    supplierAddress = json['supplier_address'] ?? supplierAddress;
    supplierKey = json['supplier_key'] ?? supplierKey;
    prospectId = json['prospect_id'] ?? prospectId;
    branchId = json['branch_id'] ?? branchId;
    isNewWg = json['is_new_wg'] ?? isNewWg;
    isShowIndicator = json['is_show_indicator'] ?? isShowIndicator;
    isEditOrder = json['is_edit_order'] ?? isEditOrder;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cro_id'] = croId;
    data['cro_name'] = croName;
    data['supplier_id'] = supplierId;
    data['supplier_name'] = supplierName;
    data['supplier_address'] = supplierAddress;
    data['supplier_key'] = supplierKey;
    data['prospect_id'] = prospectId;
    data['branch_id'] = branchId;
    data['is_new_wg'] = isNewWg;
    data['is_show_indicator'] = isShowIndicator;
    data['is_edit_order'] = isEditOrder;
    return data;
  }
}
