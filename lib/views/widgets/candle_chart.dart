import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../data/btc/models/btc_chart_model.dart';
import '../pages/btc_graph_page.dart';

class ChandleChart extends StatefulWidget {
  const ChandleChart({
    Key? key,
    required this.listData,
  }) : super(key: key);

  final List<BTCChartModel> listData;

  @override
  State<StatefulWidget> createState() {
    return ChandleChartState();
  }
}

class ChandleChartState extends State<ChandleChart> {
  ChandleChartState({Key? key});
  void refreshChart() {
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
      height: MediaQuery.of(context).size.width / 3 * 2,
      child: SfCartesianChart(
        enableAxisAnimation: true,
        zoomPanBehavior: _zoomPanBehavior,
        tooltipBehavior: _tooltipBehavior,
        plotAreaBorderColor: Colors.transparent,
        onZooming: (ZoomPanArgs args) {
          if (args.axis?.name == 'primaryXAxis') {
            zoomP = args.currentZoomPosition;
            zoomF = args.currentZoomFactor;
            chartKey.currentState!.chartRefresh();
          }
        },
        series: <CandleSeries>[
          CandleSeries<BTCChartModel, DateTime>(
              dataSource: widget.listData,
              enableTooltip: true,
              // dataLabelSettings: DataLabelSettings(
              //     isVisible: true,
              //     textStyle: TextStyle(color: Colors.green),
              //     alignment: ChartAlignment.far,
              //     offset: Offset(0, 10),
              //     borderColor: Colors.purple,
              //     borderWidth: 2,
              //     builder: (dynamic data, dynamic point, dynamic series,
              //         int pointIndex, int seriesIndex) {
              //       return Container(
              //         height: 30,
              //         width: 30,
              //         color: Colors.blue,
              //       );
              //     }),
              name: '',
              xValueMapper: (BTCChartModel sales, _) => sales.openTime,
              lowValueMapper: (BTCChartModel sales, _) => sales.low,
              highValueMapper: (BTCChartModel sales, _) => sales.high,
              openValueMapper: (BTCChartModel sales, _) => sales.open,
              closeValueMapper: (BTCChartModel sales, _) => sales.close,
              isVisibleInLegend: false,
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
              dataLabelMapper: (BTCChartModel data, _index) {
                if (_index == widget.listData.length - 1) {
                  return data.close.toString();
                } else {
                  return "";
                }
              }),
        ],
        primaryXAxis: DateTimeAxis(
            zoomFactor: zoomF,
            zoomPosition: zoomP,
            name: 'primaryXAxis',
            visibleMinimum:
                widget.listData[widget.listData.length - 30].openTime,
            visibleMaximum:
                widget.listData[widget.listData.length - 1].openTime,
            axisLine: AxisLine(color: Colors.white30),
            majorTickLines: MajorTickLines(color: Colors.transparent),
            majorGridLines: MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
          opposedPosition: true,
          labelStyle: TextStyle(color: Colors.green),
          interactiveTooltip: InteractiveTooltip(
              color: Colors.purple, enable: true, borderWidth: 2),
          axisLine: AxisLine(color: Colors.transparent),
          majorGridLines: MajorGridLines(color: Colors.white30),
          majorTickLines: MajorTickLines(color: Colors.transparent),
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 1),
        ),
      ),
    );
  }
}
