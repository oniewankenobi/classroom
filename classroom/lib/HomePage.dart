
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
      body: Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 30,
          right: 30,
        ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              Text(
                "Hello,",
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Chris Tine",
                style: TextStyle(
                  fontSize: 50,
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
        selectedItemColor: Colors.amber[800],
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
          "Science",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              _buildClassCard(
                context,
                "Chemistry",
                Icon(
                  Icons.bubble_chart,
                  color: Colors.green,
                  size: 70,
                ),
              ),
              SizedBox(width: 10),
              _buildClassCard(
                context,
                "Biology",
                Icon(
                  Icons.school,
                  color: Colors.blue,
                  size: 70,
                ),
              ),
              SizedBox(width: 10),
              _buildClassCard(
                context,
                "Physics",
                Icon(
                  Icons.smartphone,
                  color: Colors.red,
                  size: 70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClassCard(BuildContext context, String title, Icon icon) {
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
        width: 150,
        height: 150,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          semanticContainer: true,
          color: Colors.white.withOpacity(0.8),
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