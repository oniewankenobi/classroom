import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ARPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AR Page"),
      ),
      body: Center(
        child: Text("AR PAGE"),
      ),
    );
  }
}