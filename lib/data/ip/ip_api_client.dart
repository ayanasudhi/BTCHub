// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_app/core/network/i_api_request_manager.dart';
// import 'package:flutter_app/data/ip/models/ip_model.dart';
//
// class IpApiClient {
//
//   final IApiRequestManager requestManager;
//   IpApiClient({@required this.requestManager}) : assert (requestManager !=null);
//
//   Future<IpModel> fetchIP() async {
//     final result = await requestManager.getRequest(
//       path: ''//path after base url
//     );
//     return IpModel.fromJson(json.decode(result));
//   }
//
//   Future<bool> sendIP(String ip) async{
//     return new Future(()=>true);
//   }
//
// }