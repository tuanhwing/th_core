import 'package:flutter_test/flutter_test.dart';
import 'package:th_network/network/network.dart';

import 'package:th_network/th_network.dart';

void main() {

  Future<void> _getInfo() async {
    THResponse response = await THNetworkRequester().executeRequest(THRequestMethods.get, "/front/api/v1/settings/", queryParameters: {"attr_name": "Contact"});
    expect(response.code, 0);
  }

  Future<void> _login() async {
    final deviceInfo = {
      "device_code" : "device_code",
      'device_model': "deviceModel",
      'os_name': "osName",
      'os_version': "osVersion",
      'app_version': "app_version"
    };
    THResponse response = await THNetworkRequester().executeRequest(
        THRequestMethods.post,
        "/front/api/v1/user/login",
        data: {
          "login_id" : "dev01@gmail.com",
          "password" : "dev",
          "device" : deviceInfo
        }
    );
    expect(response.code, 0);
    expect(response.statusCode, 200);
  }

  test('test api', () async {
    THNetworkRequester().initialize("http://myapi-dev.com.vn");

    //Get method
    await _getInfo();

    //Post method
    await _login();

  });
}
