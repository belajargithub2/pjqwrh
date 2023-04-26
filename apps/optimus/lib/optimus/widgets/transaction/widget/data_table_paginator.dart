import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:deasy_color/deasy_color.dart';

class DataTablePaginator extends StatefulWidget {
  final int? currentPage;
  final int? lastPage;
  final int? firstIndex;
  final int? lastIndex;
  final int? totalRecord;
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
    DeasySizeConfigUtils().init(context: context);
    return Container(
      width: DeasySizeConfigUtils.screenWidth,
      child: DeasySizeConfigUtils.isMobile
          ? Container(
              height: DeasySizeConfigUtils.screenHeight! * 0.10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DeasyTextView(
                      text:
                          "Showing ${widget.firstIndex} to ${widget.lastIndex} entries",
                      fontSize: 12),
                  Expanded(
                    child: Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: DeasyColor.semanticInfo300,
                                  size: 10,
                                ),
                                onPressed: () {
                                  widget.onBackClick();
                                }),
                            buttonPage(firstPage),
                            buttonPage(secondPage),
                            buttonPage(thirdPage),
                            buttonPage(fourthPage),
                            widget.lastPage! > 7 &&
                                    widget.currentPage! + 1 != widget.lastPage
                                ? Text(" ... ")
                                : SizedBox(),
                            widget.lastPage! > 7 &&
                                    widget.currentPage! + 1 != widget.lastPage
                                ? buttonPage(widget.lastPage)
                                : SizedBox(),
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: DeasyColor.semanticInfo300,
                                  size: 10,
                                ),
                                onPressed: () {
                                  widget.onForwardClick();
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Row(
              children: [
                DeasyTextView(
                    text:
                        "Showing ${widget.firstIndex} to ${widget.lastIndex} entries",
                    fontSize: 12),
                Spacer(),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: DeasyColor.semanticInfo300,
                            size: 10,
                          ),
                          onPressed: () {
                            widget.onBackClick();
                          }),
                      buttonPage(firstPage),
                      buttonPage(secondPage),
                      buttonPage(thirdPage),
                      buttonPage(fourthPage),
                      widget.lastPage! > 7 &&
                              widget.currentPage! + 1 != widget.lastPage
                          ? Text(" ... ")
                          : SizedBox(),
                      widget.lastPage! > 7 &&
                              widget.currentPage! + 1 != widget.lastPage
                          ? buttonPage(widget.lastPage)
                          : SizedBox(),
                      IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: DeasyColor.semanticInfo300,
                            size: 10,
                          ),
                          onPressed: () {
                            widget.onForwardClick();
                          })
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  buttonPage(int? page) {
    if (page == widget.currentPage) {
      return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
            side: BorderSide(width: 1, color: DeasyColor.semanticInfo300)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: DeasyTextView(
              text: "${page.toString()}",
              fontSize: 12,
              fontColor: DeasyColor.semanticInfo300),
        ),
      );
    } else if (page! > widget.lastPage!) {
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
