import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:monitoring/models/ChartData.dart';
import 'package:monitoring/models/Monitoring.dart';
import 'package:monitoring/widgets/Card.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:monitoring/widgets/Headline.dart';
import 'package:syncfusion_flutter_charts/src/circular_chart/utils/enum.dart';

class SpedoMeter extends StatefulWidget {
  const SpedoMeter({super.key, required this.fuzy, required this.typeString});
  final List<Map<String, dynamic>> fuzy;
  final String typeString;

  @override
  State<SpedoMeter> createState() => _SpedoMeterState();
}

class _SpedoMeterState extends State<SpedoMeter> {
  @override
  late TooltipBehavior _tooltipBehavior;
  late TooltipBehavior _tooltipBehavior2;
  late SelectionBehavior _selectionBehavior;

  // make stream firebase events  and listen to it

  @override
  void initState() {
    logger();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _tooltipBehavior2 = TooltipBehavior(enable: true);
    _selectionBehavior = SelectionBehavior(enable: true);
    super.initState();
  }

  void logger() {
    print("Logger Fuzzy " +
        widget.fuzy[0]['energytotal'].toString() +
        ' ' +
        widget.fuzy.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardNormal(
          childCard: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(child: Headline(title: 'Realtime')),
                Text(
                  widget.fuzy.length > 0
                      ? new DateTime.fromMillisecondsSinceEpoch((int.parse(
                                  widget.fuzy[0]['TimeStamp']
                                      .toString()
                                      .replaceAll('Timestamp(seconds=', '')
                                      .replaceAll(', nanoseconds=0)', '')) *
                              1000))
                          .toLocal()
                          .toString()
                      : "0.0",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        CardNormal(
          childCard: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                const Expanded(child: Headline(title: 'Energy Today')),
                Text(
                  widget.fuzy.length > 0
                      ? widget.fuzy[0]['energytotal'].toString() + ' kWh'
                      : "0.0",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              const Headline(
                title: 'Power',
                // caption: 'Ini adalah chart untuk realtime data power',
              ),
              SfRadialGauge(axes: <RadialAxis>[
                RadialAxis(
                    interval: 10,
                    showTicks: true,
                    showLabels: true,
                    canRotateLabels: true,
                    canScaleToFit: true,
                    axisLineStyle: AxisLineStyle(thickness: 15),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: widget.fuzy.length > 0
                            ? double.parse(widget.fuzy[0]
                                    ['power' + widget.typeString]
                                .toString())
                            : 0,
                        width: 15,
                        color: Color(0xFFFFCD60),
                        enableAnimation: true,
                        // cornerStyle: CornerStyle.bothFlat,
                      )
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Column(
                            children: <Widget>[
                              const SizedBox(height: 70),
                              Container(
                                  width: 50.00,
                                  height: 50.00,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: NetworkImage(
                                          "https://cdn-icons-png.flaticon.com/512/5501/5501097.png"),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                child: Container(
                                  child: Text(
                                      widget.fuzy.length > 0
                                          ? widget.fuzy[0]
                                                  ['power' + widget.typeString]
                                              .toString()
                                          : "0.0",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25)),
                                ),
                              )
                            ],
                          ),
                          angle: 270,
                          positionFactor: 0.1)
                    ])
              ]),
              const Headline(
                title: 'Arus',
                // caption: 'Ini adalah chart untuk realtime data power',
              ),
              SfRadialGauge(axes: <RadialAxis>[
                RadialAxis(
                    interval: 10,
                    showTicks: true,
                    showLabels: true,
                    canRotateLabels: true,
                    canScaleToFit: true,
                    axisLineStyle: AxisLineStyle(thickness: 15),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: widget.fuzy.length > 0
                            ? double.parse(widget.fuzy[0]
                                    ['Arus' + widget.typeString]
                                .toString())
                            : 0,
                        width: 15,
                        color: Color(0xFFFFCD60),
                        enableAnimation: true,
                        // cornerStyle: CornerStyle.bothFlat,
                      )
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Column(
                            children: <Widget>[
                              const SizedBox(height: 70),
                              Container(
                                  width: 50.00,
                                  height: 50.00,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: NetworkImage(
                                          "https://cdn-icons-png.flaticon.com/512/5501/5501097.png"),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                child: Container(
                                  child: Text(
                                      widget.fuzy.length > 0
                                          ? widget.fuzy[0]
                                                  ['Arus' + widget.typeString]
                                              .toString()
                                          : "0.0",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25)),
                                ),
                              )
                            ],
                          ),
                          angle: 270,
                          positionFactor: 0.1)
                    ])
              ]),
            ],
          ),
        )
      ],
    );
  }
}
