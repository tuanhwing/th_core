

import 'package:th_dependencies/th_dependencies.dart';

///WidgetState
abstract class THWidgetState<T> extends Equatable {
  ///Constructor
  const THWidgetState({this.data});
  ///Data
  final T? data;

  @override
  List<Object?> get props => <Object?>[data];
}

///WidgetLoading
class WidgetInitial<T> extends THWidgetState<T> {
  ///Constructor
  const WidgetInitial({super.data});
}

///WidgetLoading
class WidgetLoading<T> extends THWidgetState<T> {
  ///Constructor
  const WidgetLoading({super.data});
}

///WidgetLoaded
class WidgetLoaded<T> extends THWidgetState<T> {
  ///Constructor
  const WidgetLoaded({super.data});
}

///WidgetError
class WidgetError<T> extends THWidgetState<T> {
  ///Constructor
  const WidgetError({super.data});
}

///WidgetShowLoadingOverlay
class WidgetShowLoadingOverlay<T> extends THWidgetState<T> {
  ///Constructor
  const WidgetShowLoadingOverlay({super.data});
}

///WidgetShowErrorNotifyOverlay
class WidgetShowErrorNotifyOverlay<T> extends THWidgetState<T> {
  ///Constructor
  const WidgetShowErrorNotifyOverlay({super.data});
}
