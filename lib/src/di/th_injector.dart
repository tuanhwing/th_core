
import 'package:th_core/th_core.dart';

/// [THInjector] class responsible for injecting all core's dependencies
class THInjector {

  static GetIt get _injector => GetIt.I;

  ///Initialize core
  /// [baseURL] server's base URL
  static Future<void> initializeWith({
    required String baseURL,
    required String refreshTokenPath,
    required String logoutPath,
    String? authorizationPrefix,
  }) async {
    //Common
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _injector.registerLazySingleton<FlutterSecureStorage>(
          () => const FlutterSecureStorage(),
    );
    _injector.registerLazySingleton<SharedPreferences>(() => prefs);

    _injector.registerFactory<THWidgetCubit>(() => THWidgetCubit());

    //Network requester
    final THNetworkRequester requester = await THNetwork.getInstance(
      baseURL,
      _injector.get(),
      authorizationPrefix: authorizationPrefix,
      refreshTokenPath: refreshTokenPath,
      logoutPath: logoutPath,
      connectTimeout: 10000,
      receiveTimeout: 20000,
    );
    _injector.registerLazySingleton<THNetworkRequester>(() => requester);

    //Loading overlay
    _injector.registerLazySingleton<THOverlayHandler>(
          () => THOverlayHandler(),
    );
  }
}
