
import 'package:th_core/th_core.dart';

///abstract [THBaseBloc] class used to building your bloc
abstract class THBaseBloc<Event, State> extends Bloc<Event, State> {
  ///Constructor
  THBaseBloc(super.initialState) {
    _pageCubit = GetIt.I.get<THWidgetCubit>();
  }

  late THWidgetCubit _pageCubit;

  ///Get page cubit
  THWidgetCubit get pageCubit => _pageCubit;

  void _hideLoadingAndError() {
    _pageCubit.add(const WidgetInitial<void>());
  }

  ///Replace current widget
  ///by in progress ['inProgressWidget' in THState] widget
  void forceLoadingWidget() {
    _pageCubit.add(const WidgetLoading<void>());
  }

  ///Replace current widget
  /// by failure ['failureWidget' in THState] widget
  void forceErrorWidget() {
    _pageCubit.add(const WidgetError<void>());
  }

  ///Replace current widget
  /// by content ['content' in THState] widget
  void forceContentWidget() {
    _pageCubit.add(const WidgetLoaded<void>());
  }

  ///Show loading overlay on topmost
  void showLoading() {
    _pageCubit.add(const WidgetShowLoadingOverlay<void>());
  }

  ///Hide loading overlay
  void hideLoading() {
    _hideLoadingAndError();
  }

  ///Show error notification overlay
  void showError({String? title, required String message}) {
    _pageCubit.add(WidgetShowErrorNotifyOverlay<NotifyEntity>(
      data: NotifyEntity(
        title: title,
        message: message,
      ),
    ),);
  }

  ///Hide error notification overlay
  void hideError() {
    _hideLoadingAndError();
  }

  @override
  Future<void> close() {
    _pageCubit.close();
    return super.close();
  }
}
