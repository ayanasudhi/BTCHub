import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/network/i_api_request_manager.dart';
import 'package:flutter_app/data/btc/models/btc_data_model.dart';
import 'package:flutter_app/data/btc/models/btc_request_model.dart';

class BTCApiClient {
  final IApiRequestManager requestManager;

  BTCApiClient({@required this.requestManager})
      : assert(requestManager != null);

  Future<dynamic> fetchBTCData(BTCRequestModel requestModel) async {
    final result =
        await requestManager.getRequest(path: '/api/v3/klines', //path after base url,
            parameters: {
          'symbol': requestModel?.symbol,
          'interval': requestModel?.interval,
          'startTime': requestModel?.startTime,
          'endTime': requestModel?.endTime,
          'limit': requestModel?.limit
        });
    return btcDataModelFromJson(result);
  }
}
