part of 'history_order_bloc.dart';

abstract class HistoryOrderState extends Equatable {
  const HistoryOrderState();

  @override
  List<Object> get props => [];
}

class HistoryOrderInitial extends HistoryOrderState {}

class HistoryOrderLoading extends HistoryOrderState {}

class HistoryOrderFailure extends HistoryOrderState {
  final String message;
  const HistoryOrderFailure({required this.message});
}

class HistoryOrderSuccess extends HistoryOrderState {
  final List<OrderModel> orders;
  const HistoryOrderSuccess({required this.orders});
}
