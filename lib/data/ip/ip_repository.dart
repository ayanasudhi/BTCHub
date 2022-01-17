//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_app/data/ip/ip_api_client.dart';
// import 'package:flutter_app/data/ip/models/ip_model.dart';
//
// class IPRepository {
//   final IpApiClient ipApiClient;
//
//   IPRepository({@required this.ipApiClient}) : assert (ipApiClient != null);
//
//   Future<IpModel> getIp()async => await ipApiClient.fetchIP();
//
//   Future<bool> sendIp() async => await ipApiClient.sendIP('ip');
//
// }