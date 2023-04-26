import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
    return Positioned(
        top: 40,
        right: 0,
        child: Wrap(
          spacing: 12,
          runSpacing: 20,
          children: [
            Container(
              width: 269,
              color: HexColor("#F7F7F7"),
              child: DeasyTextForm.outlinedTextForm(
                labelText: null,
                hintText: "Cari",
                controller: _searchController,
                obscure: false,
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
              width: 140,
              child: TextButton(
                onPressed: () {
                  widget.onStatusFilterClicked();
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DeasyTextView(
                            text: widget.activeStatus.name,
                            fontFamily: FontFamily.medium,
                            fontSize: 14),
                        Icon(Icons.keyboard_arrow_down_outlined,
                            color: Colors.black)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 140,
              child: TextButton(
                onPressed: () {
                  widget.onDateFilterClicked();
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DeasyTextView(
                            text: "Tanggal",
                            fontFamily: FontFamily.medium,
                            fontSize: 14),
                        SizedBox(width: 8),
                        Icon(Icons.date_range, color: Colors.black)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 140,
              child: TextButton(
                onPressed: () {
                  widget.onDownloadClicked();
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DeasyTextView(
                            text: "Download",
                            fontFamily: FontFamily.medium,
                            fontSize: 14),
                        SizedBox(width: 8),
                        Icon(Icons.cloud_download_outlined, color: Colors.black)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
