import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../data/model/user/user_model.dart';
import '../../data/resource/remote/request/login_user.dart';
import '../../data/resource/remote/response/err_response.dart';

abstract class AuthRepository {
  Future<Either<ErrorResponse, UserModel>> login(LoginRequest requestLogin);
  Future<Either<ErrorResponse, UserModel>> getProfile();
  Future<bool> logout();
}
