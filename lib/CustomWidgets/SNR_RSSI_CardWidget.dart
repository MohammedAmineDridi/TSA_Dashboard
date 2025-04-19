import 'package:flutter/material.dart';
import 'package:dashboard/Utils/helpers.dart';

class SNR_RSSI_Widget extends StatelessWidget {
  
  final double rssiValue;
  final double snrValue;

  const SNR_RSSI_Widget({
    Key? key,
    required this.rssiValue,
    required this.snrValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // RSSI Card
        Container(
        width: 220,
        child : Card(
          color: const Color.fromARGB(255, 219, 175, 160),
          margin: const EdgeInsets.symmetric(vertical: 18.0),
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.signal_cellular_nodata_sharp, color: primaryRedColor),
                Text(
                  '$rssiValue dBm',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ) ),
        // SNR Card
        Container(
        width: 220,
        child : Card(
          color: const Color.fromARGB(255, 219, 175, 160),
          margin: const EdgeInsets.symmetric(vertical: 18.0),
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.signal_cellular_alt_outlined, color: primaryRedColor),
                Text(
                  '$snrValue db',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        )
      ],
    );
  }
}
