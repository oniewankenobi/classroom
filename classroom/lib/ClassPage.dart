
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ARPage.dart';

class ClassPage extends StatelessWidget {
  final String title;
  final int nPolys = 3;

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
        separatorBuilder: (BuildContext context, int index) => Divider(),
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
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Text("item $index"),
        ),
      ),
    );
  }
  
}