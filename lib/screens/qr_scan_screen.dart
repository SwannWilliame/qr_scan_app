import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scan_app/components/default_appbar.dart';
import 'package:qr_scan_app/database/database_managment.dart';
import 'package:qr_scan_app/screens/scan_result_screen.dart';
import 'package:qr_scan_app/utils/launch_url.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({super.key});

  @override
  State<QRScanScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  Barcode? lastBarcode;

  SnackBar errorSnackbar = const SnackBar(content: Text("The QR Codes need to be linked to a website"));

  @override
  void dispose() {
    controller?.dispose(); 
    super.dispose();
  }

  @override
  void reassemble() async{
    super.reassemble();

    if(Platform.isAndroid){
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar("QR Code Scanner"),
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
        ],
      ),
    );
  }

  Widget buildQrView(BuildContext context)=>QRView(
    key: qrKey, 
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      cutOutSize: MediaQuery.of(context).size.width*0.8,
      borderWidth: 10,
      borderRadius: 10,
      borderColor: Colors.grey
    ),
  );

  void onQRViewCreated(QRViewController controller){
    setState(() {
      this.controller=controller;
    });

    controller.scannedDataStream.listen(
      (barcode) async{
        setState(() {
          this.barcode=barcode;
        });
        if(mounted){
          if(barcode.code!.startsWith("http") && lastBarcode?.code != barcode.code!){
            appLaunchURL(barcode.code!);
            setState(() {
              lastBarcode=barcode;
            });
          }
          else if(lastBarcode == null || lastBarcode?.code != barcode.code!){
            setState(() {
              lastBarcode=barcode;
            });
            ScaffoldMessenger.of(context).showSnackBar(errorSnackbar);
          }
        }
      
      }
    );
  }
}