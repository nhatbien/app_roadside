part of 'auth_bloc.dart';

enum AuthStatusBloc {
  initial,
  loading,
  loaded,
  authenticated,
  unauthenticated,
  expiredToken,
  failure
}

class AuthState extends Equatable {
  //final UserEntity? auth;
  final String phone;
  final UserModel? user;
  final String password;
  final String messageError;
  final AuthStatusBloc status;
  final AuthStatusBloc registerStatus;
  final bool isHidePassword;
  const AuthState({
    this.phone = "",
    this.user,
    this.password = "",
    this.messageError = "",
    this.status = AuthStatusBloc.initial,
    this.registerStatus = AuthStatusBloc.initial,
    this.isHidePassword = true,
  });

  AuthState copyWith({
    AuthStatusBloc? status,
    AuthStatusBloc? registerStatus,
    bool? isHidePassword,
    String? phone,
    UserModel? user,
    String? password,
    String? messageError,
  }) {
    return AuthState(
      status: status ?? this.status,
      registerStatus: registerStatus ?? this.registerStatus,
      phone: phone ?? this.phone,
      user: user ?? this.user,
      password: password ?? this.password,
      messageError: messageError ?? this.messageError,
      isHidePassword: isHidePassword ?? this.isHidePassword,
    );
  }

  @override
  List<Object?> get props => [
        status,
        user,
        registerStatus,
        isHidePassword,
        phone,
        messageError,
        password,
      ];
}
