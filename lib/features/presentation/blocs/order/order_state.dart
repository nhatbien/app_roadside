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
  const OrderState({
    this.address = "",
    this.count = 0,
    this.order,
    this.note = "",
    this.messageError = "",
    this.status = OrderStatusBloc.initial,
    this.statusCreatedOrder = OrderStatusBloc.initial,
  });
  OrderState reset() {
    return const OrderState(
      status: OrderStatusBloc.initial,
      statusCreatedOrder: OrderStatusBloc.initial,
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
    String? address,
    OrderModel? order,
    String? note,
    int? count,
    String? messageError,
  }) {
    return OrderState(
      status: status ?? this.status,
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
        address,
        messageError,
        note,
      ];
}
