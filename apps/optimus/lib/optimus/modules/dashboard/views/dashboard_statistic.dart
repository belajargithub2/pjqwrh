import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/statistic_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/views/dashboard_bar_chart.dart';

class DashboardStatistic extends GetView<StatisticController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ringkasan statistik minggu ini',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 8.0),
            Text(
              'Bagan ini menunjuk statistik transaksi yang kamu lakukan sesuai dengan bulan yang kamu pilih.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 20.0),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: HexColor('#E3E3E3'),
                                      style: BorderStyle.solid,
                                      width: 0.80),
                                ),
                                child: Obx(
                                  () => DropdownButton<String>(
                                      style: TextStyle(color: Colors.black),
                                      underline: SizedBox(),
                                      icon: Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: Colors.black),
                                      onChanged: (String? newValue) {
                                        controller.setMonth(
                                          newValue!,
                                        );
                                      },
                                      items: controller.listMonth
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      isExpanded: true,
                                      value: controller.selectedMonthX.value),
                                )),
                            Expanded(child: BarChart())
                          ],
                        )),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Card(
                          elevation: 2,
                          margin: EdgeInsets.zero,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          controller.getGridImagePath('Baru')),
                                      SizedBox(width: 8.0),
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            'Baru',
                                            style: TextStyle(
                                                color: controller
                                                    .getGridItemColor('Baru'),
                                                fontSize: 14.0,
                                                height: 1.4,
                                                fontFamily:
                                                    'KBFGDisplayMedium'),
                                            overflow: TextOverflow.fade,
                                            maxLines: 1,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Text('0',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          height: 1.4,
                                          fontFamily: 'KBFGDisplayMedium')),
                                  Row(
                                    children: [
                                      Text(
                                        '0%',
                                        style: TextStyle(
                                            color: HexColor('#2ED477'),
                                            fontSize: 12.0,
                                            height: 1.4,
                                            fontFamily: 'KBFGDisplayMedium'),
                                      ),
                                      SizedBox(width: 8.0),
                                      Expanded(
                                          child: Container(
                                        child: Text(
                                          'dari minggu lalu',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                              height: 1.4,
                                              fontFamily: 'KBFGDisplayMedium'),
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ),
                                      ))
                                    ],
                                  )
                                ],
                              )),
                        ),
                        SizedBox(height: 20.0),
                        Card(
                          elevation: 2,
                          margin: EdgeInsets.zero,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(controller
                                          .getGridImagePath('Dibayar')),
                                      SizedBox(width: 8.0),
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            'Dibayar',
                                            style: TextStyle(
                                                color:
                                                    controller.getGridItemColor(
                                                        'Dibayar'),
                                                fontSize: 14.0,
                                                height: 1.4,
                                                fontFamily:
                                                    'KBFGDisplayMedium'),
                                            overflow: TextOverflow.fade,
                                            maxLines: 1,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Text('0',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          height: 1.4,
                                          fontFamily: 'KBFGDisplayMedium')),
                                  Row(
                                    children: [
                                      Text('0%',
                                          style: TextStyle(
                                              color: HexColor('#2ED477'),
                                              fontSize: 12.0,
                                              height: 1.4,
                                              fontFamily: 'KBFGDisplayMedium')),
                                      SizedBox(width: 8.0),
                                      Expanded(
                                          child: Container(
                                        child: Text(
                                          'dari minggu lalu',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                              height: 1.4,
                                              fontFamily: 'KBFGDisplayMedium'),
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                        ),
                                      ))
                                    ],
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
