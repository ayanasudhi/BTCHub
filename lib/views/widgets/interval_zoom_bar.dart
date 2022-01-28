import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../pages/btc_graph_page.dart';

class IntervalZoomHeader extends StatefulWidget {
  IntervalZoomHeader({
    Key? key,
    required List intervals,
    required Function populate,
    required String currentInterval,
  })  : _intervals = intervals,
        _populate = populate,
        _currentInterval = currentInterval,
        super(key: key);

  final List _intervals;
  final Function _populate;
  late String _currentInterval;

  @override
  State<IntervalZoomHeader> createState() => _IntervalZoomHeaderState();
}

class _IntervalZoomHeaderState extends State<IntervalZoomHeader> {
  late String _interval;

  @override
  void initState() {
    _interval = widget._currentInterval;
  }

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
                itemCount: widget._intervals.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _interval = widget._intervals[index];
                          });
                          widget._populate(_interval);
                        },
                        child: Text(
                          widget._intervals[index],
                          style: _interval == widget._intervals[index]
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
              candleZoomPanBehavior.zoomIn();
              chartZoomPanBehavior.zoomIn();
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
              candleZoomPanBehavior.zoomOut();
              chartZoomPanBehavior.zoomOut();
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
