import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'ARPage.dart';

class ClassPage extends StatelessWidget {
  final String title;
  final int nPolys = 3;
  final List<String> topics = ["1", "2", "3", "4"];
  final List<Icon> icons = [
    Icon(Icons.cake),
    Icon(Icons.battery_full),
    Icon(Icons.color_lens),
    Icon(Icons.access_alarm)
  ];

  ClassPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _buildClassPage(),
    );
  }

  Widget _buildClassPage() {
    return Container(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 20,
        ),
        itemCount: nPolys,
        itemBuilder: (BuildContext context, int index) => _buildPolyItem(context, index),
      ),
    );
  }

  Widget _buildPolyItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ARPage()
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(60,0,60,0),
        child: Column(
          children: <Widget>[Text(topics[index]), icons[index]]
        ),
      ),
    );
  }
  
}