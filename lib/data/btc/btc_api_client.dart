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
    List<List<dynamic>> datas = btcDataModelFromJson(jsonEncode(result));
    for (var data in datas) {
      chartModel.add(BTCChartModel(
          openTime: DateTime.fromMillisecondsSinceEpoch(data[0]),
          open: double.parse(data[1]),
          high: double.parse(data[2]),
          low: double.parse(data[3]),
          close: double.parse(data[4]),
          volume: double.parse(data[5])));
    }
    return chartModel;
  }
}
