import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/core.dart';
import '../../../injection.dart';

part 'network_info_bloc.freezed.dart';
part 'network_info_event.dart';
part 'network_info_state.dart';

class NetworkInfoBloc extends Bloc<NetworkInfoEvent, NetworkInfoState> {
  NetworkInfoBloc._() : super((const NetworkInitial())) {
    on<CheckConnection>(_onCheckConnection);
    on<ConnectionChanged>(_onConnectionChange);
  }

  static final NetworkInfoBloc _instance = NetworkInfoBloc._();

  factory NetworkInfoBloc() => _instance;

  void _onCheckConnection(event, emit) {
    // NetworkHelper.checkConnection();
    locator<NetworkHelper>().checkConnection();
  }

  void _onConnectionChange(
    ConnectionChanged event,
    Emitter<NetworkInfoState> emit,
  ) {
    if (event.isConnected) {
      emit(const Connected());
    } else {
      emit(const Offline());
    }
  }
}
