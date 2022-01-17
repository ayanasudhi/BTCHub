

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/livedata/live_data.dart';
import 'package:flutter_app/core/livedata/ui_state.dart';
import 'package:flutter_app/data/btc/btc_repository.dart';
import 'package:flutter_app/data/btc/models/btc_request_model.dart';

class BTCProvider with ChangeNotifier {

  final BTCRepository btcRepository;
  BTCProvider(this.btcRepository);

  LiveData<UIState<dynamic>> _btcData = LiveData<UIState<dynamic>>();

  void fetchData(BTCRequestModel requestModel)async{
    _btcData.setValue(IsLoading());
    await Future.delayed(Duration(seconds: 1));
    try{
      var dataResult = await btcRepository.getBTCData(requestModel);
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