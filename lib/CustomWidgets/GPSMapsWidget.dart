import 'package:dashboard/Utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class GpsMapsWidget extends StatelessWidget {
  final double latitude;
  final double longitude;

  const GpsMapsWidget({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final mapHeight = screenHeight * 0.30;

    return SizedBox(
      height: mapHeight,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FlutterMap(
          mapController: MapController(),
          options: MapOptions(
            initialCenter: LatLng(latitude, longitude),
            initialZoom: 10.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.dashboard',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(latitude, longitude),
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.my_location,
                    color: primaryRedColor,
                    size: 36,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
