import 'package:flutter/cupertino.dart';
import 'package:flutter_app/data/btc/btc_api_client.dart';

class BTCRepository {
  final BTCApiClient btcApiClient;

  BTCRepository({@required this.btcApiClient}) : assert (btcApiClient != null);

  Future<dynamic> getBTCData()async => await btcApiClient.fetchBTCData();

}