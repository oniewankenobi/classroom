
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
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        child: IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 70,
          left: 30,
          right: 30,
        ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              Text(
                "Hello,",
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Chris Tine",
                style: TextStyle(
                  color: Color.fromRGBO(255, 87, 87, 1),
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              _buildScienceSection(context),
            ],
          ),
        ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(84, 84, 84, 1),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildScienceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          " My Classes",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        Row(
          children: <Widget>[
            _buildClassCard(
              context,
              "Chemistry",
              Icon(
                Icons.bubble_chart,
                color: Colors.white,
                size: 70,
              ),
              Color.fromRGBO(102, 210, 210, 1),
            ),
            SizedBox(width: 20),
            _buildClassCard(
              context,
              "Biology",
              Icon(
                Icons.school,
                color: Colors.white,
                size: 70,
              ),
              Color.fromRGBO(184, 125, 200, 1)
            ),
            SizedBox(width: 10),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: <Widget>[
            _buildClassCard(
              context,
              "Physics",
              Icon(
                Icons.smartphone,
                color: Colors.white,
                size: 70,
              ),
              Color.fromRGBO(255, 87, 87, 1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildClassCard(BuildContext context, String title, Icon icon, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClassPage(title)
          ),
        );
      },
      child: Container(
        width: 160,
        height: 160,
        child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          semanticContainer: true,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                icon,
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}