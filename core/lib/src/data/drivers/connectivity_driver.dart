import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;

import '../../infra/drivers/connectivity_driver.dart' show IConnectivityDriver;

class ConnectivityDriver implements IConnectivityDriver {
  final Connectivity connectivity;

  ConnectivityDriver({required this.connectivity});

  @override
  Future<bool> get isOnline async {
    var result = await connectivity.checkConnectivity();
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }
}
