import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';

class ListDropdown extends StatelessWidget {
  final List<String> list;
  final Function onChanged;
  const ListDropdown({Key? key, required this.list, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: DeasyColor.neutral000,
      elevation: 2.0,
      child: Container(
        width: 100.w,
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => onChanged(list[index]),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(list[index]),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
