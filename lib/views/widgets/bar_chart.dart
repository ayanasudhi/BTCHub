import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../../data/btc/models/btc_chart_model.dart';

class BarChart extends StatelessWidget {
  const BarChart({
    Key? key,
    required ZoomPanBehavior chartZoomPanBehavior,
    required this.listData,
  })  : _chartZoomPanBehavior = chartZoomPanBehavior,
        super(key: key);

  final ZoomPanBehavior _chartZoomPanBehavior;
  final List<BTCChartModel> listData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.only(top: 10, bottom: 30, right: 10, left: 10),
      decoration: BoxDecoration(
          color: Color(0xFF2F2F41), borderRadius: BorderRadius.circular(30)),
      child: SfCartesianChart(
        enableAxisAnimation: true,
        legend: Legend(isVisible: true),
        //trackballBehavior: _trackballBehavior,
        zoomPanBehavior: _chartZoomPanBehavior,
        plotAreaBorderColor: Colors.transparent,
        series: <ChartSeries<BTCChartModel, DateTime>>[
          ColumnSeries<BTCChartModel, DateTime>(
              dataSource: listData,
              xValueMapper: (BTCChartModel data, _) => data.openTime,
              yValueMapper: (BTCChartModel data, _) => data.volume,
              pointColorMapper: (BTCChartModel data, _index) {
                if (_index == 0) {
                  return Colors.green;
                } else {
                  if (listData[_index].close < listData[_index - 1].close) {
                    return Colors.red;
                  } else {
                    return Colors.green;
                  }
                }
              },
              name: 'Gold',
              isVisibleInLegend: false,
              spacing: 0,
              trackPadding: 0,
              width: 0.9,
              color: Color(0xFF403F55))
        ],
        primaryXAxis: DateTimeAxis(
            axisLine: AxisLine(color: Colors.transparent),
            majorGridLines: MajorGridLines(width: 0, color: Colors.amber)),
        primaryYAxis: NumericAxis(
          axisLine: AxisLine(color: Colors.transparent),
          majorGridLines: MajorGridLines(color: Colors.transparent),
          majorTickLines: MajorTickLines(color: Colors.transparent),
        ),
      ),
    );
  }
}
