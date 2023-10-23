//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_piggy_app/ui/theme.dart';
import 'package:my_piggy_app/ui/widget/event.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLine extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  // ignore: prefer_typing_uninitialized_variables
  final event;
  const TimeLine({super.key, required this.isFirst, required this.isLast, required this.isPast, this.event});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height/6,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(color: context.theme.dialogBackgroundColor),
        indicatorStyle: IndicatorStyle(
          width: MediaQuery.of(context).size.width/12,
          color: context.theme.dialogBackgroundColor,
          iconStyle: IconStyle(
            iconData: Icons.arrow_forward_ios,
            color: Get.isDarkMode?Colors.white:bgClr)
        ),
       // isPast: isPast,
       endChild: Event(
        child: event,
       ),
      ),
    );
  }
}