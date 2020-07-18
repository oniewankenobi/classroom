import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'ARPage.dart';
import 'ARPage.dart';

class ClassPage extends StatelessWidget {
  final String title;
  final int nPolys = 4;
  final List<String> topics = [
    "The Chemistry of Cake",
    "Cathodes and Anodes",
    "Nanopaint",
    "Time",
  ];
  final List<Icon> icons = [
    Icon(
      Icons.cake,
      color: Colors.orange,
      size: 40,
    ),
    Icon(
      Icons.battery_full,
      color: Color.fromRGBO(102, 210, 210, 1),
      size: 40,
    ),
    Icon(
      Icons.color_lens,
      color: Color.fromRGBO(184, 125, 200, 1),
      size: 40,
    ),
    Icon(
      Icons.access_alarm,
      color: Color.fromRGBO(255, 87, 87, 1),
      size: 40,
    ),
  ];

  ClassPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: _buildClassPage(context),
    );
  }

  Widget _buildClassPage(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: Column(
        children: <Widget>[
          _buildTitle(context),
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) => _buildPolyItem(context, index),
              separatorBuilder: (BuildContext context, int index) => SizedBox(height: 5),
              itemCount: nPolys,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          "images/chem-removebg-preview.png",
          height: 200,
          width: 300,
          fit: BoxFit.contain,
          alignment: Alignment.centerRight,
        ),
        SizedBox(height: 30),
        Text(
          "CHEMISTRY",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Divider(
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _buildPolyItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ARPage(),
          ),
        );
      },
      child: Card(
        elevation: 3,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 100,
          padding: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              icons[index],
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    topics[index],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Lorem Ipsum Dolor",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}