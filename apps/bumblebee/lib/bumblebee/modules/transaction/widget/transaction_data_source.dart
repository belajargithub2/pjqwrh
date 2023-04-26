import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransactionDataSource extends DataTableSource {

  final List<TransactionResponseData> _list;
  final int _totalRecord;

  TransactionDataSource(this._list, this._totalRecord);

  @override
  DataRow getRow(int index) {
    final _transaction = _list[index];
    return DataRow(
      cells: [
        DataCell(DeasyTextView(
            text: _transaction.prospectId, fontFamily: FontFamily.medium)),
        DataCell(DeasyTextView(
            text: _transaction.otr.toString().toRupiah(), fontFamily: FontFamily.medium)),
        DataCell(DeasyTextView(
            text: _transaction.orderDate.toString().toFormattedDate(format: "dd MMM yyyy, HH:mm:ss"), fontFamily: FontFamily.medium)),
        DataCell(
            DeasyTextView(text: _transaction.orderStatus.name, fontFamily: FontFamily.medium)),
        DataCell(SvgPicture.asset(
            "resources/images/icons/ic_new_transaction_flag.svg")),
        DataCell(SvgPicture.asset(
            "resources/images/icons/ic_paid_transaction_flag.svg")),
        DataCell(SvgPicture.asset(
            "resources/images/icons/ic_processed_transaction_flag.svg")),
        DataCell(SvgPicture.asset(
            "resources/images/icons/ic_approved_transaction_flag.svg")),
        DataCell(SvgPicture.asset(
            "resources/images/icons/ic_approved_transaction_flag.svg")),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _totalRecord;

  @override
  int get selectedRowCount => 0;

}