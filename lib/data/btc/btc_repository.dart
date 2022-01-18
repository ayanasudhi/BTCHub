import 'package:flutter_app/data/btc/btc_api_client.dart';
import 'package:flutter_app/data/btc/models/btc_request_model.dart';

import 'models/btc_chart_model.dart';

class BTCRepository {
  final BTCApiClient btcApiClient;

  BTCRepository({required this.btcApiClient});

  Future<List<BTCChartModel>> getBTCData(BTCRequestModel requestModel) async =>
      await btcApiClient.fetchBTCData(requestModel);
}
