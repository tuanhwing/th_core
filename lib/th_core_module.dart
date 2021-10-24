
import 'package:th_core/th_core.dart';
import 'package:th_dependencies/th_dependencies.dart';
import 'package:th_network/th_network.dart';

class THCoreModule {
  static GetIt get _injector => GetIt.I;

  ///Initialize core
  /// [baseURL] server's base URL
  static Future<void> initializeWith(String baseURL) async {

    SharedPreferences _preferences =  await SharedPreferences.getInstance();
    _injector.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
    _injector.registerLazySingleton<SharedPreferences>(() => _preferences);

    //Network requester
    THNetworkRequester requester = await THNetwork.getInstance(baseURL, _injector.get());
    _injector.registerLazySingleton<THNetworkRequester>(() => requester);

  }
}