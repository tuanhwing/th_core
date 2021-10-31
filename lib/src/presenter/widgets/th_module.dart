

import 'package:flutter/cupertino.dart';
import 'package:th_core/th_core.dart';

import '../../th_back_platform_observer.dart';

///abstract [THModule] class used to building your module Widget
abstract class THModule extends StatelessWidget {
  ///Constructor
  THModule({Key? key}) : super(key: key);

  final THBackPlatformObserver _backPlatformObserver = GetIt.I
      .get<THBackPlatformObserver>();

  ///The name of the first route to show.
  String get initialRoute;

  ///Called to generate a route for a given [RouteSettings].
  Route<dynamic>? generateRoutes(RouteSettings routeSettings);

  Future<bool> _onWillPop(BuildContext context) async {
    _backPlatformObserver.notify();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Navigator(
          initialRoute: initialRoute,
          onGenerateRoute: generateRoutes,
        ),
    );
  }
}
