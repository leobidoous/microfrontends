import 'package:connectivity_plus/connectivity_plus.dart';

import '../../infra/drivers/connectivity_driver.dart';

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
