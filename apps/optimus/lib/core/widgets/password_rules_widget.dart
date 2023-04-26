import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordRulesWidget extends GetView {
  final int number = 1;
  final int content = 20;

  const PasswordRulesWidget({Key? key, int? number, int? content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ketentuan : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: number, child: Container(child: Text('1. '))),
              Expanded(
                  flex: content,
                  child: Container(
                      child: Text('Kata Sandi tidak mengandung kata "Finansia'))),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: number, child: Container(child: Text('2.'))),
              Expanded(
                  flex: content,
                  child: Container(
                      child: Text(
                          'Kata Sandi minimal terdiri dari 6 karakter yang memuat komponen simbol, huruf besar, huruf kecil dan angka.'))),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: number, child: Container(child: Text('3.'))),
              Expanded(
                  flex: content,
                  child: Container(
                      child: Text(
                          'Kata Sandi baru sebaiknya menggunakan Kata Sandi yang belum dipakai sebelumnya. Meskipun demikian, Kata Sandi baru masih dapat menggunakan password yang pernah dipergunakan sebelumnya, dengan contoh sebagai\nberikut :'))),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: number + 1, child: Container(child: Text(''))),
              Expanded(
                  flex: content,
                  child: Container(child: Text('1 Januari 2021 : Pass01!'))),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: number + 1, child: Container(child: Text(''))),
              Expanded(
                  flex: content,
                  child: Container(child: Text('1 April 2021 : Pass02!'))),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: number + 1, child: Container(child: Text(''))),
              Expanded(
                  flex: content,
                  child: Container(child: Text('1 Juli 2021 : Pass01!'))),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: number, child: Container(child: Text(''))),
              Expanded(
                  flex: content,
                  child: Container(
                      child: Text(
                          '(Kata Sandi bulan Januari 2021 dapat digunakan kembali pada bulan Juli 2021)'))),
            ],
          ),
        ],
      ),
    );
  }
}
