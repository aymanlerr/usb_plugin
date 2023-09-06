import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:usb_plugin/usb_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _usbState = -1;
  final _usbPlugin = UsbPlugin();

  @override
  void initState() {
    super.initState();
    initUsbState();
  }

  Future<void> initUsbState() async {
    int usbState = -1;
    try {
      usbState = await _usbPlugin.checkUsbState() ?? -1;
    } on PlatformException {
      usbState = -1;
    }

    if (!mounted) return;
    setState(() {
      _usbState = usbState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("State usb init: $_usbState"),
            const SizedBox(
              height: 30,
            ),
            StreamBuilder<int>(
              initialData: -1,
              stream: _usbPlugin.stateUsbStream(),
              builder: (context, snapshot) {
                return Text("State usb: ${snapshot.data}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
