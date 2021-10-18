import 'package:flutter_test/flutter_test.dart';

import 'package:th_secure_storage/th_secure_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SharedPreferences preferences;

  setUp(() async {
    preferences = await SharedPreferences.getInstance();
  });

  test('shared preferences', () async {
    int counter = 1;
    // preferences.setInt('counter', counter);
    // preferences.getInt('counter');
    // expect(preferences.getInt('counter'), counter);
    //
    // preferences.remove('counter');
    // expect(prefs.getInt('counter'), null);
  });
}
