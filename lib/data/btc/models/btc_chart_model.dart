// class BTCChartModel {
//   BTCChartModel({
//     required this.openTime,
//     required this.open,
//     required this.high,
//     required this.low,
//     required this.close,
//     required this.volume,
//   });
//
//   DateTime openTime;
//   num open;
//   num close;
//   num low;
//   num high;
//   num volume;
// }

class BTCCandleModel {
  final DateTime openTime;
  final double high;
  final double low;
  final double open;
  final double close;
  final double volume;

  bool get isBull => open <= close;

  BTCCandleModel({
    required this.openTime,
    required this.high,
    required this.low,
    required this.open,
    required this.close,
    required this.volume,
  });
}

