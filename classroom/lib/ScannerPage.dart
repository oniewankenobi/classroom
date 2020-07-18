import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class ScannerPage extends StatefulWidget {
  @override
  ScannerPageState createState() {
    return new ScannerPageState();
  }
}

class ScannerPageState extends State<ScannerPage> {
  String result = "Hello";

  Future _scanQR() async {
    try {
      ScanResult qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult.rawContent;
      });
    } on PlatformException catch(ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Camera permission denied";
        });
      } else {
        setState(() {
          result = "Unknown error: $ex";
        });
      }
    } on FormatException catch(ex) {
      setState(() {
        result = "Back button pressed";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown error: $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera"),
      ),
      body: Center(
        child: Text(
            result,
            style: new TextStyle(fontSize: 30.0)
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.camera_alt),
          onPressed: _scanQR,
          label: Text("Scan")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}