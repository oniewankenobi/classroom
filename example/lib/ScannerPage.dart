import 'package:arkit_plugin_example/custom_object_page.dart';
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

  Future _scanQR() async {
//    try {
      ScanResult qrResult = await BarcodeScanner.scan();
      if (qrResult.rawContent != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CustomObjectPage(),
          ),
        );
      }
//      setState(() {
//
//        qrResult.rawContent;
//      });
//    } on PlatformException catch(ex) {
//
//    } on FormatException catch(ex) {
//      setState(() {
//        result = "Back button pressed";
//      });
//    } catch (ex) {
//      setState(() {
//        result = "Unknown error: $ex";
//      });
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(84, 84, 84, 1),
        title: Text("Camera"),
      ),
      body: Center(
          child: RaisedButton(
            onPressed: () => _scanQR(),
            padding: EdgeInsets.all(40),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Container(
              width: 170,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 50,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Scan",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}