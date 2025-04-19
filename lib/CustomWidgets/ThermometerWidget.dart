import 'package:flutter/material.dart';
import 'package:dashboard/Utils/helpers.dart';
import 'package:dashboard/Utils/helpers.dart';

class ThermometerWidget extends StatelessWidget {
  final double temperatureValue; // Temperature or measured value (e.g., -50 to 50)

  const ThermometerWidget({
    Key? key,
    required this.temperatureValue, // Measured value (e.g., temperature)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Map measuredValue (-50 to 50) to thermometer height (e.g., 0 to 200)
    double thermometerHeight = _mapValueToHeight(temperatureValue);

    double topMargin = 260 - thermometerHeight - 60; // Subtract the ball's height (radius = 60)

    return Container(
      width: 100,
      height: 260,
      child: Stack(
        children: [
          // Left bars
          _buildLeftBar(30),
          _buildLeftBar(60),
          _buildLeftBar(90),
          _buildLeftBar(120),
          _buildLeftBar(150),
          // Right bars
          _buildRightBar(38),
          _buildRightBar(68),
          _buildRightBar(98),
          _buildRightBar(128),
          _buildRightBar(158),
          // Main thermometer body with the dynamic red bar
          Align(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: 80,
                  margin: const EdgeInsets.only(top: 160),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFBFC9D7),
                        blurRadius: 10,
                        offset: Offset(2, 3),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 40,
                  height: 200,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryRedColor, // red color
                        blurRadius: 10,
                        offset:const Offset(2, 3),
                      )
                    ],
                    borderRadius:const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  margin: const EdgeInsets.only(top: 160),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 30,
                  height: thermometerHeight, // Use the dynamic height here
                  margin: EdgeInsets.only(top: topMargin), // Use the dynamically calculated margin
                  decoration: BoxDecoration(
                    color:primaryRedColor,// Main bar of thermometer (red color)
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  margin: const EdgeInsets.only(top: 160),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryRedColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Function to map measuredValue (-50 to 50) to thermometer height (0 to 200)
  double _mapValueToHeight(double value) {
    double minHeight = 0; // Minimum height (start of thermometer)
    double maxHeight = 200; // Maximum height (end of thermometer)
    double minValue = -50; // Minimum measured value (-50)
    double maxValue = 50;  // Maximum measured value (50)

    // Scale the value to the height range
    double height = ((value - minValue) / (maxValue - minValue)) * (maxHeight - minHeight);
    return height;
  }

  Widget _buildLeftBar(double topMargin) {
    return Container(
      width: 14,
      height: 4,
      margin: EdgeInsets.only(top: topMargin),
      decoration: const BoxDecoration(
        color: Color(0xFFB0B0B0), 
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
    );
  }

  Widget _buildRightBar(double topMargin) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 14,
        height: 4,
        margin: EdgeInsets.only(top: topMargin),
        decoration: const BoxDecoration(
          color: Color(0xFFB0B0B0), 
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
        ),
      ),
    );
  }
}
