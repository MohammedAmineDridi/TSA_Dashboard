import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class BarometerLevelWidget extends StatelessWidget {
  final double minValue;
  final double maxValue;
  final double currentValue;

  const BarometerLevelWidget({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.currentValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final gaugeWidth = screenWidth * 0.6;
    final gaugeHeight = screenHeight * 0.2;
    final needleWidth = gaugeWidth * 0.05;
    final needleHeight = gaugeHeight * 0.6;
    final radius = gaugeWidth * 0.35;

    return Center(
      child: SizedBox(
        width: gaugeWidth,
        height: gaugeHeight,
        child: AnimatedRadialGauge(
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
          radius: radius,
          value: currentValue,
          axis: GaugeAxis(
            min: minValue,
            max: maxValue,
            degrees: 180,
            style: GaugeAxisStyle(
              thickness: gaugeWidth * 0.08,
              background: const Color(0xFFDFE2EC),
              segmentSpacing: 2.0,
            ),
            pointer: GaugePointer.needle(
              width: needleWidth,
              height: needleHeight,
              color: const Color(0xFF193663),
            ),
            progressBar: const GaugeProgressBar.basic(
              color: Color(0xFFB4C2F8),
            ),
            segments: [
              GaugeSegment(
                from: minValue,
                to: (maxValue - minValue) / 3 + minValue,
                color: const Color(0xFFD9DEEB),
                cornerRadius: Radius.zero,
              ),
              GaugeSegment(
                from: (maxValue - minValue) / 3 + minValue,
                to: 2 * (maxValue - minValue) / 3 + minValue,
                color: const Color(0xFFD9DEEB),
                cornerRadius: Radius.zero,
              ),
              GaugeSegment(
                from: 2 * (maxValue - minValue) / 3 + minValue,
                to: maxValue,
                color: const Color(0xFFD9DEEB),
                cornerRadius: Radius.zero,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
