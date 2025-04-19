import 'package:dashboard/CustomWidgets/BarometerLevelWidget.dart';
import 'package:dashboard/CustomWidgets/GPSMapsWidget.dart';
import 'package:dashboard/CustomWidgets/LedStatusWidget.dart';
import 'package:dashboard/Utils/helpers.dart';
import 'package:flutter/material.dart';
import 'CustomWidgets/BatteryLevelIndicatorWidget.dart';
import 'CustomWidgets/ThermometerWidget.dart';
import 'CenericCustomCard/CustomCard.dart';
import 'CustomWidgets/Rocket3DModelWidget.dart';
import 'CustomWidgets/HumidityLevelIndicatorWidget.dart';
import 'CustomWidgets/SNR_RSSI_CardWidget.dart';
import 'DashboardDataProvider.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'DashboardDataListener.dart';

class DashboardMainScreen extends StatefulWidget {
  const DashboardMainScreen({super.key});

  @override
  State<DashboardMainScreen> createState() => _DashboardMainScreenState();
}

class _DashboardMainScreenState extends State<DashboardMainScreen> {
  final DashboardDataProvider dashboardDataProvider = DashboardDataProvider();
  late final DashboardDataListener dataListener;
  bool isInitialized = false;
  Map<String, dynamic>? lastRecord;

  @override
  void initState() {
    super.initState();
    initializeDashboard();
    dataListener = DashboardDataListener(dashboardDataProvider: dashboardDataProvider);
    dataListener.startListening();
  }

  void initializeDashboard() async {
    lastRecord = await getLastDashboardDataFilterTimeStamp();
    debugPrint("last record is = $lastRecord");
    setState(() {
      isInitialized = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isInitialized == true ? Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            
            _buildBatteryCard(),
            _buildTemperatureCard(),
            _buildIMUCard(),
            _buildHumidityCard(),
            _buildGPSCard(),
            _buildBarometerCard(),
            _buildLedStatusCard(),
            _buildSnrRssiCard(),            
          ],
        ),
      ),
    ) : Center(child: CircularProgressIndicator(color: backgroundColor));
  }

  Widget _buildBatteryCard() {
    return StreamBuilder<double>(
      stream: dashboardDataProvider.batteryLevelStream,
      builder: (context, snapshot) {
        final batteryLevel = snapshot.data ?? lastRecord!['batteryLevel'];
        return CustomCard(
          childWidget: BatteryLevelWidget(batteryLevelValue: batteryLevel),
          leftWidget: customTextStyleWidget("BatteryLevel(%)",fontsize: 14),
          rightWidget: customTextStyleWidget("${batteryLevel.toStringAsFixed(1)}%",fontsize: 14),
          spaceUnderText: 105,
        );
      },
    );
  }

  Widget _buildTemperatureCard() {
    return StreamBuilder<double>(
      stream: dashboardDataProvider.temperatureStream,
      builder: (context, snapshot) {
        final temperature = snapshot.data ?? lastRecord!['temperature'];
        return CustomCard(
          childWidget: ThermometerWidget(temperatureValue: temperature),
          leftWidget: customTextStyleWidget("Temperature(°C)",fontsize: 14),
          rightWidget: customTextStyleWidget("${temperature.toStringAsFixed(1)} °C",fontsize: 14),
          spaceUnderText: 1,
        );
      },
    );
  }

  Widget _buildIMUCard() {
  return CustomCard(
    childWidget: StreamBuilder<Map<String, double>>(
      stream: dashboardDataProvider.angleX_Y_Z_Stream,
      builder: (context, snapshot) {
        final angles = snapshot.data ?? lastRecord!['angles_x_y_z'];
        return Rocket3DWidget(
          angleX: angles['x'],
          angleY: angles['y'],
        );
      },
    ),
    leftWidget: Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customTextStyleWidget("ψ , θ , φ (rad)", fontsize: 14),
          customTextStyleWidget("ψ\u0307 , θ\u0307 , φ\u0307 (rad/s)", fontsize: 14),
          customTextStyleWidget("ψ\u0308 , θ\u0308 , φ\u0308 (rad/s²)", fontsize: 14),
        ],
      ),
    ),
    rightWidget: Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnglesText(),
          _buildVelocitiesText(),
          _buildAccelerationsText(),
        ],
      ),
    ),
    spaceUnderText: MediaQuery.of(context).size.height * 0.01,
  );
}

Widget _buildAnglesText() {
  return StreamBuilder<Map<String, double>>(
    stream: dashboardDataProvider.angleX_Y_Z_Stream,
    builder: (context, snapshot) {
      final data = snapshot.data ?? lastRecord!['angles_x_y_z'];
      return customTextStyleWidget(
        "${data['x']?.toStringAsFixed(1)} , ${data['y']?.toStringAsFixed(1)} , ${data['z']?.toStringAsFixed(1)}",
        fontsize: 14,
      );
    },
  );
}

Widget _buildVelocitiesText() {
  return StreamBuilder<Map<String, double>>(
    stream: dashboardDataProvider.velocitiesX_Y_Z_Stream,
    builder: (context, snapshot) {
      final data = snapshot.data ?? lastRecord!['velocities_x_y_z'];
      return customTextStyleWidget(
        "${data['x']?.toStringAsFixed(1)} , ${data['y']?.toStringAsFixed(1)} , ${data['z']?.toStringAsFixed(1)}",
        fontsize: 14,
      );
    },
  );
}

Widget _buildAccelerationsText() {
  return StreamBuilder<Map<String, double>>(
    stream: dashboardDataProvider.accelerationsX_Y_Z_Stream,
    builder: (context, snapshot) {
      final data = snapshot.data ?? lastRecord!['accelerations_x_y_z'];
      return customTextStyleWidget(
        "${data['x']?.toStringAsFixed(1)} , ${data['y']?.toStringAsFixed(1)} , ${data['z']?.toStringAsFixed(1)}",
        fontsize: 14,
      );
    },
  );
}

  Widget _buildHumidityCard() {
    return StreamBuilder<double>(
      stream: dashboardDataProvider.humidityStream,
      builder: (context, snapshot) {
        final humidity = snapshot.data ?? lastRecord!['humidity'];
        return CustomCard(
          childWidget: HumidityLevelWidget(
            currentValue: humidity,
            minValue: 0,
            maxValue: 100,
          ),
          leftWidget:customTextStyleWidget("Humidity(%)",fontsize: 14),
          rightWidget: customTextStyleWidget("${humidity.toStringAsFixed(1)} %",fontsize: 14),
          spaceUnderText: MediaQuery.of(context).size.height * 0.08,
        );
      },
    );
  }

  Widget _buildGPSCard() {
    return StreamBuilder<Map<String, double>>(
      stream: dashboardDataProvider.gpsLatitude_Longitude_Stream,
      builder: (context, snapshot) {
        final gps = snapshot.data ?? lastRecord!['gps_coords'];
        return CustomCard(
          childWidget: GpsMapsWidget(
            latitude: gps["latitude"] ,
            longitude: gps["longitude"],
          ),
          leftWidget: customTextStyleWidget("GPS Coords(°)",fontsize: 14),
          rightWidget:  customTextStyleWidget("lat:${gps["latitude"]?.toStringAsFixed(1)}° | long:${gps["longitude"]?.toStringAsFixed(1)}°",fontsize: 14),
          spaceUnderText: MediaQuery.of(context).size.height * 0.02,
        );
      },
    );
  }

  Widget _buildBarometerCard() {
    return StreamBuilder<double>(
      stream: dashboardDataProvider.barometerStream,
      builder: (context, snapshot) {
        final barometer = snapshot.data ?? lastRecord!['barometer'];
        return CustomCard(
          childWidget: BarometerLevelWidget(
            currentValue: barometer,
            minValue: 800,
            maxValue: 1200,
          ),
          leftWidget:customTextStyleWidget("Barometer(hPa)",fontsize: 14),
          rightWidget: customTextStyleWidget("${barometer.toStringAsFixed(1)} hPa",fontsize: 14),
          spaceUnderText: MediaQuery.of(context).size.height * 0.08,
        );
      },
    );
  }

  Widget _buildLedStatusCard() {
    return StreamBuilder<LedStatus>(
      stream: dashboardDataProvider.ledStatusStream,
      builder: (context, snapshot) {
        final status = snapshot.data ?? convertFromStringToLedStatus(lastRecord!['ledStatus']) ;
        return CustomCard(
          childWidget: LedStatusWidget(ledStatus: status),
          leftWidget: customTextStyleWidget("Led Status",fontsize: 14),
          rightWidget: customTextStyleWidget(convertLedStatusToString(status),fontsize: 14),
          spaceUnderText: MediaQuery.of(context).size.height * 0.08,
        );
      },
    );
  }

  Widget _buildSnrRssiCard() {
    return StreamBuilder<Map<String, double>>(
      stream: dashboardDataProvider.snr_rssi_Stream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? lastRecord!['rssi_snr'];
        return CustomCard(
          childWidget: SNR_RSSI_Widget(
            rssiValue: data["rssi"],
            snrValue: data["snr"],
          ),
          leftWidget: customTextStyleWidget("SNR(db) & RSSI(dbm)",fontsize: 14),
          rightWidget: customTextStyleWidget("${data["rssi"]?.toStringAsFixed(1)} dBm | ${data["snr"]?.toStringAsFixed(1)} dB",fontsize: 14),
          spaceUnderText: MediaQuery.of(context).size.height * 0.04,
        );
      },
    );
  }
}
