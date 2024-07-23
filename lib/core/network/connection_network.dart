import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionNetwork {
  Future<bool> get isConnected;
}

class ConnectionNetworkImpl implements ConnectionNetwork {
  final InternetConnection instance;
  ConnectionNetworkImpl(this.instance);
  @override
  Future<bool> get isConnected async {
    return Either.tryCatch(
      () async => await instance.hasInternetAccess,
      (o, s) => s.toString(),
    ).fold((l) => false, (r) => r);
  }
}
