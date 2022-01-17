import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BTCGraphPage extends StatefulWidget {
  const BTCGraphPage({Key? key}) : super(key: key);

  @override
  _BTCGraphPageState createState() => _BTCGraphPageState();
}

class _BTCGraphPageState extends State<BTCGraphPage> {

  // List<ChartSampleData> _chartData;
   TrackballBehavior? _trackballBehavior;

  @override
  void initState() {
   // _chartData = getChartData();
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
    // return SafeArea(
    //     child: Scaffold(
    //         body: SfCartesianChart(
    //           title: ChartTitle(text: 'AAPL - 2016'),
    //           legend: Legend(isVisible: true),
    //           trackballBehavior: _trackballBehavior,
    //           series: <CandleSeries>[
    //             CandleSeries<ChartSampleData, DateTime>(
    //                 dataSource: _chartData,
    //                 name: 'AAPL',
    //                 xValueMapper: (ChartSampleData sales, _) => sales.x,
    //                 lowValueMapper: (ChartSampleData sales, _) => sales.low,
    //                 highValueMapper: (ChartSampleData sales, _) => sales.high,
    //                 openValueMapper: (ChartSampleData sales, _) => sales.open,
    //                 closeValueMapper: (ChartSampleData sales, _) => sales.close)
    //           ],
    //           primaryXAxis: DateTimeAxis(
    //               dateFormat: DateFormat.MMM(),
    //               majorGridLines: MajorGridLines(width: 0)),
    //           primaryYAxis: NumericAxis(
    //               minimum: 70,
    //               maximum: 130,
    //               interval: 10,
    //               numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
    //         )));
  }
}
