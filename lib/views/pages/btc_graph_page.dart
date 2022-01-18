import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/btc/btc_repository.dart';
import 'package:flutter_app/data/btc/models/btc_chart_model.dart';
import 'package:flutter_app/data/btc/models/btc_request_model.dart';
import 'package:flutter_app/providers/btc_provider.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/views/widgets/interval_zoom_bar.dart';
import 'package:flutter_app/views/widgets/price_bar.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../core/di/locator.dart';
import '../../core/livedata/ui_state.dart';
import '../widgets/bar_chart.dart';
import '../widgets/candle_chart.dart';

class BTCGraphPage extends StatefulWidget {
  const BTCGraphPage({Key? key}) : super(key: key);

  @override
  _BTCGraphPageState createState() => _BTCGraphPageState();
}

class _BTCGraphPageState extends State<BTCGraphPage> {
  BTCProvider _btcProvider = BTCProvider(locator<BTCRepository>());

  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _candleZoomPanBehavior;
  late ZoomPanBehavior _chartZoomPanBehavior;

  late BTCRequestModel requestModel;

  List intervals = ["15m", "1h", "1d", "1w"];
  String _currentInterval = "15m";

  Future<void> populate() async {
    requestModel = BTCRequestModel();
    requestModel.symbol = "ETHBTC";
    requestModel.interval = _currentInterval;
    requestModel.limit = 40;
    await _btcProvider.fetchData(requestModel);
  }

  @override
  void initState() {
    super.initState();
    populate();
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
      body: ChangeNotifierProvider<BTCProvider>(create: (ctx) {
        return _btcProvider;
      }, child: Consumer<BTCProvider>(
        builder: (ctx, data, _) {
          var state = data.getLiveData().getValue();
          if (state is Initial || state is IsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Success) {
            List<BTCChartModel> listData = state.data;
            int length = listData.length;
            bool isIncreased;
            var percentage;
            String status;
            if (listData[length - 1].close < listData[length - 2].close) {
              isIncreased = false;
              percentage =
                  (listData[length - 2].close - listData[length - 1].close) /
                      listData[length - 1].close *
                      100;

              status = "- " + Utils().dp(percentage, 3).toString() + " %";
            } else {
              isIncreased = true;
              percentage =
                  (listData[length - 1].close - listData[length - 2].close) /
                      listData[length - 2].close *
                      100;

              status = "+ " + Utils().dp(percentage, 3).toString() + " %";
            }
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),

                  /// Current Price
                  ///
                  ///
                  CurrentPrice(
                      listData: listData,
                      isIncreased: isIncreased,
                      status: status),
                  SizedBox(
                    height: 5,
                  ),

                  /// Interval List widget
                  ///
                  ///
                  IntervalZoomHeader(
                      intervals: intervals,
                      populate: populate,
                      candleZoomPanBehavior: _candleZoomPanBehavior,
                      chartZoomPanBehavior: _chartZoomPanBehavior,
                      currentInterval: _currentInterval),
                  SizedBox(
                    height: 20,
                  ),

                  /// Charts card
                  ///
                  ///
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 30, bottom: 30, right: 10, left: 10),
                      margin: EdgeInsets.only(),
                      decoration: BoxDecoration(
                          color: Color(0xFF2F2F41),
                          borderRadius: BorderRadius.circular(30)),
                      child: ListView(
                        children: [
                          /// Candle chart
                          ChandleChart(
                              trackballBehavior: _trackballBehavior,
                              candleZoomPanBehavior: _candleZoomPanBehavior,
                              listData: listData),

                          /// Bar chart
                          BarChart(
                              chartZoomPanBehavior: _chartZoomPanBehavior,
                              listData: listData),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is Failure) {
            return Center(
              child: Text('${state.error}'),
            );
          } else {
            return Container();
          }
        },
      )),
    );
  }
}
