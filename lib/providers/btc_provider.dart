import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/livedata/live_data.dart';
import 'package:flutter_app/core/livedata/ui_state.dart';
import 'package:flutter_app/data/btc/btc_repository.dart';
import 'package:flutter_app/data/btc/models/btc_chart_model.dart';
import 'package:flutter_app/data/btc/models/btc_request_model.dart';

class BTCProvider with ChangeNotifier {
  final BTCRepository btcRepository;
  BTCProvider(this.btcRepository);

  LiveData<UIState<List<BTCChartModel>>> _btcData =
      LiveData<UIState<List<BTCChartModel>>>();

  LiveData<UIState<List<BTCChartModel>>> getLiveData() {
    return this._btcData;
  }

  Future<List<BTCChartModel>> fetchData(BTCRequestModel requestModel) async {
    _btcData.setValue(IsLoading());
    notifyListeners();
    try {
      final dataResult = await btcRepository.getBTCData(requestModel);
      _btcData.setValue(Success(dataResult));
      notifyListeners();

      return dataResult;
    } on FormatException catch (exc) {
      _btcData.setValue(Failure(exc.message));
      throw exc;
    }
  }
}
