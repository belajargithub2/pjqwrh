import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:itruzz_plugin/itruzz_plugin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _platformVersion = 'Unknown';
  String _ikid = 'Unknown';
  final _itruzzPlugin = ItruzzPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _itruzzPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  // Future<void> getIkid() async {
  //   String ikid;
  //   try {
  //     ikid = await _itruzzPlugin.getIkid() ??
  //         'Unknown ikid';
  //   } on PlatformException {
  //     ikid = 'Failed to get platform version.';
  //   }
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _ikid = ikid;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Running on: $_platformVersion'),
          Text('Ikid: $_ikid'),
          ElevatedButton(
            onPressed: () async {
              await Navigator.pushNamed(context, '/consume-api');
            },
            child: const Text('Go to API screen'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('IKID'),
          ),
        ],
      ),
    );
  }
}
