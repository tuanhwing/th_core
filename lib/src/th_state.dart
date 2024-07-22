import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:th_core/th_core.dart';

///abstract [THState] class used to building your StatefulWidget(Page)
abstract class THState<FWidget extends StatefulWidget,
        FBloc extends THBaseBloc<dynamic, dynamic>> extends State<FWidget>
    with WidgetsBindingObserver,AutomaticKeepAliveClientMixin<FWidget> {

  late THOverlayHandler _overlayHandler;

  ///OverlayHandler manage show/hide loading/error
  THOverlayHandler get overlayHandler => _overlayHandler;

  ///Bloc of current state
  late FBloc _bloc;

  ///Get bloc of current state
  FBloc get bloc => _bloc;

  ///Get ThemeData
  ThemeData get themeData => Theme.of(context);

  ///Get screen size
  Size get screenSize => MediaQuery.of(context).size;

  ///Content of page
  Widget get content;

  ///AppBar of page
  PreferredSizeWidget? get appBar => null;

  ///Floating widget of page
  Widget? get floatingActionButton => null;

  ///Bottom navigation bar
  Widget? get bottomNavigationBar => null;

  ///The scaffold's floating widgets should size
  ///themselves to avoid the onscreen keyboard whose height is defined
  bool get resizeToAvoidBottomInset => true;

  ///extendBody
  bool get extendBody => false;

  ///In progress widget when [THFetchInProgressState] called
  Widget get inProgressWidget => const InProgressWidget();

  ///Failure widget when [THFetchFailureState] called
  Widget get failureWidget => FailureWidget(onRetry: onRetry,);

  ///Loading widget when [THShowLoadingOverlayState] called
  Widget get loadingWidget => const LoadingWidget();

  ///Background color
  Color? get backgroundColor => null;

  ///Responsible for determining where the [floatingActionButton] should go.
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  ///Dismiss the on screen keyboard
  void dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  ///Show notify popup
  void showNotifyPopup({
    Widget? title,
    required Widget content,
    String? positive,
    String? negative,
    VoidCallback? onPositiveTap,
    VoidCallback? onNegativeTap,
    bool useRootNavigator = false,
    bool barrierDismissible = true,
  }) {
    final List<CupertinoDialogAction> actions = <CupertinoDialogAction>[];
    if (negative != null) {
      actions.add(CupertinoDialogAction(
        onPressed: onNegativeTap,
        child: Text(negative),
      ),);
    }

    if (positive != null) {
      actions.add(CupertinoDialogAction(
        onPressed: onPositiveTap,
        child: Text(positive),
      ),);
    }

    showCupertinoModalPopup<void>(
      context: context,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: title,
        content: content,
        actions: actions,
      ),
    );
  }

  ///Error widget when [THShowErrorOverlayState] called
  Widget errorWidget(String message,
      {
        String? title,
        String? okString,
        VoidCallback? onOK,
      }) {
    return ErrorPopUpOverlayWidget(
      message: message.inCaps,
      title: title,
      okString: okString,
      overlayHandler: _overlayHandler,
    );
  }

  ///Detect rebuild when condition expected
  bool _buildWhen(
      THWidgetState<dynamic> previous, THWidgetState<dynamic> current,) {
    if (previous is WidgetInitial) {
      return current is WidgetLoading ||
          current is WidgetError ||
          current is WidgetLoaded;
    }
    if (previous is WidgetLoading) {
      return current is WidgetError ||
          current is WidgetLoaded;
    }
    if (previous is WidgetError) {
      return current is WidgetLoading ||
          current is WidgetLoaded;
    }
    if (previous is WidgetLoaded) {
      return current is WidgetError ||
          current is WidgetLoading;
    }
    return false;
  }

  ///Called when cubit's state changed
  @mustCallSuper
  void onPageStateChanged(THWidgetState<dynamic> state) {
    THLogger().d('$runtimeType.onPageStateChanged: $state');
    if (state is WidgetInitial) {
      _overlayHandler.hide();
    } else if (state is WidgetShowLoadingOverlay) {
      _overlayHandler.showLoading(context, loadingWidget: loadingWidget);
    } else if (state is WidgetShowErrorNotifyOverlay &&
        state.data is NotifyEntity) {
      final NotifyEntity entity = state.data as NotifyEntity;
      _overlayHandler.showError(
        context,
        errorWidget: errorWidget(entity.message, title: entity.title),
      );
    }
  }

  ///Handle event user tap outside
  void handleOutsideTap() {
  }

  ///Handle retry function when state is [THFetchFailureState]
  void onRetry() {}

  ///Post-frame
  void onPostFrame() {}

  ///The application is visible and responding to user input.
  void onResume() {}

  /// The application is not currently visible to the user, not responding to
  /// user input, and running in the background.
  void onPause() {}

  /// The application is still hosted on a flutter engine but is detached from
  /// any host views.
  void onDetach() {}

  /// The application is in an inactive state and is not receiving user input.
  void onInactive() {}

  ///All views of an application are hidden
  void onHidden() {}

  @override
  bool get wantKeepAlive => false;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    THLogger().d('$runtimeType.initState');

    // Initialize
    _bloc = GetIt.I.get<FBloc>();
    _overlayHandler = GetIt.I.get<THOverlayHandler>();

    // Add the observer
    WidgetsBinding.instance.addObserver(this);

    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
      onPostFrame();
    });
  }

  @override
  Widget build(BuildContext context) {
    THLogger().d('$runtimeType.build');
    if (wantKeepAlive) super.build(context);

    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<FBloc>.value(value: _bloc),
        BlocProvider<THWidgetCubit>.value(value: _bloc.pageCubit),
      ],
      child: GestureDetector(
        onTap: handleOutsideTap,
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: appBar,
          extendBody: extendBody,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          body: BlocConsumer<THWidgetCubit, THWidgetState<dynamic>>(
            listener: (BuildContext context, THWidgetState<dynamic> state) {
              onPageStateChanged(state);
            },
            buildWhen: _buildWhen,
            builder: (BuildContext context, THWidgetState<dynamic> state) {
              THLogger().d('$runtimeType.build $state');
              if (state is WidgetLoading) {
                return inProgressWidget;
              }
              if (state is WidgetError) {
                return failureWidget;
              }
              return content;
            },
          ),
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
        ),
      ),
    );
  }

  @override
  @mustCallSuper
  void dispose() {
    // Remove the observer
    WidgetsBinding.instance.removeObserver(this);
    bloc.close();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!mounted) return;
    switch (state) {
      case AppLifecycleState.resumed:
        // widget is resumed
        onResume();
      case AppLifecycleState.inactive:
        // widget is inactive
        onInactive();
      case AppLifecycleState.paused:
        // widget is paused
        onPause();
      case AppLifecycleState.detached:
        // widget is detached
        onDetach();
      case AppLifecycleState.hidden:
        // all views is hidden
        onHidden();
      default:
        break;
    }
  }
}
