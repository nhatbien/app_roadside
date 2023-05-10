import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadside_assistance/core/helper/pref_manager.dart';
import 'package:roadside_assistance/di/injector.dart';
import 'package:roadside_assistance/features/data/model/user/user_model.dart';
import 'package:roadside_assistance/features/data/resource/remote/request/login_user.dart';
import 'package:roadside_assistance/features/domain/repository/auth_repository.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(const AuthState()) {
    on<AuthInit>(
      init,
    );
    on<GetUserInfo>(
      getProfile,
    );
    on<LoginSubmitted>(
      loginSubmit,
    );
    on<LoginPasswordChanged>(
      loginPasswordChanged,
    );
    on<LoginPhoneChanged>(
      loginPhoneChanged,
    );
    on<HidePasswordChanged>(
      hidePasswordChange,
    );

    on<AuthLogout>(
      logoutSubmit,
    );
    on<Register>(
      register,
    );
    on<AuthUnAuthenticated>(
      unauthenticated,
    );
    on<ExpiredToken>(
      expiredToken,
    );
  }
/* 
  void login(AuthEvent event, Emitter<AuthState> emit) async {
    final data = await _authLoginUseCase
        .execute(RequestLogin(phone: state.phone, password: state.password));

    if (data is DataSuccess && data.data != null) {}
    if (data is DataFailed) {}
  } */
  Future<void> register(Register event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      registerStatus: AuthStatusBloc.loading,
    ));
    final response = await _authRepository.register(event.registerRequest);
    response.fold((l) {
      emit(state.copyWith(
        registerStatus: AuthStatusBloc.failure,
        messageError: l.error,
      ));
    }, (r) {
      emit(state.copyWith(
        registerStatus: AuthStatusBloc.loaded,
      ));
    });
  }

  void loginSubmit(LoginSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      status: AuthStatusBloc.loading,
    ));

    /*  if (state.phone.length < 10) {
      emit(
        state.copyWith(
            status: AuthStatusBloc.failure,
            messageError: "Vui lòng kiểm tra đúng Số điện thoại"),
      );
      return;
    } */
    if (state.password.isEmpty) {
      emit(
        state.copyWith(
            status: AuthStatusBloc.failure,
            messageError: "Vui lòng điền đầy đủ mật khẩu"),
      );
      return;
    }

    final data = await _authRepository.login(LoginRequest(
      phone: state.phone,
      password: state.password,
    ));
    data.fold((l) {
      emit(state.copyWith(
        status: AuthStatusBloc.failure,
        messageError: l.error,
      ));
    }, (r) {
      injector<PrefManager>().token = r.token;
      emit(state.copyWith(
        status: AuthStatusBloc.authenticated,
        user: r,
      ));
    });
  }

  void getProfile(AuthEvent event, Emitter<AuthState> emit) async {
    /*   emit(state.copyWith(
      status: AuthStatusBloc.loading,
    )); */
    final data = await _authRepository.getProfile();
    data.fold((l) {
      emit(state.copyWith(
        // status: AuthStatusBloc.failure,
        messageError: l.error,
      ));
    }, (r) {
      emit(state.copyWith(
        //     status: AuthStatusBloc.authenticated,
        user: r,
      ));
    });
  }

  void unauthenticated(AuthUnAuthenticated event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      status: AuthStatusBloc.unauthenticated,
    ));
  }

  void expiredToken(ExpiredToken event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      status: AuthStatusBloc.expiredToken,
    ));
  }

  void logoutSubmit(AuthLogout event, Emitter<AuthState> emit) async {
    final data = await _authRepository.logout();

    emit(state.copyWith(
      status: AuthStatusBloc.unauthenticated,
    ));
  }

  void init(AuthInit event, Emitter<AuthState> emit) async {}

  void loginPhoneChanged(
      LoginPhoneChanged event, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        phone: event.phone,
      ),
    );
  }

  void hidePasswordChange(
      HidePasswordChanged event, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(isHidePassword: !state.isHidePassword),
    );
  }

  void loginPasswordChanged(
      LoginPasswordChanged event, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }
}
