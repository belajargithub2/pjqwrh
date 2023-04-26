class OptimusMaintenanceResponse {
  int? _code;
  String? _message;
  MaintenanceDataResponse? _data;

  OptimusMaintenanceResponse(
      {int? code, String? message, MaintenanceDataResponse? data}) {
    if (code != null) {
      this._code = code;
    }
    if (message != null) {
      this._message = message;
    }
    if (data != null) {
      this._data = data;
    }
  }

  int? get code => _code;

  set code(int? code) => _code = code;

  String? get message => _message;

  set message(String? message) => _message = message;

  MaintenanceDataResponse? get data => _data;

  set data(MaintenanceDataResponse? data) => _data = data;

  OptimusMaintenanceResponse.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null
        ? new MaintenanceDataResponse.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}

class MaintenanceDataResponse {
  Merchant? _merchant;
  Agent? _agent;

  MaintenanceDataResponse({Merchant? merchant, Agent? agent}) {
    if (merchant != null) {
      this._merchant = merchant;
    }
    if (agent != null) {
      this._agent = agent;
    }
  }

  Merchant? get merchant => _merchant;

  set merchant(Merchant? merchant) => _merchant = merchant;

  Agent? get agent => _agent;

  set agent(Agent? agent) => _agent = agent;

  MaintenanceDataResponse.fromJson(Map<String, dynamic> json) {
    _merchant = json['merchant'] != null
        ? new Merchant.fromJson(json['merchant'])
        : null;
    _agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._merchant != null) {
      data['merchant'] = this._merchant!.toJson();
    }
    if (this._agent != null) {
      data['agent'] = this._agent!.toJson();
    }
    return data;
  }
}

class Merchant {
  bool? _snbModul;
  bool? _allModulMerchant;

  Merchant({bool? snbModul, bool? allModulMerchant}) {
    if (snbModul != null) {
      this._snbModul = snbModul;
    }
    if (allModulMerchant != null) {
      this._allModulMerchant = allModulMerchant;
    }
  }

  bool? get snbModul => _snbModul;

  set snbModul(bool? snbModul) => _snbModul = snbModul;

  bool? get allModulMerchant => _allModulMerchant;

  set allModulMerchant(bool? allModulMerchant) =>
      _allModulMerchant = allModulMerchant;

  Merchant.fromJson(Map<String, dynamic> json) {
    _snbModul = json['snb_modul'];
    _allModulMerchant = json['all_modul_merchant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['snb_modul'] = this._snbModul;
    data['all_modul_merchant'] = this._allModulMerchant;
    return data;
  }
}

class Agent {
  bool? _orderFormModul;
  bool? _allModulAgent;

  Agent({bool? orderFormModul, bool? allModulAgent}) {
    if (orderFormModul != null) {
      this._orderFormModul = orderFormModul;
    }
    if (allModulAgent != null) {
      this._allModulAgent = allModulAgent;
    }
  }

  bool? get orderFormModul => _orderFormModul;

  set orderFormModul(bool? orderFormModul) => _orderFormModul = orderFormModul;

  bool? get allModulAgent => _allModulAgent;

  set allModulAgent(bool? allModulAgent) => _allModulAgent = allModulAgent;

  Agent.fromJson(Map<String, dynamic> json) {
    _orderFormModul = json['order_form_modul'];
    _allModulAgent = json['all_modul_agent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_form_modul'] = this._orderFormModul;
    data['all_modul_agent'] = this._allModulAgent;
    return data;
  }
}
