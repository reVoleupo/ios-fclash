import 'dart:async';
import 'dart:convert';

import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';

import 'interface.dart';

/// iOS stub implementation of CoreHandlerInterface.
/// iOS does not support the Go core process model, so this stub
/// prevents the app from crashing on startup while returning safe defaults.
class IosCoreStub extends CoreHandlerInterface {
  final _completer = Completer<bool>()..complete(true);

  @override
  Completer get completer => _completer;

  @override
  FutureOr<bool> destroy() async => true;

  @override
  Future<String> preload() async => '';

  @override
  Future<bool> shutdown(_) async => true;

  @override
  Future<bool> startListener() async => true;

  @override
  Future<bool> stopListener() async => true;

  @override
  Future<T?> invoke<T>({
    required ActionMethod method,
    dynamic data,
    Duration? timeout,
  }) async {
    return null;
  }

  @override
  Future<bool> init(InitParams params) async => false;

  @override
  Future<bool> get isInit async => false;

  @override
  Future<bool> forceGc() async => false;

  @override
  Future<String> validateConfig(String path) async => '';

  @override
  Future<Result> getConfig(String path) async => Result.success({});

  @override
  Future<String> asyncTestDelay(String url, String proxyName) async {
    return json.encode(Delay(name: proxyName, value: -1, url: url));
  }

  @override
  Future<String> updateConfig(UpdateParams updateParams) async => '';

  @override
  Future<String> setupConfig(SetupParams setupParams) async => '';

  @override
  Future<ProxiesData> getProxies() async =>
      const ProxiesData(proxies: {}, all: []);

  @override
  Future<String> changeProxy(ChangeProxyParams changeProxyParams) async => '';

  @override
  Future<String> getExternalProviders() async => '';

  @override
  Future<String>? getExternalProvider(String externalProviderName) {
    return Future.value('');
  }

  @override
  Future<String> updateGeoData(String type) async => '';

  @override
  Future<String> sideLoadExternalProvider({
    required String providerName,
    required String data,
  }) async => '';

  @override
  Future<String> updateExternalProvider(String providerName) async => '';

  @override
  FutureOr<String> getTraffic(bool onlyStatisticsProxy) => '';

  @override
  FutureOr<String> getTotalTraffic(bool onlyStatisticsProxy) => '';

  @override
  FutureOr<String> getCountryCode(String ip) => '';

  @override
  FutureOr<String> getMemory() => '';

  @override
  FutureOr<void> resetTraffic() {}

  @override
  FutureOr<void> startLog() {}

  @override
  FutureOr<void> stopLog() {}

  @override
  Future<bool> crash() async => false;

  @override
  FutureOr<String> getConnections() => '';

  @override
  FutureOr<bool> closeConnection(String id) => false;

  @override
  FutureOr<String> deleteFile(String path) => '';

  @override
  FutureOr<bool> closeConnections() => false;

  @override
  FutureOr<bool> resetConnections() => false;
}

final iosCoreStub = IosCoreStub();
