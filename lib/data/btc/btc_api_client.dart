import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/network/i_api_request_manager.dart';
import 'package:flutter_app/data/btc/models/btc_data_model.dart';

class BTCApiClient {

  final IApiRequestManager requestManager;
  BTCApiClient({@required this.requestManager}) : assert (requestManager !=null);

  Future<dynamic> fetchBTCData() async {
    final result = await requestManager.getRequest(
        path: '',//path after base url,
      parameters: {'a': "0", 'b': "1", 'c': "2"}
    );
    return btcDataModelFromJson(result);
  }

}