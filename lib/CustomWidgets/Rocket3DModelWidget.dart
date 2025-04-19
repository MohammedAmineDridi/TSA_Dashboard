import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class Rocket3DWidget extends StatefulWidget {

  final double angleX;
  final double angleY;

  const Rocket3DWidget({
    Key? key,
    required this.angleX,
    required this.angleY,
  }) : super(key: key);

  @override
  State<Rocket3DWidget> createState() => _Rocket3DWidgetState();
}

class _Rocket3DWidgetState extends State<Rocket3DWidget> {
  final Flutter3DController _controller = Flutter3DController();
  bool _modelLoaded = false;

  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final widgetWidth = screenWidth * 0.5;
    final widgetHeight = screenHeight * 0.22;

    return SizedBox(
      height: widgetHeight,
      width: widgetWidth,
      child: Flutter3DViewer(
        src: "assets/assets/falconspacex.glb",
        controller: _controller,
        onProgress: (double progressValue) {
          debugPrint('model loading progress : $progressValue');
        },
        onLoad: (String modelAddress) {
          debugPrint('model loaded : $modelAddress');
          _modelLoaded = true;
          _controller.setCameraOrbit(widget.angleX, widget.angleY, 120);
        },
        onError: (String error) {
          debugPrint('model failed to load : $error');
        },
      ),
    );
  }
}
