import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IntervalZoomHeader extends StatelessWidget {
  IntervalZoomHeader({
    Key? key,
    required List intervals,
    required Function populate,
    required ZoomPanBehavior candleZoomPanBehavior,
    required ZoomPanBehavior chartZoomPanBehavior,
    required String currentInterval,
  })  : _intervals = intervals,
        _populate = populate,
        _candleZoomPanBehavior = candleZoomPanBehavior,
        _chartZoomPanBehavior = chartZoomPanBehavior,
        _currentInterval = currentInterval,
        super(key: key);

  final List _intervals;
  final Function _populate;
  final ZoomPanBehavior _candleZoomPanBehavior;
  final ZoomPanBehavior _chartZoomPanBehavior;
  late String _currentInterval;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _intervals.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: InkWell(
                        onTap: () {
                          _currentInterval = _intervals[index];
                          _populate();
                        },
                        child: Text(
                          _intervals[index],
                          style: _currentInterval == _intervals[index]
                              ? TextStyle(color: Colors.amber)
                              : TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          //Expanded(child: Container()),
          GestureDetector(
            onTap: () {
              _candleZoomPanBehavior.zoomIn();
              _chartZoomPanBehavior.zoomIn();
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Color(0xFF2F2F41),
                  borderRadius: BorderRadius.circular(30)),
              child: Icon(
                Icons.zoom_in,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              _candleZoomPanBehavior.zoomOut();
              _chartZoomPanBehavior.zoomOut();
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Color(0xFF2F2F41),
                  borderRadius: BorderRadius.circular(30)),
              child: Icon(
                Icons.zoom_out,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
