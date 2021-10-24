library th_network;

import 'package:th_network/th_network_requester.dart';
import 'package:th_dependencies/th_dependencies.dart';

export 'common/common.dart';
export 'th_network_requester.dart';
export 'network/network.dart';

class THNetwork {
  static Future<THNetworkRequester> getInstance(String baseURL, FlutterSecureStorage storage, {
    int connectTimeout=5000,
    int receiveTimeout=3000,
    String refreshTokenPath="/refresh_token"}) async {
    THNetworkRequester requester = THNetworkRequester(
      baseURL,
      storage,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      refreshTokenPath: refreshTokenPath
    );

    await requester.initialize();
    return requester;


  }
}

