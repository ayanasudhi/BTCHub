import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/core/di/locator.dart';
import 'package:flutter_app/core/livedata/ui_state.dart';
import 'package:flutter_app/data/btc/btc_repository.dart';
import 'package:flutter_app/data/btc/models/btc_chart_model.dart';
import 'package:flutter_app/data/btc/models/btc_request_model.dart';
import 'package:flutter_app/providers/btc_provider.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/views/chart_widgets/candle_sticks.dart';
import 'package:flutter_app/views/widgets/interval_zoom_bar.dart';
import 'package:flutter_app/views/widgets/price_bar.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BTCGraph extends StatefulWidget {
  const BTCGraph({Key? key}) : super(key: key);

  @override
  _BTCGraphState createState() => _BTCGraphState();
}

class _BTCGraphState extends State<BTCGraph> {
  BTCProvider _btcProvider = BTCProvider(locator<BTCRepository>());
  late BTCRequestModel requestModel;
  List<BTCCandleModel> candles = [];
  List intervals = ["15m", "1h", "1d", "1w"];
  String _currentInterval = "15m";

  void populate(String interval) async {
    requestModel = BTCRequestModel();
    _currentInterval = interval;
    requestModel.symbol = "ETHUSDT";
    requestModel.interval = interval;
    requestModel.limit = 1000;
    await _btcProvider.fetchData(requestModel).then((value) {
      setState(() {
        candles.clear();
        _currentInterval = interval;
        for (int i = 0; i < value.length; i++) {
          candles.add(BTCCandleModel(
              openTime: value[i].openTime,
              high: value[i].high,
              low: value[i].low,
              open: value[i].open,
              close: value[i].close,
              volume: value[i].volume));
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    populate(_currentInterval);
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

            /// Current Price
            ///
            ///
            ChangeNotifierProvider<BTCProvider>(create: (ctx) {
              return _btcProvider;
            }, child: Consumer<BTCProvider>(builder: (ctx, data, _) {
              var state = data.getLiveData().getValue();
              if (state is Success) {
                List<BTCCandleModel> listData = state.data;
                int length = listData.length;
                bool isIncreased;
                var percentage;
                String status;
                if (listData[length - 1].close < listData[length - 2].close) {
                  isIncreased = false;
                  percentage = (listData[length - 2].close -
                          listData[length - 1].close) /
                      listData[length - 1].close *
                      100;

                  status = "- " + Utils().dp(percentage, 3).toString() + " %";
                } else {
                  isIncreased = true;
                  percentage = (listData[length - 1].close -
                          listData[length - 2].close) /
                      listData[length - 2].close *
                      100;

                  status = "+ " + Utils().dp(percentage, 3).toString() + " %";
                }
                return CurrentPrice(
                    listData: listData,
                    isIncreased: isIncreased,
                    status: status);
              } else {
                return Container(
                  height: 40,
                );
              }
            })),

            SizedBox(
              height: 5,
            ),

            /// Interval List widget
            ///
            ///
            // IntervalZoomHeader(
            //     intervals: intervals,
            //     populate: populate,
            //     currentInterval: _currentInterval),
            // SizedBox(
            //   height: 20,
            // ),

            /// Charts card
            ///
            ///
            Expanded(
              child: Container(
                child: ChangeNotifierProvider<BTCProvider>(create: (ctx) {
                  return _btcProvider;
                }, child: Consumer<BTCProvider>(builder: (ctx, data, _) {
                  var state = data.getLiveData().getValue();
                  if (state is Success) {
                    for (int i = 0; i < state.data.length; i++) {
                      candles.add(BTCCandleModel(
                          openTime: state.data[i].openTime,
                          high: state.data[i].high,
                          low: state.data[i].low,
                          open: state.data[i].open,
                          close: state.data[i].close,
                          volume: state.data[i].volume));
                    }
                    //List<BTCCandleModel> listData = state.data;

                    // return Center(
                    //   child: StreamBuilder(
                    //     stream: state.data,
                    //     builder: (context, snapshot) {
                    //        updateCandlesFromSnapshot(state.data);
                    //        return
                    return Candlesticks(
                      onIntervalChange: (String value) async {
                        populate(value);
                      },
                      candles: candles,
                      interval: _currentInterval,
                    );
                    //     },
                    //   ),
                    // );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),
              ),
            ),
          ],
        ),
      ),

      //
      // } else if (state is Failure) {
      //   return Center(
      //     child: Text('${state.error}'),
      //   );
      // } else {
      //   return Container();
      // }
      //  },
      // ))
    );
  }

// void updateCandlesFromSnapshot(AsyncSnapshot<Object?> snapshot) {
//   if (snapshot.data != null) {
//     final data = jsonDecode(snapshot.data as String) as Map<String, dynamic>;
//     if (data.containsKey("k") == true &&
//         candles[0].openTime.millisecondsSinceEpoch == data["k"]["t"]) {
//       candles[0] = BTCCandleModel(
//           openTime: candles[0].openTime,
//           high: double.parse(data["k"]["h"]),
//           low: double.parse(data["k"]["l"]),
//           open: double.parse(data["k"]["o"]),
//           close: double.parse(data["k"]["c"]),
//           volume: double.parse(data["k"]["v"]));
//     } else if (data.containsKey("k") == true &&
//         data["k"]["t"] - candles[0].openTime.millisecondsSinceEpoch ==
//             candles[0].openTime.millisecondsSinceEpoch -
//                 candles[1].openTime.millisecondsSinceEpoch) {
//       candles.insert(
//           0,
//           BTCCandleModel(
//               openTime: DateTime.fromMillisecondsSinceEpoch(data["k"]["t"]),
//               high: double.parse(data["k"]["h"]),
//               low: double.parse(data["k"]["l"]),
//               open: double.parse(data["k"]["o"]),
//               close: double.parse(data["k"]["c"]),
//               volume: double.parse(data["k"]["v"])));
//     }
//   }
// }
}
