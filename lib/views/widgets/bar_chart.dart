import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../../data/btc/models/btc_chart_model.dart';
import '../pages/btc_graph_page.dart';

class BarChart extends StatefulWidget {
  const BarChart({
    Key? key,
    required this.listData,
  }) : super(key: key);

  final List<BTCChartModel> listData;

  @override
  State<StatefulWidget> createState() {
    return BarChartState();
  }
}

class BarChartState extends State<BarChart> {
  BarChartState({Key? key});
  void chartRefresh() {
    setState(() {});
  }

  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
        enablePanning: true,
        enablePinching: true,
        enableDoubleTapZooming: true,
        zoomMode: ZoomMode.x);
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

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
        zoomPanBehavior: _zoomPanBehavior,
        tooltipBehavior: _tooltipBehavior,
        onZooming: (ZoomPanArgs args) {
          if (args.axis?.name == 'primaryXAxis') {
            zoomP = args.currentZoomPosition;
            zoomF = args.currentZoomFactor;
            cartesianChartKey.currentState!.refreshChart();
          }
        },
        plotAreaBorderColor: Colors.transparent,
        series: <ChartSeries<BTCChartModel, DateTime>>[
          ColumnSeries<BTCChartModel, DateTime>(
              dataSource: widget.listData,
              xValueMapper: (BTCChartModel data, _) => data.openTime,
              yValueMapper: (BTCChartModel data, _) => data.volume,
              pointColorMapper: (BTCChartModel data, _index) {
                if (_index == 0) {
                  return Colors.green;
                } else {
                  if (widget.listData[_index].close <
                      widget.listData[_index - 1].close) {
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
          zoomFactor: zoomF,
          zoomPosition: zoomP,
          name: 'primaryXAxis',
          visibleMinimum: widget.listData[widget.listData.length - 30].openTime,
          visibleMaximum: widget.listData[widget.listData.length - 1].openTime,
          axisLine: AxisLine(color: Colors.transparent),
          majorGridLines: MajorGridLines(width: 0, color: Colors.amber),
        ),
        primaryYAxis: NumericAxis(
            opposedPosition: true,
            axisLine: AxisLine(color: Colors.transparent),
            majorGridLines: MajorGridLines(color: Colors.transparent),
            majorTickLines: MajorTickLines(color: Colors.transparent),
            numberFormat: NumberFormat.compact(),
            labelsExtent: 40),
      ),
    );
  }
}
