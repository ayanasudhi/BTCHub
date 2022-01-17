class BTCChartModel
{
  BTCChartModel({
    this.openTime,
    this.open,
    this.close,
    this.low,
    this.high,
    this.volume,
  });

  final DateTime? openTime;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
  final num? volume;
}