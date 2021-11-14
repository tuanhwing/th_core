

import 'package:flutter/material.dart';
import 'package:th_dependencies/th_dependencies.dart';
import 'package:th_logger/th_logger.dart';

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
  Route<dynamic>? generateRoutes(RouteSettings routeSettings) {
    Widget page = Scaffold(
      body: Center(
        child: Text(tr('not_found')),
      ),
    );

    try {
      page = GetIt.I.get(instanceName: routeSettings.name);
    }
    catch(exception) {
      final String tag = '${runtimeType.toString()}.generateRoutes';
      THLogger().e('$tag routeName:${routeSettings.name} exception:$exception');
    }
    return MaterialPageRoute<void>(
        builder: (_) => page,
        settings:routeSettings,
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    _backPlatformObserver.notify();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    THLogger().d('${runtimeType.toString()} build');
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Navigator(
          initialRoute: initialRoute,
          onGenerateRoute: generateRoutes,
        ),
    );
  }
}
