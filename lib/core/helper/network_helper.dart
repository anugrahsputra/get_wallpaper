import 'package:connectivity_plus/connectivity_plus.dart';

import '../../injection.dart';
import '../../presentation/presentation.dart';

class NetworkHelper {
  static void checkConnection() {
    Connectivity().onConnectivityChanged.listen((result) {
      final NetworkInfoBloc networkInfo = locator<NetworkInfoBloc>();
      if (result == ConnectivityResult.none) {
        networkInfo.add(const ConnectionChanged(false));
      } else {
        networkInfo.add(const ConnectionChanged(true));
      }
    });
  }
}
