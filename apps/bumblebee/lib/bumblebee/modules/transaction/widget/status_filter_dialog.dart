import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/widget/order_status_slug.dart';

class StatusFilterDialog extends StatefulWidget {
  final OrderStatusSlug activeStatus;
  final Function onStatusItemClicked;

  const StatusFilterDialog(
      {Key? key,
      required this.activeStatus,
      required this.onStatusItemClicked})
      : super(key: key);

  @override
  _StatusFilterDialogState createState() => _StatusFilterDialogState();
}

class _StatusFilterDialogState extends State<StatusFilterDialog> {
  List<OrderStatusSlug> status1 = [
    OrderStatusSlug(1, "Dikonfirmasi", "Purchase Confirmed"),
    OrderStatusSlug(2, "Disetujui", "Approved"),
    OrderStatusSlug(3, "Ditolak", "Rejected")
  ];
  List<OrderStatusSlug> status2 = [
    OrderStatusSlug(4, "Pengajuan Pembatalan", "Cancel Request"),
    OrderStatusSlug(5, "Dibayar", "Disbursed"),
    OrderStatusSlug(6, "Diproses", "On Progress"),
  ];
  List<OrderStatusSlug> status3 = [
    OrderStatusSlug(7, "Dibatalkan", "Canceled")
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 102,
        child: Card(
          elevation: 5,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            width: 380,
            height: 200,
            child: Column(
              children: [
                Row(
                  children: status1.map((status) {
                    return TextButton(
                      onPressed: () {
                        widget.onStatusItemClicked(status);
                      },
                      child: Card(
                        color: widget.activeStatus.id == status.id
                            ? HexColor("#FFBC00")
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 42,
                          child: Center(
                            child: DeasyTextView(
                                text: status.name,
                                fontColor: widget.activeStatus.id == status.id
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  children: status2.map((status) {
                    return TextButton(
                      onPressed: () {
                        widget.onStatusItemClicked(status);
                      },
                      child: Card(
                        color: widget.activeStatus.id == status.id
                            ? HexColor("#FFBC00")
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 42,
                          child: Center(
                            child: DeasyTextView(
                                text: status.name,
                                fontColor: widget.activeStatus.id == status.id
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  children: status3.map((status) {
                    return TextButton(
                      onPressed: () {
                        widget.onStatusItemClicked(status);
                      },
                      child: Card(
                        color: widget.activeStatus.id == status.id
                            ? HexColor("#FFBC00")
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 42,
                          child: Center(
                            child: DeasyTextView(
                                text: status.name,
                                fontColor: widget.activeStatus.id == status.id
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ));
  }
}
