part of 'network_info_bloc.dart';

@freezed
class NetworkInfoState with _$NetworkInfoState {
  const factory NetworkInfoState.initial() = NetworkInitial;
  const factory NetworkInfoState.offline() = Offline;
  const factory NetworkInfoState.connected() = Connected;
}
