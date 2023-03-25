import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:roadside_assistance/core/helper/pref_manager.dart';
import 'package:roadside_assistance/di/injector.dart';
import 'package:roadside_assistance/features/data/model/user/user_model.dart';
import 'package:roadside_assistance/features/domain/repository/auth_repository.dart';

import '../model/request_location_model.dart';
import '../resource/base_url.dart';
import '../resource/remote/client_api.dart';
import '../resource/remote/request/login_user.dart';
import '../resource/remote/response/err_response.dart';

class AuthImpl implements AuthRepository {
  final ClientDio _clientDio;

  AuthImpl(this._clientDio);

  final _pref = injector<PrefManager>();

  @override
  Future<Either<ErrorResponse, UserModel>> login(
      LoginRequest requestLogin) async {
    try {
      final response = await _clientDio.postJson(
        buildUrl('/user/signin'),
        body: requestLogin.toJson(),
      );
      return Right(UserResponse.fromJson(response.data).data);
    } on DioError catch (e) {
      print(e);
      return Left(SingleMessageErrorResponse.fromJson(e.response?.data));
    }
  }

  @override
  Future<Either<ErrorResponse, UserModel>> getProfile() async {
    try {
      final response =
          await _clientDio.getJson(buildUrl('/user/profile'), headers: {
        "Authorization": "Bearer ${_pref.token}",
      });
      return Right(UserResponse.fromJson(response.data).data);
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
  Future<Either<ErrorResponse, bool>> updateLocation(
      UpdateLocationRequest requestLogin) async {
    try {
      final response = await _clientDio.postJson(
          buildUrl('/user/update/location'),
          body: requestLogin.toJson(),
          headers: {
            "Authorization": "Bearer ${_pref.token}",
          });
      return Right(UserResponse.fromJson(response.data).status);
    } on DioError catch (e) {
      print(e);
      return Left(SingleMessageErrorResponse.fromJson(e.response?.data));
    }
  }

  @override
  Future<bool> logout() async {
    _pref.logout();

    return true;
  }
}
