import 'package:connectivity_plus/connectivity_plus.dart';

import '../../injection.dart';
import '../../presentation/presentation.dart';

abstract class NetworkHelper {
  void checkConnection();
}

class NetworkHelperImpl implements NetworkHelper {
  @override
  void checkConnection() {
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
