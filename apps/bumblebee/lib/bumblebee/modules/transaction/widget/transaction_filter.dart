import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/text_field.dart';

import 'order_status_slug.dart';

class TransactionFilter extends StatefulWidget {
  final Function onSearchSubmitted;
  final Function onStatusFilterClicked;
  final Function onDateFilterClicked;
  final Function onDownloadClicked;
  final OrderStatusSlug activeStatus;
  final String activeSearch;

  const TransactionFilter(
      {Key? key,
      required this.onSearchSubmitted,
      required this.onStatusFilterClicked,
      required this.activeStatus,
      required this.activeSearch,
      required this.onDateFilterClicked,
      required this.onDownloadClicked})
      : super(key: key);

  @override
  _TransactionFilterState createState() => _TransactionFilterState();
}

class _TransactionFilterState extends State<TransactionFilter> {
  TextEditingController? _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    if (widget.activeSearch != null) {
      _searchController!.text = widget.activeSearch;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: HexColor("#F7F7F7"),
          child: OutlinedTextField(
            labelText: null,
            hintText: "Cari",
            controller: _searchController,
            obscureText: false,
            readOnly: false,
            textInputType: TextInputType.text,
            actionKeyboard: TextInputAction.next,
            suffixIcon: Icon(
              Icons.search,
              color: HexColor("#ACACAC"),
            ),
            onSubmitField: () {
              widget.onSearchSubmitted(_searchController!.text);
            },
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    widget.onStatusFilterClicked();
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Container(
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          DeasyTextView(
                              text: widget.activeStatus.name,
                              fontFamily: FontFamily.medium,
                              fontSize: 14),
                          SizedBox(width: 10),
                          Icon(Icons.keyboard_arrow_down_outlined,
                              color: Colors.black),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onDateFilterClicked();
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Container(
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          DeasyTextView(
                              text: "Tanggal",
                              fontFamily: FontFamily.medium,
                              fontSize: 14),
                          SizedBox(width: 10),
                          Icon(Icons.date_range, color: Colors.black),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onDownloadClicked();
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Container(
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          DeasyTextView(
                              text: "Download",
                              fontFamily: FontFamily.medium,
                              fontSize: 14),
                          SizedBox(width: 10),
                          Icon(Icons.cloud_download_outlined, color: Colors.black),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          )
        )
      ],
    );
  }
}
