import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:monitoring/models/ChartData.dart';
import 'package:monitoring/models/Monitoring.dart';
import 'package:monitoring/widgets/Card.dart';
import 'package:monitoring/widgets/Headline.dart';

class CardChart extends StatefulWidget {
  const CardChart({super.key, required this.chartData});
  final List<Monitoring> chartData;

  @override
  State<CardChart> createState() => _CardChartState();
}

class _CardChartState extends State<CardChart> {
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
    print(widget.chartData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Headline(
          title: 'Energy',
          // caption: 'Ini adalah chart untuk realtime data power',
        ),
        const SizedBox(height: 20),
        CardNormal(
          childCard: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(children: [
                Row(
                  children: const [
                    Icon(Icons.info_outline, color: Colors.black),
                    SizedBox(width: 12),
                    Expanded(
                        child: Text(
                            'Data streaming akan muncul ketika koneksi internet anda aman',
                            style: TextStyle(color: Colors.black)))
                  ],
                ),
                const SizedBox(height: 12),
                // SfCartesianChart(
                //   tooltipBehavior: _tooltipBehavior,
                //   primaryXAxis: CategoryAxis(),
                //   series: <ChartSeries>[
                //     SplineSeries<Monitoring, String>(
                //       enableTooltip: true,
                //       color: Color.fromRGBO(24, 58, 29, 1),
                //       dataSource: widget.chartData,
                //       xValueMapper: (Monitoring data, _) =>
                //           // data.pF,
                //           '${data.timeStamp?.toDate().hour}:${data.timeStamp?.toDate().minute}:${data.timeStamp?.toDate().second}',
                //       yValueMapper: (Monitoring data, _) =>
                //           (data.energytotal ?? 0) * 100.toInt() / 100,
                //     )
                //   ],
                // )
              ])),
        ),
        const SizedBox(height: 20),
        const Headline(
          title: 'Power',
          // caption: 'Ini adalah chart untuk realtime data power',
        ),
        const SizedBox(height: 20),
        // CardNormal(
        //   childCard: Padding(
        //       padding: const EdgeInsets.all(12),
        //       child: Column(children: [
        //         Row(
        //           children: [
        //             const Icon(Icons.info_outline, color: Colors.black),
        //             const SizedBox(width: 12),
        //             const Expanded(
        //                 child: Text(
        //                     'Data streaming akan muncul ketika koneksi internet anda aman',
        //                     style: TextStyle(color: Colors.black)))
        //           ],
        //         ),
        //         const SizedBox(height: 12),
        //         SfCartesianChart(
        //             tooltipBehavior: _tooltipBehavior2,
        //             primaryXAxis: CategoryAxis(),
        //             series: <ChartSeries>[
        //               SplineSeries<Monitoring, String>(
        //                 enableTooltip: true,
        //                 color: Color.fromRGBO(24, 58, 29, 1),
        //                 dataSource: widget.chartData,
        //                 xValueMapper: (Monitoring data, _) =>
        //                     // data.pF,
        //                     '${data.timeStamp?.toDate().hour}:${data.timeStamp?.toDate().minute}:${data.timeStamp?.toDate().second}',
        //                 yValueMapper: (Monitoring data, _) =>
        //                     (data.powerUtama ?? 0) * 100.toInt() / 100,
        //               )
        //             ])
        //       ])),
        // ),
      ],
    );
  }
}
