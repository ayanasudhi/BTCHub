import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/network/i_api_request_manager.dart';
import 'package:flutter_app/data/btc/models/btc_chart_model.dart';
import 'package:flutter_app/data/btc/models/btc_response_model.dart';
import 'package:flutter_app/data/btc/models/btc_request_model.dart';

class BTCApiClient {
  final IApiRequestManager requestManager;

  BTCApiClient({required this.requestManager});

  Future<List<BTCChartModel>> fetchBTCData(BTCRequestModel requestModel) async {
    List<BTCChartModel> chartModel = <BTCChartModel>[];
    final result = await requestManager
        .getRequest(path: '/api/v3/klines', //path after base url,
            parameters: {
          'symbol': requestModel.symbol,
          'interval': requestModel.interval,
          'limit': requestModel.limit
        });

    double cryptoToUSDConversion(String value) {
      double currentUSDAmount = 3187.74;
      return double.parse(value) * currentUSDAmount;
    }

    List<List<dynamic>> datas = btcDataModelFromJson(jsonEncode(result));
    for (var data in datas) {
      chartModel.add(BTCChartModel(
          openTime: DateTime.fromMillisecondsSinceEpoch(data[0]),
          open: cryptoToUSDConversion(data[1]),
          high: cryptoToUSDConversion(data[2]),
          low: cryptoToUSDConversion(data[3]),
          close: cryptoToUSDConversion(data[4]),
          volume: double.parse(data[5])));
    }
    return chartModel;
  }
}
