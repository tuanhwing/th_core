

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:th_core/th_core.dart';


///abstract [THModule] class used to building your module Widget
abstract class THModule extends StatelessWidget {
  ///Constructor
  THModule({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  ///The name of the first route to show.
  String get initialRoute;

  ///Called to generate a route for a given [RouteSettings].
  Route<dynamic>? generateRoutes(RouteSettings routeSettings) {
    Widget page = Scaffold(
      body: FailureWidget(
        title: tr('not_found').inCaps,
      ),
    );

    try {
      page = GetIt.I.get(instanceName: routeSettings.name);
    }
    catch(exception) {
      final String tag = '$runtimeType.generateRoutes';
      THLogger().e('$tag routeName:${routeSettings.name} exception:$exception');
    }
    return MaterialPageRoute<void>(
        builder: (_) => page,
        settings:routeSettings,
    );
  }

  Future<bool> _onWillPop<T>(bool didPop, T? result) async {
    final THOverlayHandler overlayHandler = GetIt.I.get<THOverlayHandler>();
    if (!overlayHandler.isShowing) {
      if (_navigatorKey.currentState!.canPop()) {
        _navigatorKey.currentState!.pop();
      }
      else {
        SystemNavigator.pop();
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    THLogger().d('$runtimeType build');
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: _onWillPop,
        child: Navigator(
          key: _navigatorKey,
          initialRoute: initialRoute,
          onGenerateRoute: generateRoutes,
        ),
    );
  }
}
