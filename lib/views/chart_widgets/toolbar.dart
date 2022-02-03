import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/theme/theme_data.dart';

import 'custom_button.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({
    Key? key,
    required this.onZoomInPressed,
    required this.onZoomOutPressed,
    required this.interval,
    required this.intervals,
    required this.onIntervalChange,
  }) : super(key: key);

  final void Function() onZoomInPressed;
  final void Function() onZoomOutPressed;
  final void Function(String) onIntervalChange;
  final List<String> intervals;
  final String interval;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: [

            // CustomButton(
            //   onPressed: onZoomOutPressed,
            //   child: Icon(
            //     Icons.remove,
            //     color: Theme.of(context).grayColor,
            //   ),
            // ),
            // CustomButton(
            //   onPressed: onZoomInPressed,
            //   color: Colors.purple,
            //   child: Icon(
            //     Icons.add,
            //     color: Theme.of(context).grayColor,
            //   ),
            // ),
            // CustomButton(
            //
            //   onPressed: () {
            //     showDialog(
            //       context: context,
            //       builder: (context) {
            //         return Center(
            //           child: Container(
            //             width: 200,
            //             color: Theme.of(context).digalogColor,
            //             child: Wrap(
            //               children: intervals
            //                   .map(
            //                     (e) => Padding(
            //                       padding: const EdgeInsets.all(8.0),
            //                       child: CustomButton(
            //                         width: 50,
            //                         color: Theme.of(context).lightGold,
            //                         child: Text(
            //                           e,
            //                           style: TextStyle(
            //                             color: Theme.of(context).gold,
            //                           ),
            //                         ),
            //                         onPressed: () {
            //                           onIntervalChange(e);
            //                           Navigator.of(context).pop();
            //                         },
            //                       ),
            //                     ),
            //                   )
            //                   .toList(),
            //             ),
            //           ),
            //         );
            //       },
            //     );
            //   },
            //   child: Text(
            //     interval,
            //     style: TextStyle(
            //       color: Theme.of(context).grayColor,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
