import 'dart:typed_data';

import 'package:ecomatesg/Icons/change_color.dart';
import 'package:ecomatesg/scan_qr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({Key? key}) : super(key: key);

  @override
  State<ScanQRPage> createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  static const textColour = Color.fromARGB(255, 44, 82, 105);
  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


@override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home Page',
        color: Colors.teaGreen,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('EcoMateSG',
                style: TextStyle(color: textColour,
                    fontFamily: 'NotoSans')),
            backgroundColor: Colors.cornsilk,
          ),
          body: buildContent(),
        ));
  }

  Widget buildContent() {
    return Container(
      color: Colors.teaGreen,
      child: Padding(
        padding: EdgeInsets.all(deviceWidth(context) * 0.1),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: deviceHeight(context) * 0.05,
                bottom: deviceHeight(context) * 0.03,
              ),
              child: const Text(
                'Scan QR Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  color: textColour,
                  fontFamily: 'NotoSans',
                ),
              ),
            ),

            // Scanner
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black),
              ),
              height: deviceHeight(context) * 0.4,
              width: deviceHeight(context) * 0.4,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),

            // Upload QR code

            // Go back button
            Container(
              width: deviceWidth(context) * 0.4,
              padding: EdgeInsets.only(top: deviceHeight(context) * 0.05),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: textColour,
                ),
                child: const Text(
                  'Return Home',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NotoSans',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
