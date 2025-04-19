import 'package:flutter/material.dart';
import '../Utils/helpers.dart';

class LedStatusWidget extends StatelessWidget {
  
  final LedStatus ledStatus;

  const LedStatusWidget({
    Key? key,
    required this.ledStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    String imagePath = (ledStatus == LedStatus.ON) ? 'assets/led/led_on.png' : 'assets/led/led_off.png';

    // Get screen size for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final imageSize = screenWidth * 0.1;

    return Image.asset(
      imagePath,
      width: imageSize,
      height: imageSize,
    );
  }
}
