import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'DashboardDataProvider.dart';
import 'Utils/helpers.dart';

class DashboardDataListener {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DashboardDataProvider dashboardDataProvider;
  Map<String, dynamic> lastKnownData = {};

  DashboardDataListener({required this.dashboardDataProvider});

  void startListening() {
    _firestore.collection(databaseCollectionName).snapshots().listen((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        debugPrint("firebase firestore new data = ${snapshot.docs.last.data()}");
        final lastRecord = await getLastDashboardDataFilterTimeStamp();
        final lastSecondReocrd = await getSecondToLastDashboardDataFilterTimeStamp();
        debugPrint("compare last record = $lastRecord to / last second record = $lastSecondReocrd");
        compareMapsAndUpdateValues(lastSecondReocrd!,lastRecord!,provider: dashboardDataProvider);
      }
    }, onError: (error) {
      debugPrint("Error listening to Firestore: $error");
    });
  }
}