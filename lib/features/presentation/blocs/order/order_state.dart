part of 'order_bloc.dart';

enum OrderStatusBloc { initial, loading, success, expiredToken, failure }

class OrderState extends Equatable {
  //final UserEntity? order;
  final String address;
  final OrderModel? order;
  final int count;
  final String note;
  final String messageError;
  final OrderStatusBloc status;
  final OrderStatusBloc statusCreatedOrder;
  final OrderStatusBloc statusStatOrder;
  const OrderState({
    this.address = "",
    this.count = 0,
    this.order,
    this.note = "",
    this.messageError = "",
    this.status = OrderStatusBloc.initial,
    this.statusCreatedOrder = OrderStatusBloc.initial,
    this.statusStatOrder = OrderStatusBloc.initial,
  });
  OrderState reset() {
    return const OrderState(
      status: OrderStatusBloc.initial,
      statusCreatedOrder: OrderStatusBloc.initial,
      statusStatOrder: OrderStatusBloc.initial,
      address: "",
      count: 0,
      order: null,
      note: "",
      messageError: "",
    );
  }

  OrderState copyWith({
    OrderStatusBloc? status,
    OrderStatusBloc? statusCreatedOrder,
    OrderStatusBloc? statusStatOrder,
    String? address,
    OrderModel? order,
    String? note,
    int? count,
    String? messageError,
  }) {
    return OrderState(
      status: status ?? this.status,
      statusStatOrder: statusStatOrder ?? this.statusStatOrder,
      address: address ?? this.address,
      order: order ?? this.order,
      count: count ?? this.count,
      note: note ?? this.note,
      statusCreatedOrder: statusCreatedOrder ?? this.statusCreatedOrder,
      messageError: messageError ?? this.messageError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        count,
        order,
        statusCreatedOrder,
        statusStatOrder,
        address,
        messageError,
        note,
      ];
}
