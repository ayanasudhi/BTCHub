class BTCChartModel
{
  BTCChartModel({
    required this.openTime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  DateTime openTime;
  num open;
  num close;
  num low;
  num high;
  num volume;
}