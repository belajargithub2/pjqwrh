import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../bloc/setting/setting_bloc.dart';
import '../util/hex_color.dart';
import 'termcondition_screen.dart';

class DailyCheckInScreen extends StatefulWidget {
  final Map<String, String>? queryParameters;
  const DailyCheckInScreen({Key? key, required this.queryParameters})
      : super(key: key);

  static const routeName = '/dailycheckin';

  @override
  State<DailyCheckInScreen> createState() => _DailyCheckInScreenState();
}

class _DailyCheckInScreenState extends State<DailyCheckInScreen> {
  final SettingBloc _settingBloc = SettingBloc();
  bool isChecked = false;

  @override
  void initState() {
    String baseUrl = widget.queryParameters?['base_url'] ?? '';
    String deviceCode = widget.queryParameters?['device_code'] ?? '';
    _settingBloc.add(GetSetting(baseUrl: baseUrl, deviceCode: deviceCode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Daily Check-In",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: HexColor.statusBarColor,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => SystemNavigator.pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: HexColor('#F7F7F7'),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/img/img_banner_daily_checkin.png',
                      fit: BoxFit.fitWidth,
                    )),
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Flexible(
                          flex: 1,
                          child: Container(
                            height: 100,
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: 100,
                            child: Column(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      isChecked
                                          ? 'assets/img/img_bullet_yellow.png'
                                          : 'assets/img/img_bullet_grey.png',
                                      fit: BoxFit.fitWidth,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Hari ke-1',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: isChecked
                                            ? Colors.black
                                            : HexColor('#ACACAC')),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: 100,
                            child: Column(
                              children: [
                                Divider(
                                  height: 28,
                                  thickness: 2,
                                  indent: 0,
                                  endIndent: 0,
                                  color: HexColor('#D1D1D1'),
                                ),
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: 100,
                            child: Column(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      'assets/img/img_bullet_grey.png',
                                      fit: BoxFit.fitWidth,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Hari ke-2',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: HexColor('#ACACAC')),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: 100,
                            child: Column(
                              children: [
                                Divider(
                                  height: 28,
                                  thickness: 2,
                                  indent: 0,
                                  endIndent: 0,
                                  color: HexColor('#D1D1D1'),
                                ),
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: 100,
                            child: Column(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      'assets/img/img_bullet_grey.png',
                                      fit: BoxFit.fitWidth,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Hari ke-3',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: HexColor('#ACACAC')),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: 100,
                            child: Column(
                              children: [
                                Divider(
                                  height: 28,
                                  thickness: 2,
                                  indent: 0,
                                  endIndent: 0,
                                  color: HexColor('#D1D1D1'),
                                ),
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: 100,
                            child: Column(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      'assets/img/img_bullet_grey.png',
                                      fit: BoxFit.fitWidth,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Hari ke-4',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: HexColor('#ACACAC')),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: 100,
                            child: Column(
                              children: [
                                Divider(
                                  height: 28,
                                  thickness: 2,
                                  indent: 0,
                                  endIndent: 0,
                                  color: HexColor('#D1D1D1'),
                                ),
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: 100,
                            child: Column(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      'assets/img/img_bullet_grey.png',
                                      fit: BoxFit.fitWidth,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Hari ke-5',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: HexColor('#ACACAC')),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: 100,
                            child: Column(
                              children: [
                                Divider(
                                  height: 28,
                                  thickness: 2,
                                  indent: 0,
                                  endIndent: 0,
                                  color: HexColor('#D1D1D1'),
                                ),
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: 100,
                            child: Column(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      'assets/img/img_bullet_grey.png',
                                      fit: BoxFit.fitWidth,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Hari ke-6',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: HexColor('#ACACAC')),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: 100,
                            child: Column(
                              children: [
                                Divider(
                                  height: 28,
                                  thickness: 2,
                                  indent: 0,
                                  endIndent: 0,
                                  color: HexColor('#D1D1D1'),
                                ),
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: 100,
                            child: Column(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.asset(
                                      'assets/img/img_bullet_grey_finish.png',
                                      fit: BoxFit.fitWidth,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Hari ke-7',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: HexColor('#ACACAC')),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                            height: 100,
                          )),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Check-in Tiap Hari',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Check-in setiap hari dan dapatkan 500 kpoin + voucher atau hadiah menarik lainnya di hari ke-7!',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: HexColor('#ACACAC')),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Untuk mengetahui cara mengikuti Daily Check-in,',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: HexColor('#ACACAC')),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, TermConditionScreen.routeName);
                        },
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft),
                        child: Text(
                          'klik di sini.',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: HexColor('#FFBC00')),
                        ),
                      ),
                    ],
                  ),
                ),
                isChecked
                    ? Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(16),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Layanan Kreditplus',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40))))),
                                onPressed: () {},
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Image.asset(
                                              'assets/img/img_icon_pdt.png')),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: const Text(
                                            'Pinjaman Dana Tunai',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Image.asset(
                                              'assets/img/img_icon_arrow.png',
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40))))),
                                onPressed: () {},
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Image.asset(
                                              'assets/img/img_icon_marketplace.png')),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: const Text(
                                            'Kredit Barang DP 0%',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Image.asset(
                                              'assets/img/img_icon_arrow.png',
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
                Container(
                  color: HexColor('#F7F7F7'),
                  height: 108,
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(HexColor('#FFBC00')),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))))),
              onPressed: () {
                setState(() {
                  isChecked = true;
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  'Check-in Sekarang',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
