import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadside_assistance/features/data/model/order/order_request.dart';
import 'package:roadside_assistance/features/data/resource/remote/request/login_user.dart';

import '../../../data/model/order/order_model.dart';
import '../../../domain/repository/order_repositoy.dart';

part 'order_state.dart';
part 'order_event.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;
  OrderBloc(this._orderRepository) : super(const OrderState()) {
    on<GetOrder>(getOrder);
    on<CreatedOrder>(createOrder);
    on<AddressChanged>(addressChanged);
    on<NoteChanged>(noteChanged);
    on<GetOrderListen>(getOrderListen);
    on<ListenOrder>(listenOrder);
    on<StopListen>(stopListen);
    on<Reset>(reset);
    on<StatsChanged>(statsOrder);
  }
  StreamSubscription<int>? _subscription;

/* 
  void login(OrderEvent event, Emitter<OrderState> emit) async {
    final data = await _orderLoginUseCase
        .execute(RequestLogin(address: state.address, password: state.password));

    if (data is DataSuccess && data.data != null) {}
    if (data is DataFailed) {}
  } */
  void reset(Reset event, Emitter<OrderState> emit) async {
    emit(const OrderState());
    _subscription?.cancel();
  }

  void createOrder(CreatedOrder event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
      statusCreatedOrder: OrderStatusBloc.loading,
    ));

    final data = await _orderRepository.createOrder(OrderCreateRequest(
      note: state.address,
      address: state.address,
    ));
    data.fold((l) {
      emit(state.copyWith(
        statusCreatedOrder: OrderStatusBloc.failure,
        messageError: l.error,
      ));
    }, (r) {
      emit(state.copyWith(
        statusCreatedOrder: OrderStatusBloc.success,
        order: r,
      ));
    });
  }

  void statsOrder(StatsChanged event, Emitter<OrderState> emit) async {
    _subscription?.cancel();
    final data = await _orderRepository.putStatsOrder(
      event.stats,
      event.orderId,
    );
    data.fold((l) {
      Fluttertoast.showToast(
          msg: l.error ?? "Lỗi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }, (r) {
      Fluttertoast.showToast(
          msg: "Thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void getOrder(GetOrder event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
      status: OrderStatusBloc.loading,
    ));
    final data = await _orderRepository.getOrder(event.orderId);

    data.fold((l) {
      emit(state.copyWith(
        status: OrderStatusBloc.failure,
        messageError: l.error,
      ));
    }, (r) {
      emit(state.copyWith(
        status: OrderStatusBloc.success,
        order: r,
      ));
    });
  }

  void listenOrder(ListenOrder event, Emitter<OrderState> emit) async {
    _subscription?.cancel();
    _subscription = Stream.periodic(const Duration(seconds: 5), (i) {
      return i;
    }).listen(
      ((_) => add(
            GetOrderListen(
              event.orderId,
            ),
          )),
    );
  }

  void getOrderListen(GetOrderListen event, Emitter<OrderState> emit) async {
    final data = await _orderRepository.getOrder(event.orderId);

    data.fold((l) {
      emit(state.copyWith(
        status: OrderStatusBloc.failure,
        messageError: l.error,
      ));
    }, (r) {
      emit(state.copyWith(
        count: state.count + 1,
        order: r,
      ));
    });
  }

  void stopListen(StopListen event, Emitter<OrderState> emit) async {
    _subscription?.cancel();
  }

  void addressChanged(AddressChanged event, Emitter<OrderState> emit) async {
    emit(
      state.copyWith(
        address: event.address,
      ),
    );
  }

  void noteChanged(NoteChanged event, Emitter<OrderState> emit) async {
    emit(
      state.copyWith(
        note: event.note,
      ),
    );
  }
}
