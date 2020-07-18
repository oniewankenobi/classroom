
import 'package:classroom/ScannerPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ClassPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Classes"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScannerPage()
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: <Widget>[
          _buildClassCard(context, "Chemistry"),
          _buildClassCard(context, "Biology"),
        ],
      ),
    );
  }

  Widget _buildClassCard(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClassPage(title)
          ),
        );
      },
      child: Card(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Text(title),
        ),
      ),
    );
  }
}