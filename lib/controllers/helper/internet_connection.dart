import 'package:connectivity/connectivity.dart';

class InternetConnection {
  static Future<bool> check() async {
    bool isOnline;
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        isOnline = true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        isOnline = true;
      } else if (connectivityResult == ConnectivityResult.none) {
        isOnline = false;
      }
    } catch (_) {
      isOnline = false;
    }
    return isOnline;
  }
}
