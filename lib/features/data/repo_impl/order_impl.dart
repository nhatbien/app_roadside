import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:roadside_assistance/core/helper/pref_manager.dart';
import 'package:roadside_assistance/di/injector.dart';

import '../../domain/repository/order_repositoy.dart';
import '../model/order/order_model.dart';
import '../model/order/order_request.dart';
import '../resource/base_url.dart';
import '../resource/remote/client_api.dart';
import '../resource/remote/response/err_response.dart';

class OrderImpl implements OrderRepository {
  final ClientDio _clientDio;

  OrderImpl(this._clientDio);

  final _pref = injector<PrefManager>();

  @override
  Future<Either<ErrorResponse, OrderModel>> createOrder(
      OrderCreateRequest requestLogin) async {
    try {
      final response = await _clientDio.postJson(buildUrl('/order/save'),
          body: requestLogin.toJson(),
          headers: {
            "Authorization": "Bearer ${_pref.token}",
          });
      return Right(OrderResponse.fromJson(response.data).data!);
    } on DioError catch (e) {
      print(e);
      return Left(SingleMessageErrorResponse.fromJson(e.response?.data));
    }
  }

  @override
  Future<Either<ErrorResponse, bool>> putStatsOrder(
      double stats, int orderId) async {
    try {
      final response = await _clientDio.putJson(
        buildUrl('/order/$orderId'),
        body: {
          "stats": stats,
        },
        headers: {
          "Authorization": "Bearer ${_pref.token}",
        },
      );
      return Right(response.statusCode == 200);
    } on DioError catch (e) {
      print(e);
      return Left(SingleMessageErrorResponse.fromJson(e.response?.data));
    }
  }

  @override
  Future<Either<ErrorResponse, OrderModel>> getOrder(int orderId) async {
    try {
      final response =
          await _clientDio.getJson(buildUrl('/order/$orderId'), headers: {
        "Authorization": "Bearer ${_pref.token}",
      });
      return Right(OrderResponse.fromJson(response.data).data!);
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(SingleMessageErrorResponse.fromJson(e.response?.data));
      }
      return Left(SingleMessageErrorResponse(
        error: e.message ?? 'Error',
        status: false,
      ));
    }
  }

  @override
  Future<Either<ErrorResponse, List<OrderModel>>> getHistoryOrder() async {
    try {
      final response =
          await _clientDio.getJson(buildUrl('/order/history'), headers: {
        "Authorization": "Bearer ${_pref.token}",
      });
      return Right(ListOrderResponse.fromJson(response.data).data ?? []);
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(SingleMessageErrorResponse.fromJson(e.response?.data));
      }
      return Left(SingleMessageErrorResponse(
        error: e.message ?? 'Error',
        status: false,
      ));
    }
  }

  @override
  Future<bool> logout() async {
    _pref.logout();

    return true;
  }
}
