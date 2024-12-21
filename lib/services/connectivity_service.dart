part of 'services.dart';

typedef ConnectivityResultHandler = void Function(List<ConnectivityResult> result);

abstract class ConnectivityHandler {
  void onConnectivityChanged(ConnectivityResult connectivity);
}

class ConnectivityService {
  StreamSubscription<List<ConnectivityResult>>? _connectivity;

  static Future<bool> get isConnected async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.isNotEmpty && connectivityResult.first == ConnectivityResult.mobile ||
        connectivityResult.isNotEmpty && connectivityResult.first == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  void onConnectivityChanged(ConnectivityResultHandler handler) {
    _connectivity = Connectivity().onConnectivityChanged.listen(handler);
  }

  void dispose() {
    _connectivity?.cancel();
    _connectivity = null;
  }
}
