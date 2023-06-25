import 'package:flutter/material.dart';
import 'package:monitoring/models/Fuzzy.dart';
import 'package:monitoring/widgets/my_text_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:monitoring/models/ChartData.dart';
import 'package:monitoring/models/Monitoring.dart';
import 'package:monitoring/widgets/Card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChartSingle extends StatefulWidget {
  const ChartSingle({super.key, required this.chartData});
  final List<DataFuzy> chartData;

  @override
  State<ChartSingle> createState() => _ChartSingleState();
}

class _ChartSingleState extends State<ChartSingle> {
  @override
  late TooltipBehavior _tooltipBehavior;
  late SelectionBehavior _selectionBehavior;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dayaController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String dropdownValue = '';

  void saveDaya() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('daya', dropdownValue);
    Navigator.of(context).pop();
  }

  void getData() async {
    final SharedPreferences prefs = await _prefs;
    dropdownValue = prefs.getString('daya') ?? '900';
  }

  // make list dropdown
  List<String> dataDropdown = ['900', '1300', '2200', '3500', '5500', '6600'];

  // make stream firebase events  and listen to it

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    _selectionBehavior = SelectionBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardNormal(
          childCard: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(children: [
                Row(
                  children: [
                    const Expanded(
                        child: Text('Jenis Pengguna KwH',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: () => {
                              getData(),
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            right: -40.0,
                                            top: -40.0,
                                            child: InkResponse(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: CircleAvatar(
                                                child: Icon(Icons.close),
                                                backgroundColor: Colors.red,
                                              ),
                                            ),
                                          ),
                                          Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child:
                                                      DropdownButtonFormField(
                                                    decoration: InputDecoration(
                                                      labelText: 'Daya',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    value: dropdownValue,
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        dropdownValue =
                                                            newValue!;
                                                      });
                                                    },
                                                    items: dataDropdown.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: MyTextButton(
                                                        buttonName:
                                                            'Submit Daya',
                                                        onTap: () => {
                                                              if (_formKey
                                                                  .currentState!
                                                                  .validate())
                                                                {saveDaya()}
                                                            },
                                                        bgColor: Colors.black,
                                                        textColor:
                                                            Colors.white))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                            }),
                  ],
                ),
                const SizedBox(height: 12),
                SfCartesianChart(
                    tooltipBehavior: _tooltipBehavior,
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries>[
                      SplineSeries<DataFuzy, String>(
                        dataLabelMapper: (DataFuzy data, _) =>
                            // data.pF,
                            '${data.dataFuzys?.text?.replaceAll('Penggunaan ', '')}',
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          textStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        enableTooltip: true,
                        color: Color.fromRGBO(24, 58, 29, 1),
                        dataSource: widget.chartData,
                        xValueMapper: (DataFuzy data, _) =>
                            // data.pF,
                            '${data.waktus}',
                        yValueMapper: (DataFuzy data, _) =>
                            (data.dataFuzys?.fuzy?.toInt() ?? 0) *
                            100.toInt() /
                            100,
                      )
                    ])
              ])),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
