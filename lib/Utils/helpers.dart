import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/DashboardDataProvider.dart';

enum LedStatus { ON , OFF}

String databaseCollectionName = "DashboardData";

Color backgroundColor = const Color.fromARGB(59, 0, 0, 0).withOpacity(0.1); // old value : const Color.fromARGB(255, 57, 51, 63)

Color textColor = Colors.black.withOpacity(0.7);

Color primaryRedColor = const Color.fromARGB(255, 163, 47, 39);

String convertLedStatusToString(LedStatus status) {
  switch (status) {
    case LedStatus.ON:
      return "ON";
    case LedStatus.OFF:
      return "OFF";
    default:
      return "OFF";
  }
}

LedStatus convertFromStringToLedStatus(String status) {
  switch (status.toUpperCase()) {
    case "ON":
      return LedStatus.ON;
    case "OFF":
      return LedStatus.OFF;
    default:
      return LedStatus.OFF;
  }
}

void compareMapsAndUpdateValues(Map<String, dynamic> oldMap, Map<String, dynamic> newMap,{required DashboardDataProvider provider}) {
  for (var key in oldMap.keys) {
    // Skip comparing the timestamp field
    if (key == 'timestamp') continue;

    if (!newMap.containsKey(key)) {
      debugPrint("Key '$key' not found in second map.");
    } else {
      var oldvalue = oldMap[key];
      var newvalue = newMap[key];

      // Compare other types directly
      if (oldvalue != newvalue) {
        debugPrint("Value changed for key '$key': '$oldvalue' -> '$newvalue'");
        // update value by key
        switch (key) {
        case 'batteryLevel':
          provider.updateBatteryLevel((newvalue as num).toDouble());
          break;
        case 'temperature':
          provider.updateTemperature((newvalue as num).toDouble());
          break;
        case 'humidity':
          provider.updateHumidity((newvalue as num).toDouble());
          break;
        case 'barometer':
          provider.updateBarometer((newvalue as num).toDouble());
          break;
        case 'ledStatus':
          provider.updateLedStatus(
            newvalue.toString().toUpperCase() == 'ON'
              ? LedStatus.ON
              : LedStatus.OFF,
          );
          break;
        case 'angles_x_y_z':
                  provider.updateAngles({
                    'x': newvalue['x'],
                    'y': newvalue['y'],
                    'z': newvalue['z'],
                  });
              break;
              case 'velocities_x_y_z':
                  provider.updateVelocities({
                    'x': newvalue['x'],
                    'y': newvalue['y'],
                    'z': newvalue['z'],
                  });
              break;
              case 'accelerations_x_y_z':
                  provider.updateAccelerations({
                    'x': newvalue['x'],
                    'y': newvalue['y'],
                    'z': newvalue['z'],
                  });
              break;
              case 'gps_coords':
                  provider.updateGpsMapsCoords({
                    'latitude': newvalue['latitude'],
                    'longitude': newvalue['longitude'],
                  });  
              break;
              case 'rssi_snr':
                  provider.updateRssiSnr({
                    'rssi': newvalue['rssi'],
                    'snr': newvalue['snr'],
                  });
              break;
        default:
          debugPrint("No update method for key '$key'");
      }
      }
    }
  }
  // Check if there are any keys in the second map not in the first
  for (var key in newMap.keys) {
    // Skip comparing the timestamp field
    if (key == 'timestamp') continue;
    if (!oldMap.containsKey(key)) {
      debugPrint("Key '$key' not found in first map.");
    }
  }
}

 Future<Map<String, dynamic>?> getLastDashboardDataFilterTimeStamp() async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('DashboardData')
      .orderBy('timestamp', descending: true)
      .limit(1)
      .get();
  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.first.data();
  }
  return null;
  }
  
  Future<Map<String, dynamic>?> getSecondToLastDashboardDataFilterTimeStamp() async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('DashboardData')
      .orderBy('timestamp', descending: true)
      .limit(2)
      .get();
  debugPrint("last-1 document record is : ${querySnapshot.docs[1].data()}");
  return querySnapshot.docs[1].data(); // second-to-last document
  }

  Text customTextStyleWidget(String text,{required double fontsize}){
    return Text(
            text,
            style: TextStyle(
            fontFamily: 'RobotoSlab',
            fontSize: fontsize, 
            fontWeight: FontWeight.bold, 
            color: textColor,
            )
          );
  }
