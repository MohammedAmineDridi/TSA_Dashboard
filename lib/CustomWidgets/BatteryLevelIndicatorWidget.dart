import 'dart:math' as math;
import 'package:animated_battery_gauge/animated_battery_gauge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BatteryLevelWidget extends StatelessWidget {
  final double batteryLevelValue;

  const BatteryLevelWidget({
    Key? key,
    required this.batteryLevelValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _batteryIndicatorWidget(context, batteryLevelValue);
  }

  Widget _batteryIndicatorWidget(BuildContext context, double batteryLevelValue) {
    final screenWidth = MediaQuery.of(context).size.width;
    final width = screenWidth * 0.11;
    return Transform.rotate(
      angle: -math.pi / 2,
      child: AnimatedBatteryGauge(
        duration: const Duration(seconds: 3),
        value: batteryLevelValue,
        size: Size(width, width/2),
        borderColor: CupertinoColors.systemGrey,
        valueColor: const Color.fromARGB(255, 55, 168, 83),
        hasText: true,
      ),
    );
  }
}
