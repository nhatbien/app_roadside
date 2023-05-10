import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:roadside_assistance/features/data/model/order/order_model.dart';

import '../../../domain/repository/order_repositoy.dart';

part 'history_order_event.dart';
part 'history_order_state.dart';

class HistoryOrderBloc extends Bloc<HistoryOrderEvent, HistoryOrderState> {
  final OrderRepository _orderRepository;

  HistoryOrderBloc(this._orderRepository) : super(HistoryOrderInitial()) {
    on<HistoryOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetHistoryOrder>(getHistoryOrder);
  }

  void getHistoryOrder(
      GetHistoryOrder event, Emitter<HistoryOrderState> emit) async {
    emit(HistoryOrderLoading());

    final data = await _orderRepository.getHistoryOrder();
    data.fold((l) {
      emit(HistoryOrderFailure(message: l.error ?? 'Error'));
    }, (r) {
      emit(HistoryOrderSuccess(orders: r.reversed.toList()));
    });
  }
}
