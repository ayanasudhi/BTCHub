import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../data/btc/models/btc_chart_model.dart';

class CandleChart extends StatelessWidget {
  const CandleChart({
    Key? key,
    required TrackballBehavior trackballBehavior,
    required ZoomPanBehavior candleZoomPanBehavior,
    required this.listData,
  })  : _trackballBehavior = trackballBehavior,
        _candleZoomPanBehavior = candleZoomPanBehavior,
        super(key: key);

  final TrackballBehavior _trackballBehavior;
  final ZoomPanBehavior _candleZoomPanBehavior;
  final List<BTCChartModel> listData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 3 * 2,
      child: SfCartesianChart(
        enableAxisAnimation: true,
        trackballBehavior: _trackballBehavior,
        zoomPanBehavior: _candleZoomPanBehavior,
        plotAreaBorderColor: Colors.transparent,
        series: <CandleSeries>[
          CandleSeries<BTCChartModel, DateTime>(
            dataSource: listData,
            name: '',
            xValueMapper: (BTCChartModel sales, _) => sales.openTime,
            lowValueMapper: (BTCChartModel sales, _) => sales.low,
            highValueMapper: (BTCChartModel sales, _) => sales.high,
            openValueMapper: (BTCChartModel sales, _) => sales.open,
            closeValueMapper: (BTCChartModel sales, _) => sales.close,
            isVisibleInLegend: false,
          ),
        ],
        primaryXAxis: DateTimeAxis(
            dateFormat: DateFormat.MMM(),
            labelStyle: TextStyle(color: Colors.transparent),
            axisLine: AxisLine(color: Colors.white30),
            majorTickLines: MajorTickLines(color: Colors.transparent),
            majorGridLines: MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
            axisLine: AxisLine(color: Colors.transparent),
            majorGridLines: MajorGridLines(color: Colors.white30),
            majorTickLines: MajorTickLines(color: Colors.transparent),
            numberFormat: NumberFormat.simpleCurrency(decimalDigits: 1)),
      ),
    );
  }
}
