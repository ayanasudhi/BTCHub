import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/btc/btc_repository.dart';
import 'package:flutter_app/data/btc/models/btc_chart_model.dart';
import 'package:flutter_app/data/btc/models/btc_request_model.dart';
import 'package:flutter_app/providers/btc_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../core/di/locator.dart';
import '../../utils/chartSample.dart';
import '../../utils/populate.dart';

class BTCGraphPage extends StatefulWidget {
  const BTCGraphPage({Key? key}) : super(key: key);

  @override
  _BTCGraphPageState createState() => _BTCGraphPageState();
}

class _BTCGraphPageState extends State<BTCGraphPage> {
  BTCProvider _btcProvider = BTCProvider(locator<BTCRepository>());

  late List<ChartSampleData> _chartData;
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _candleZoomPanBehavior;
  late ZoomPanBehavior _chartZoomPanBehavior;

  List intervals = ["15m", "1h", "1d", "1w"];
  int _cutterntInterval = 0;

  late BTCRequestModel requestModel;

  late List<BTCChartModel> data;

  Future<void> populate() async {
    requestModel = BTCRequestModel();
    requestModel.symbol = "";
    requestModel.interval = "";
    requestModel.startTime = "";
    requestModel.endTime = "";
    requestModel.limit = 100;
    _btcProvider = Provider.of<BTCProvider>(context, listen: false);
    data = await _btcProvider.fetchData(requestModel);

    print(data);
  }

  @override
  void initState() {
    super.initState();
    populate();
    _chartData = Populate().getChartData();
    _candleZoomPanBehavior = ZoomPanBehavior(
        // Enables pinch zooming
        enablePanning: true,
        enablePinching: true);
    _chartZoomPanBehavior = ZoomPanBehavior(
        // Enables pinch zooming
        enablePanning: true,
        enablePinching: true);
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF403F55),
      appBar: AppBar(
        title: Text(
          "Currency Report",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),

            /// Cuttern Price
            ///
            ///
            Container(
              height: 40,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Row(
                children: [
                  Text(
                    "13,540\$",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green),
                    child: Center(
                      child: Text("+ 11.8%",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),

            /// Interval List widget
            ///
            ///
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: intervals.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Center(
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _cutterntInterval = index;
                                  });
                                },
                                child: Text(
                                  intervals[index],
                                  style: _cutterntInterval == index
                                      ? TextStyle(color: Colors.amber)
                                      : TextStyle(color: Colors.white70),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  //Expanded(child: Container()),
                  GestureDetector(
                    onTap: () {
                      _candleZoomPanBehavior.zoomIn();
                      _chartZoomPanBehavior.zoomIn();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFF2F2F41),
                          borderRadius: BorderRadius.circular(30)),
                      child: Icon(
                        Icons.zoom_in,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      _candleZoomPanBehavior.zoomOut();
                      _chartZoomPanBehavior.zoomOut();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFF2F2F41),
                          borderRadius: BorderRadius.circular(30)),
                      child: Icon(
                        Icons.zoom_out,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            /// Charts card
            ///
            ///
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.only(top: 30, bottom: 30, right: 10, left: 10),
                margin: EdgeInsets.only(),
                decoration: BoxDecoration(
                    color: Color(0xFF2F2F41),
                    borderRadius: BorderRadius.circular(30)),
                child: ListView(
                  children: [
                    /// Candle chart
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 3 * 2,
                      child: SfCartesianChart(
                        enableAxisAnimation: true,
                        //trackballBehavior: _trackballBehavior,
                        zoomPanBehavior: _candleZoomPanBehavior,
                        plotAreaBorderColor: Colors.transparent,
                        series: <CandleSeries>[
                          CandleSeries<ChartSampleData, DateTime>(
                            dataSource: _chartData,
                            name: '',
                            xValueMapper: (ChartSampleData sales, _) => sales.x,
                            lowValueMapper: (ChartSampleData sales, _) =>
                                sales.low,
                            highValueMapper: (ChartSampleData sales, _) =>
                                sales.high,
                            openValueMapper: (ChartSampleData sales, _) =>
                                sales.open,
                            closeValueMapper: (ChartSampleData sales, _) =>
                                sales.close,
                            isVisibleInLegend: false,
                          ),
                        ],
                        primaryXAxis: DateTimeAxis(
                            dateFormat: DateFormat.MMM(),
                            labelStyle: TextStyle(color: Colors.transparent),
                            axisLine: AxisLine(color: Colors.white30),
                            majorTickLines:
                                MajorTickLines(color: Colors.transparent),
                            majorGridLines: MajorGridLines(width: 0)),
                        primaryYAxis: NumericAxis(
                            minimum: 88,
                            maximum: 130,
                            interval: 10,
                            axisLine: AxisLine(color: Colors.transparent),
                            majorGridLines:
                                MajorGridLines(color: Colors.white30),
                            majorTickLines:
                                MajorTickLines(color: Colors.transparent),
                            numberFormat:
                                NumberFormat.simpleCurrency(decimalDigits: 0)),
                      ),
                    ),

                    /// Bar chart
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.only(
                          top: 10, bottom: 30, right: 10, left: 10),
                      decoration: BoxDecoration(
                          color: Color(0xFF2F2F41),
                          borderRadius: BorderRadius.circular(30)),
                      child: SfCartesianChart(
                        enableAxisAnimation: true,
                        legend: Legend(isVisible: true),
                        //trackballBehavior: _trackballBehavior,
                        zoomPanBehavior: _chartZoomPanBehavior,
                        plotAreaBorderColor: Colors.transparent,
                        series: <ChartSeries<ChartSampleData, DateTime>>[
                          ColumnSeries<ChartSampleData, DateTime>(
                              dataSource: _chartData,
                              xValueMapper: (ChartSampleData data, _) => data.x,
                              yValueMapper: (ChartSampleData data, _) =>
                                  data.low,
                              name: 'Gold',
                              isVisibleInLegend: false,
                              spacing: 0,
                              trackPadding: 0,
                              width: 0.9,
                              color: Color(0xFF403F55))
                        ],
                        primaryXAxis: DateTimeAxis(
                            dateFormat: DateFormat.MMM(),
                            axisLine: AxisLine(color: Colors.transparent),
                            majorGridLines:
                                MajorGridLines(width: 0, color: Colors.amber)),
                        primaryYAxis: NumericAxis(
                            minimum: 70,
                            maximum: 120,
                            interval: 50,
                            axisLine: AxisLine(color: Colors.transparent),
                            majorGridLines:
                                MajorGridLines(color: Colors.transparent),
                            majorTickLines:
                                MajorTickLines(color: Colors.transparent),
                            numberFormat:
                                NumberFormat.simpleCurrency(decimalDigits: 0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
