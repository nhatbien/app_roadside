import 'package:dartz/dartz.dart';

import '../../data/model/order/order_model.dart';
import '../../data/model/order/order_request.dart';
import '../../data/resource/remote/response/err_response.dart';

abstract class OrderRepository {
  Future<Either<ErrorResponse, OrderModel>> createOrder(
      OrderCreateRequest requestLogin);
  Future<Either<ErrorResponse, OrderModel>> getOrder(int orderId);
  Future<Either<ErrorResponse, List<OrderModel>>> getHistoryOrder();
  Future<Either<ErrorResponse, bool>> putStatsOrder(double stats, int orderId);
  Future<bool> logout();
}
