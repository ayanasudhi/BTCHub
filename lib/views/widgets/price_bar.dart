import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/btc/models/btc_chart_model.dart';
import 'package:flutter_app/utils/helper_functions.dart';

import '../../utils/utils.dart';

class CurrentPrice extends StatelessWidget {
  const CurrentPrice({
    Key? key,
    required List<BTCCandleModel> listData,
    required bool isIncreased,
    required String status,
  })  : _isIncreased = isIncreased,
        _status = status,
        _listData = listData,
        super(key: key);

  final bool _isIncreased;
  final List<BTCCandleModel> _listData;
  final String _status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Row(
        children: [
          Text(
            HelperFunctions.priceToString(_listData[0].close),
            style: TextStyle(
                color: _isIncreased ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 30,
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _isIncreased ? Colors.green : Colors.red),
            child: Center(
              child: Text(_status,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
