import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DataTablePaginator extends StatefulWidget {
  final int currentPage;
  final int lastPage;
  final int firstIndex;
  final int lastIndex;
  final int totalRecord;
  final Function onBackClick;
  final Function onForwardClick;
  final Function onPageClick;

  const DataTablePaginator(
      {Key? key,
      required this.firstIndex,
      required this.lastIndex,
      required this.totalRecord,
      required this.onBackClick,
      required this.onForwardClick,
      required this.onPageClick,
      required this.currentPage,
      required this.lastPage})
      : super(key: key);

  @override
  _DataTablePaginatorState createState() => _DataTablePaginatorState();
}

class _DataTablePaginatorState extends State<DataTablePaginator> {
  int? currentPage;
  int? firstPage = 1;
  int secondPage = 2;
  int thirdPage = 3;
  int fourthPage = 4;

  @override
  void initState() {
    currentPage = widget.currentPage;
    int diff = currentPage! - 4;
    if (diff == 0) {
      firstPage = 4;
      secondPage = 5;
      thirdPage = 6;
      fourthPage = 7;
    } else if (diff > 0 && diff % 3 == 0) {
      firstPage = currentPage;
      secondPage = firstPage! + 1;
      thirdPage = secondPage + 1;
      fourthPage = thirdPage + 1;
    } else if ((currentPage! - 2) % 3 == 0) {
      firstPage = currentPage! - 1;
      secondPage = firstPage! + 1;
      thirdPage = secondPage + 1;
      fourthPage = thirdPage + 1;
    } else if ((currentPage! - 6) % 3 == 0) {
      firstPage = currentPage! - 2;
      secondPage = firstPage! + 1;
      thirdPage = secondPage + 1;
      fourthPage = thirdPage + 1;
    } else if (currentPage == widget.lastPage) {
      firstPage = currentPage! - 3;
      secondPage = firstPage! + 1;
      thirdPage = secondPage + 1;
      fourthPage = thirdPage + 1;
    }
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.yellow,
        width: 100,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DeasyTextView(
                  text:
                      "Menampilkan ${widget.firstIndex} - ${widget.lastIndex} dari ${widget.totalRecord} entri",
                  fontSize: 12),
              SizedBox(width: 20),
              Card(
                color: Colors.white,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: HexColor("#01A3DE"),
                        size: 10,
                      ),
                      onPressed: () {
                        widget.onBackClick();
                      }
                    ),
                    buttonPage(firstPage),
                    buttonPage(secondPage),
                    buttonPage(thirdPage),
                    buttonPage(fourthPage),
                    widget.lastPage > 7 && widget.currentPage + 1 != widget.lastPage ?
                      Text(" ... ") : SizedBox(),
                    widget.lastPage > 7 && widget.currentPage + 1 != widget.lastPage ?
                      buttonPage(widget.lastPage) : SizedBox(),
                    IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: HexColor("#01A3DE"),
                          size: 10,
                        ),
                        onPressed: () {
                          widget.onForwardClick();
                        })
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  buttonPage(int? page) {
    if (page == widget.currentPage) {
      return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
          side: BorderSide(
            width: 1, color: HexColor("#01A3DE")
          )
        ),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: DeasyTextView(
            text: "${page.toString()}",
            fontSize: 12,
            fontColor: HexColor("#01A3DE")
          ),
        ),
      );
    } else if (page! > widget.lastPage) {
      return SizedBox();
    } else if (widget.lastPage == 1) {
      return SizedBox();
    } else {
      return InkWell(
        child: Text(" ${page.toString()} "),
        onTap: () {
          widget.onPageClick(page);
        },
      );
    }
  }
}
