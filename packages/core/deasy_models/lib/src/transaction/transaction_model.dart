import 'package:deasy_models/src/agent_orders_response.dart';
import 'package:deasy_models/src/transaction/transaction_response.dart';
import 'package:flutter/material.dart';

class TransactionListModel{
  DateTime? orderDate;
  EnumOrderTransaction? orderStatus;
  DateTime? bastDate;
  DateTime? epoDate;
  String? customerReceiptPhotoUrl;
  String? imeiUrl;
  String? prospectId;
  DateTime? invoiceDate;
  String? sourceApplication;
  bool? trackingExists;
  double? payToDealerAmount;
  List<ConfirmationMethodElement>? confirmationMethods = [];
  String? customerName;

  TransactionListModel(
      {this.orderDate,
      this.orderStatus,
      this.bastDate,
      this.epoDate,
      this.customerReceiptPhotoUrl,
      this.imeiUrl,
      this.prospectId,
      this.invoiceDate,
      this.trackingExists,
      this.sourceApplication,
      this.confirmationMethods,
      this.payToDealerAmount,
      this.customerName});
}


class TransactionModel{
  String? name;
  String? image;
  String? id;
  Color? textColor;
  Color? bgColor;

  TransactionModel({this.name,this.textColor,this.bgColor, this.image,this.id});
}
