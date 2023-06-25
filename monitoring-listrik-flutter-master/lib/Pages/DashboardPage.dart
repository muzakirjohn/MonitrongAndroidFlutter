import 'dart:async' show Stream;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monitoring/models/Monitoring.dart';

import 'package:monitoring/widgets/CardChart.dart';
import 'package:monitoring/widgets/Card.dart';
import 'package:monitoring/widgets/Spedometer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:monitoring/Components/Header.dart';
import 'package:monitoring/widgets/Headline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  bool _showDate = false;
  String _timeString = '00:00:00';
  String dropdownValue = '1';

  @override
  void initState() {
    super.initState();
  }

  // make stream data for realtime data power firestoer
  final Stream<QuerySnapshot> _streamData = FirebaseFirestore.instance
      .collection('DataBase3Jalur')
      .orderBy('TimeStamp', descending: true)
      .limit(1)
      .snapshots();

  // make controller for datepicker

  TextEditingController dateController = TextEditingController();

  List<Map<String, dynamic>> send = [
    {
      "name": "Alat 1",
      "value": "1",
    },
    {
      "name": "Alat 2",
      "value": "2",
    },
    {
      "name": "Alat 3",
      "value": "3",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: CardChart(
      //       // chartData:
      //       //     snapshot.data!.docs.map((DocumentSnapshot document) {
      //       //           Map<String, dynamic> data =
      //       //               document.data()! as Map<String, dynamic>;
      //       //           return Monitoring.fromJson(data);
      //       //         })?.toList() ??
      //       //         []);
      //       chartData: [])
      child: Column(
        children: [
          DropdownButton<String>(
            // Step 3.
            value: dropdownValue,
            // Step 4.
            items: send
                .map<DropdownMenuItem<String>>((Map<String, dynamic> value) {
              return DropdownMenuItem<String>(
                value: value['value'],
                child: Text(
                  value['name'],
                  style: TextStyle(fontSize: 30),
                ),
              );
            }).toList(),
            // Step 5.
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
          ),
          const SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
              stream: _streamData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print("logger snapshot " +
                      snapshot.data!.docs[0].data().toString());
                  return SpedoMeter(
                      fuzy:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                return data;
                              })?.toList() ??
                              [],
                      typeString: dropdownValue);
                  // chartData: []);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
  // const SizedBox(height: 20),
  // Headline(
  //   title: 'Energy',
  //   caption: 'Ini adalah chart untuk realtime data power',
  // ),
  // const SizedBox(height: 20),
  // CardChart(),
  // const SizedBox(height: 20),
  // Headline(
  //   title: 'PF',
  //   caption: 'Ini adalah chart untuk realtime data power',
  // ),
  // const SizedBox(height: 20),
  // CardChart(),
  // const SizedBox(height: 20),
}
