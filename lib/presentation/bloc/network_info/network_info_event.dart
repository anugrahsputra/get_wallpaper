part of 'network_info_bloc.dart';

@freezed
class NetworkInfoEvent with _$NetworkInfoEvent {
  const factory NetworkInfoEvent.checkConnection() = CheckConnection;
  const factory NetworkInfoEvent.connectionChanged(
      {@Default(false) bool isConnected}) = ConnectionChanged;
}
