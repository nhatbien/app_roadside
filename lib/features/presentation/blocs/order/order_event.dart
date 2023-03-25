part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderInit extends OrderEvent {}

class OrderLogout extends OrderEvent {}

class OrderUnOrderenticated extends OrderEvent {}

class ExpiredToken extends OrderEvent {}

class GetOrder extends OrderEvent {
  final int orderId;
  GetOrder(this.orderId);
}

class GetOrderListen extends OrderEvent {
  final int orderId;
  GetOrderListen(this.orderId);
}

class ListenOrder extends OrderEvent {
  final int orderId;
  ListenOrder(this.orderId);
}

class CreatedOrder extends OrderEvent {}

class Reset extends OrderEvent {}

class StopListen extends OrderEvent {}

class LoginProvinceChanged extends OrderEvent {
  final String province;
  LoginProvinceChanged({required this.province});
}

class AddressChanged extends OrderEvent {
  final String address;
  AddressChanged({required this.address});
}

class NoteChanged extends OrderEvent {
  final String note;
  NoteChanged({required this.note});
}

class HidePasswordChanged extends OrderEvent {}

class PutDeliveredEvent extends OrderEvent {
  final int orderId;
  final int orderStatusId;
  PutDeliveredEvent({
    required this.orderId,
    required this.orderStatusId,
  });
}
