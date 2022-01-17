

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/livedata/live_data.dart';
import 'package:flutter_app/core/livedata/ui_state.dart';
import 'package:flutter_app/data/btc/btc_repository.dart';

class BTCProvider with ChangeNotifier {

  final BTCRepository btcRepository;
  BTCProvider(this.btcRepository);

  LiveData<UIState<dynamic>> _btcData = LiveData<UIState<dynamic>>();

  LiveData<UIState<dynamic>> getIpLiveData (){
    return this._btcData;
  }

  void fetchIp()async{
    _btcData.setValue(IsLoading());
    await Future.delayed(Duration(seconds: 1));
    try{
      var dataResult = await btcRepository.getBTCData();
      _btcData.setValue(Success(dataResult));
    }
    on FormatException catch (exc){
      _btcData.setValue(Failure(exc.message));
    }
    finally{
      notifyListeners();
    }
  }


}