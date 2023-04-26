import 'dart:convert';

AgentOrdersResponse agentOrdersResponseFromJson(String str) =>
    AgentOrdersResponse.fromJson(json.decode(str));

class AgentOrdersResponse {
  AgentOrdersResponse({
    this.code,
    this.message,
    this.data,
    this.pageInfo,
  });

  int? code;
  String? message;
  List<Data>? data;
  PageInfo? pageInfo;

  factory AgentOrdersResponse.fromJson(Map<String, dynamic> json) =>
      AgentOrdersResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        pageInfo: json["page_info"] == null
            ? null
            : PageInfo.fromJson(json["page_info"]),
      );
}

class Data {
  Data({
    this.prospectId,
    this.customerName,
    this.orderDate,
    this.legalName,
    this.disbursedAmount,
    this.agentId,
    this.orderStatus,
  });

  String? prospectId;
  String? customerName;
  DateTime? orderDate;
  String? legalName;
  double? disbursedAmount;
  int? agentId;
  EnumOrderTransaction? orderStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
        customerName:
            json["customer_name"] == null ? null : json["customer_name"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        legalName: json["legal_name"] == null ? null : json["legal_name"],
        disbursedAmount: json["disbursed_amount"] == null
            ? null
            : json["disbursed_amount"].toDouble(),
        agentId: json["agent_id"] == null ? null : json["agent_id"],
        orderStatus: json["order_status"] == null
            ? null
            : ResponseEnumOrderTransactionMap[json["order_status"]],
      );
}

class PageInfo {
  PageInfo({
    this.totalRecord,
    this.totalPage,
    this.offset,
    this.limit,
    this.page,
    this.prevPage,
    this.nextPage,
  });

  int? totalRecord;
  int? totalPage;
  int? offset;
  int? limit;
  int? page;
  int? prevPage;
  int? nextPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        totalRecord: json["total_record"] == null ? null : json["total_record"],
        totalPage: json["total_page"] == null ? null : json["total_page"],
        offset: json["offset"] == null ? null : json["offset"],
        limit: json["limit"] == null ? null : json["limit"],
        page: json["page"] == null ? null : json["page"],
        prevPage: json["prev_page"] == null ? null : json["prev_page"],
        nextPage: json["next_page"] == null ? null : json["next_page"],
      );
}

enum EnumOrderTransaction {
  purchaseConfirmed,
  disbursed,
  canceled,
  cancelRequest,
  rejected,
  onProgress,
  approved,
  goLive,
  biChecking
}

const Map<String, EnumOrderTransaction> ResponseEnumOrderTransactionMap = {
  'Purchase Confirmed': EnumOrderTransaction.purchaseConfirmed,
  'Disbursed': EnumOrderTransaction.disbursed,
  'Canceled': EnumOrderTransaction.canceled,
  'Cancel Request': EnumOrderTransaction.cancelRequest,
  'Rejected': EnumOrderTransaction.rejected,
  'On Progress': EnumOrderTransaction.onProgress,
  'Approved': EnumOrderTransaction.approved,
};

extension EnumOrderTransactionExtension on EnumOrderTransaction? {
  String get id {
    switch (this) {
      case EnumOrderTransaction.purchaseConfirmed:
        return "Purchase Confirmed";
      case EnumOrderTransaction.disbursed:
        return "Disbursed";
      case EnumOrderTransaction.canceled:
        return "Canceled";
      case EnumOrderTransaction.cancelRequest:
        return "Cancel Request";
      case EnumOrderTransaction.rejected:
        return "Rejected";
      case EnumOrderTransaction.onProgress:
        return "On Progress";
      case EnumOrderTransaction.approved:
        return "Approved";
      default:
        return "";
    }
  }

  String get name {
    switch (this) {
      case EnumOrderTransaction.purchaseConfirmed:
        return "Pembayaran Dikonfirmasi";
      case EnumOrderTransaction.disbursed:
        return "Terbayar";
      case EnumOrderTransaction.canceled:
        return "Dibatalkan";
      case EnumOrderTransaction.cancelRequest:
        return "Permintaan Pembatalan";
      case EnumOrderTransaction.rejected:
        return "Ditolak";
      case EnumOrderTransaction.onProgress:
        return "Dalam Proses";
      case EnumOrderTransaction.approved:
        return "Disetujui";
      case EnumOrderTransaction.goLive:
        return "Go-Live";
      case EnumOrderTransaction.biChecking:
        return "BI Checking";
      default:
        return "";
    }
  }

  String get message {
    switch (this) {
      case EnumOrderTransaction.purchaseConfirmed:
        return 'Status “Pembayaran Dikonfirmasi” sudah di konfirmasi menandakan bahwa semua dokumen sudah terpenuhi. Silahkan menunggu proses lebih lanjut.';
      case EnumOrderTransaction.disbursed:
        return 'Status “Terbayar” menandakan bahwa sudah dibayarkan dari Kreditplus ke Merchant';
      case EnumOrderTransaction.goLive:
        return 'Status “Go Live” menandakan bahwa pencairan pengajuan konsumen telah dibayarkan dan komisi agent akan dibayarkan maksimal 1 x 24 jam';
      case EnumOrderTransaction.canceled:
        return 'Status “Dibatalkan” menandakan bahwa Permintaan Pembatalan telah diterima.';
      case EnumOrderTransaction.cancelRequest:
        return 'Status “Permintaan Pembatalan” sedang di proses dengan alasan “Pilihan Request Cancel”.';
      case EnumOrderTransaction.rejected:
        return 'Status "Ditolak" menandakan bahwa pengajuan ditolak dan tidak bisa diproses lebih lanjut.';
      case EnumOrderTransaction.onProgress:
        return 'Status “Dalam Proses” menandakan bahwa form baru saja diajukan dan sedang diproses.';
      case EnumOrderTransaction.approved:
        return 'Status “Disetujui” menandakan bahwa pengajuan telah disetujui.';
      default:
        return "";
    }
  }
}
