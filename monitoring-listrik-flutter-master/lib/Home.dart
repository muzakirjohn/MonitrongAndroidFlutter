import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monitoring/widgets/Headline.dart';
import 'package:monitoring/widgets/CardChart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:monitoring/widgets/Card.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:monitoring/Components/Header.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:monitoring/Pages/DashboardPage.dart';
import 'package:monitoring/Pages/ProfilePage.dart';
import 'package:monitoring/Pages/FuzyPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  int _selectedNavbar = 0;

  final widgetOptions = [
    new DashboardPage(),
    new FuzzyPageAnlysis(),
    new ProfilePage(),
  ];

  // make handle route with active route index
  void _handleNavbar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: widgetOptions.elementAt(_selectedNavbar),
        ),
      )),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.assessment, size: 30),
          Icon(Icons.person_sharp, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(238, 238, 238, 1),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          //Handle button tap
          _handleNavbar(index);

          // setState(() {
          //   _page = index;
          // });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
