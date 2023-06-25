import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:monitoring/models/Fuzzy.dart';
import 'package:monitoring/widgets/Card.dart';
import 'package:monitoring/widgets/Headline.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monitoring/widgets/ChartSingle.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FuzzyPageAnlysis extends StatefulWidget {
  const FuzzyPageAnlysis({super.key});

  @override
  State<FuzzyPageAnlysis> createState() => _FuzzyPageAnlysisState();
}

class _FuzzyPageAnlysisState extends State<FuzzyPageAnlysis> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  String start = '';
  String end = '';
  bool Show = false;
  DateTime startDate = DateTime.now().subtract(const Duration(days: 4));
  DateTime endDate = DateTime.now().subtract(const Duration(days: 2));
  final TextEditingController dateController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final List<DataRow> list = [];

  Client client = Client();
  Future<Fuzzy> getData(String startdate, enddate) async {
    if (startdate == '' || enddate == '') {
      return Fuzzy.fromJson({});
    }
    EasyLoading.show(status: 'loading...');
    print('send data');
    final SharedPreferences prefs = await _prefs;
    _range = prefs.getString('daya') ?? '900';
    print("startdate=$startdate&enddate=$enddate&daya=$_range");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };
    final response = await client.post(
        Uri.parse("https://web-production-35ec.up.railway.app/fuzzy"),
        body: jsonEncode({
          "start_date": startdate,
          "end_date": enddate,
          "daya": int.parse(_range),
        }),
        headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Berhasil mengambil data dan melakukan analisis');
      Map<String, dynamic> b =
          jsonDecode(response.body) as Map<String, dynamic>;
      return Fuzzy.fromJson(b);
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Gagal mengambil data dan melakukan analisis');
      return Fuzzy.fromJson({});
    }
  }

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('yyyy-MM-dd').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
      dateController.text = _range;
      var startDates = DateFormat('yyyy-MM-dd').format(args.value.startDate);
      var endDates = DateFormat('yyyy-MM-dd')
          .format(args.value.endDate ?? args.value.startDate);
      if (startDates != null && endDates != null) {
        if (startDates != endDates) {
          setState(() {
            startDate = args.value.startDate;
            endDate = args.value.endDate ?? args.value.startDate;
            Show = false;
            start = startDates;
            end = endDates;
          });
          getData(startDates, endDates);
        }
      }
    });

    void getDataFromFirebase() {}

    @override
    void initState() {
      super.initState();
      getDataFromFirebase();
      dateController.text =
          '${DateFormat('yyyy-MM-dd').format(startDate)} to ${DateFormat('yyyy-MM-dd').format(endDate)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Headline(
            title: 'Analysis',
            // caption: 'Ini adalah chart untuk realtime data power',
          ),
          // make pressed button

          const SizedBox(height: 20),
          TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Date',
                hintText: 'Pilih Tanggal',
              ),
              readOnly: true,
              controller: dateController,
              onTap: () => {
                    setState(() {
                      Show = !Show;
                    })
                  }),
          Visibility(
            visible: Show,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CardNormal(
                    childCard: Column(
                  children: [
                    SfDateRangePicker(
                      onSelectionChanged: _onSelectionChanged,
                      selectionMode: DateRangePickerSelectionMode.range,
                      initialSelectedRange: PickerDateRange(startDate, endDate),
                    ),
                  ],
                )),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CardNormal(
                  childCard: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Harga Listrik',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: 10),
                        FutureBuilder(
                            future: getData(start, end),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                final Fuzzy fuzzy = snapshot.data;
                                return Text(
                                  fuzzy?.data?.hargaTotal.toString() ?? 'Rp. 0',
                                  style: Theme.of(context).textTheme.headline6,
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CardNormal(
                  childCard: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Energy Cost',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: 10),
                        FutureBuilder(
                            future: getData(start, end),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                final Fuzzy fuzzy = snapshot.data;
                                return Text(
                                  fuzzy?.data?.energyTotal.toString() ??
                                      '0.0' + ' kWh',
                                  style: Theme.of(context).textTheme.headline6,
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            child: FutureBuilder(
                future: getData(start, end),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    Fuzzy fuzzy = snapshot.data;
                    if (fuzzy.data == null) {
                      return ChartSingle(chartData: []);
                    }
                    final data = fuzzy?.data?.dataFuzy as List<DataFuzy>;
                    return ChartSingle(chartData: data);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
          CardNormal(
            childCard: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Expanded(
                          child: Text('Table Jenis Pengguna KwH',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Icon(
                        Icons.info_outline,
                        color: Colors.black,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                          child: Text(
                              'Table ini menampilkan data analisis dari data yang dipilih, dan untuk liat lebih detail bisa drag table ke kanan',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12)))
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FutureBuilder(
                      future: getData(start, end),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          Fuzzy fuzzy = snapshot.data;
                          if (fuzzy.data == null) {
                            return Column(
                              children: const [
                                SizedBox(height: 20),
                                Center(
                                  child: Text('Data Tidak Ditemukan'),
                                ),
                              ],
                            );
                          }
                          List<ResultTable> data =
                              fuzzy?.data?.resultTable as List<ResultTable>;
                          return DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Tanggal',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Energy',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Biaya',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Jumlah Perangkat',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Stopwatch',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows: data
                                .map<DataRow>((e) => DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(e.waktu.toString())),
                                        DataCell(Text(e.energy.toString())),
                                        DataCell(Text(e.biaya.toString())),
                                        DataCell(
                                            Text(e.jumlah.toInt().toString())),
                                        DataCell(Text(
                                            e.stopwatch.toString() + ' Jam')),
                                      ],
                                    ))
                                .toList(),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
