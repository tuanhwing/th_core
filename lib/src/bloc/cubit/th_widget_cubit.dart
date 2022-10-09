
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:th_core/src/bloc/cubit/th_widget_state.dart';

///abstract [THWidgetCubit] used to manage state of page
class THWidgetCubit extends Cubit<THWidgetState<dynamic>> {
  ///Constructor
  THWidgetCubit() : super(const WidgetInitial<void>());

  ///Emit state
  void add<T>(THWidgetState<T> state) => emit(state);
}
