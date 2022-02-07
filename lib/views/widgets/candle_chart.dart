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
  final List<BTCCandleModel> listData;

  @override
  Widget build(BuildContext context) {
    print(listData[listData.length-1].close);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 3 * 2,
      child: SfCartesianChart(
        enableAxisAnimation: true,
        trackballBehavior: _trackballBehavior,
        zoomPanBehavior: _candleZoomPanBehavior,
        plotAreaBorderColor: Colors.transparent,
        annotations: <CartesianChartAnnotation>[
          CartesianChartAnnotation(
              widget:Container(padding: EdgeInsets.all(2), color:listData[listData.length-1].close>listData[listData.length-2].close? Colors.green:Colors.red, margin:EdgeInsets.only(left: 70),
                  child: Text(listData[listData.length-1].open.toString(),style: TextStyle(color: Colors.white, fontSize: 12),)
              ),
              coordinateUnit: CoordinateUnit.point,
              region: AnnotationRegion.chart,
              x: listData[listData.length-2].openTime,
              y: listData[listData.length-2].open
          ),

        ],
        series: <CandleSeries>[
          CandleSeries<BTCCandleModel, DateTime>(
              dataSource: listData,

              // dataLabelSettings: DataLabelSettings(
              //     isVisible: true,
              //     textStyle: TextStyle(color: Colors.green),
              //     // alignment: ChartAlignment.far,
              //     // offset: Offset(0, 10),
              //     borderColor: Colors.purple,
              //
              //     borderWidth: 2,
                  // builder: (dynamic data, dynamic point, dynamic series,
                  //     int pointIndex, int seriesIndex) {
                  //   return Container(
                  //     height: 30,
                  //     width: 30,
                  //     color: Colors.red,
                  //   );
                  // }
                 // ),

              name: '',
              xValueMapper: (BTCCandleModel sales, _) => sales.openTime,
              lowValueMapper: (BTCCandleModel sales, _) => sales.low,
              highValueMapper: (BTCCandleModel sales, _) => sales.high,
              openValueMapper: (BTCCandleModel sales, _) => sales.open,
              closeValueMapper: (BTCCandleModel sales, _) => sales.close,
              isVisibleInLegend: false,

              pointColorMapper: (BTCCandleModel data, _index) {
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
              // dataLabelMapper: (BTCChartModel data, _index) {
              //   if (_index == listData.length - 1) {
              //     return data.close.toString();
              //   } else {
              //     return "";
              //   }
              // }
              ),
        ],
        primaryXAxis: DateTimeAxis(
            visibleMinimum: listData[listData.length - 30].openTime,
            visibleMaximum: listData[listData.length - 1].openTime,
            axisLine: AxisLine(color: Colors.white30),
            majorTickLines: MajorTickLines(color: Colors.transparent),
            labelsExtent: 70,
            majorGridLines: MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
          opposedPosition: true,
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
