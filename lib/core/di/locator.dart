
import 'package:flutter_app/core/network/dio_request_manager.dart';
import 'package:flutter_app/core/network/i_api_request_manager.dart';
import 'package:flutter_app/data/btc/btc_api_client.dart';
import 'package:flutter_app/data/btc/btc_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator (){
  
  locator.registerSingleton<IApiRequestManager>(DioRequestManager());
  
  locator.registerFactory<BTCApiClient>(() => BTCApiClient(requestManager: locator<IApiRequestManager>()));

  locator.registerFactory<BTCRepository>(() => BTCRepository(btcApiClient: locator<BTCApiClient>()));
  
  
}