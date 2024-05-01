import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  late QRViewController _controller;
  String scannedData = 'Scan a QR code';

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xffF4F5F8),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Center(
              child: Text('Qr 코드 용지를 사각 안에 맞혀 스캔해 주세요'),
              // child: (result != null)
              //     ? Text(
              //         'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
              //     : const Text('Qr 코드 용지를 사각 안에 맞혀 스캔해 주세요'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (result == null) {
        setState(() {
          result = scanData;
        });
        _launchURL(scanData.code);
      }
    });
  }
}

Future _launchURL(String? url) async {
  if (url != null && await canLaunch(url)) {
    await launch(url);
  }
}
