import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager {
  final Connectivity _connectivity = Connectivity();

  // Singleton instance
  static final NetworkManager _instance = NetworkManager._internal();

  factory NetworkManager() {
    return _instance;
  }

  NetworkManager._internal();

  // Check current connectivity status
  Future<bool> isConnected() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return _isConnectedResult(connectivityResult);
  }

  // Stream of connectivity changes
  Stream<bool> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged.map(_isConnectedResult);

  // Helper method to determine if the device is connected based on ConnectivityResult
  bool _isConnectedResult(ConnectivityResult result) {
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet;
  }

  // Method to check connectivity before making an API call
  Future<bool> checkConnectivityBeforeRequest() async {
    final isConnected = await this.isConnected();
    if (!isConnected) {
      throw NoInternetException();
    }
    return true;
  }
}

// Custom exception for no internet connection
class NoInternetException implements Exception {
  final String message;

  NoInternetException({this.message = "No internet connection available"});

  @override
  String toString() => message;
}
