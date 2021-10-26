
import 'package:th_core/th_core.dart';
import 'package:th_dependencies/th_dependencies.dart';
import 'package:th_network/th_network.dart';

/// THCoreModule
class THCoreModule {
  static GetIt get _injector => GetIt.I;

  ///Initialize core
  /// [baseURL] server's base URL
  static Future<void> initializeWith(String baseURL) async {

    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _injector.registerLazySingleton<FlutterSecureStorage>(
          () => const FlutterSecureStorage(),
    );
    _injector.registerLazySingleton<SharedPreferences>(() => _prefs);

    //Network requester
    final THNetworkRequester requester = await THNetwork.getInstance(
        baseURL,
        _injector.get(),
    );
    _injector.registerLazySingleton<THNetworkRequester>(() => requester);

  }
}
