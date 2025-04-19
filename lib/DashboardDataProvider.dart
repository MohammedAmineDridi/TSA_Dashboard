import 'dart:async';
import 'package:dashboard/Utils/helpers.dart';

class DashboardDataProvider {
  // StreamControllers for each data point
  final _batteryLevelController = StreamController<double>.broadcast();
  final _temperatureController = StreamController<double>.broadcast();
  final _humidityController = StreamController<double>.broadcast();
  final _angles_X_Y_Z_Controller = StreamController<Map<String, double>>.broadcast();
  final _velocities_X_Y_Z_Controller = StreamController<Map<String, double>>.broadcast();
  final _accelerations_X_Y_Z_Controller = StreamController<Map<String, double>>.broadcast();
  final _gps_coords_maps_latitude_lognitude_Controller = StreamController<Map<String, double>>.broadcast();
  final _led_status_Controller = StreamController<LedStatus>.broadcast();
  final _barometerController = StreamController<double>.broadcast();
  final _snr_rssi_Controller = StreamController<Map<String,double>>.broadcast();

  // Methods to update each data point
  void updateBatteryLevel(double batteryLevel) {
    _batteryLevelController.add(batteryLevel);
  }

  void updateTemperature(double temperature) {
    _temperatureController.add(temperature);
  }

  void updateHumidity(double humidity) {
    _humidityController.add(humidity);
  }

  void updateAngles(Map<String, double> x_y_z_angles) {
    _angles_X_Y_Z_Controller.add(x_y_z_angles);
  }

  void updateVelocities(Map<String, double> x_y_z_velocities) {
    _velocities_X_Y_Z_Controller.add(x_y_z_velocities);
  }

  void updateAccelerations(Map<String, double> x_y_z_accelerations) {
    _accelerations_X_Y_Z_Controller.add(x_y_z_accelerations);
  }

  void updateGpsMapsCoords(Map<String,double> latitude_logintude) {
    _gps_coords_maps_latitude_lognitude_Controller.add(latitude_logintude);
  }

  void updateLedStatus(LedStatus status){
    _led_status_Controller.add(status); 
  }

  void updateBarometer(double barometer){
    _barometerController.add(barometer);
  }

  void updateRssiSnr(Map<String,double> snr){
    _snr_rssi_Controller.add(snr);
  }

  // Individual streams for each data point
  Stream<double> get batteryLevelStream => _batteryLevelController.stream;
  Stream<double> get temperatureStream => _temperatureController.stream;
  Stream<double> get humidityStream => _humidityController.stream;
  Stream<Map<String,double>> get angleX_Y_Z_Stream => _angles_X_Y_Z_Controller.stream;
  Stream<Map<String,double>> get velocitiesX_Y_Z_Stream => _velocities_X_Y_Z_Controller.stream;
  Stream<Map<String,double>> get accelerationsX_Y_Z_Stream => _accelerations_X_Y_Z_Controller.stream;
  Stream<Map<String,double>> get gpsLatitude_Longitude_Stream => _gps_coords_maps_latitude_lognitude_Controller.stream;
  Stream<LedStatus> get ledStatusStream => _led_status_Controller.stream;
  Stream<double> get barometerStream => _barometerController.stream;
  Stream<Map<String,double>> get snr_rssi_Stream => _snr_rssi_Controller.stream;

  // Close all controllers when done
  void dispose() {
  _batteryLevelController.close();
  _temperatureController.close();
  _humidityController.close();
  _angles_X_Y_Z_Controller.close();
  _velocities_X_Y_Z_Controller.close();
  _accelerations_X_Y_Z_Controller.close();
  _gps_coords_maps_latitude_lognitude_Controller.close();
  _led_status_Controller.close();
  _barometerController.close();
  _snr_rssi_Controller.close();
  }
}
