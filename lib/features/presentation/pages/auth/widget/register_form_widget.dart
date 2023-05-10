/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadside_assistance/features/presentation/blocs/auth/auth_bloc.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2.7,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xff060404)
                : Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border:
                Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Theme.of(context).hintColor.withOpacity(0.2),
              )
            ]),
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 27),
        width: MediaQuery.of(context).size.width / 1.1,
//              height: config.App(context).appHeight(55),
        child: Form(
          //key: _con!.loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _PhoneInput(),
              const SizedBox(height: 30),
              _PasswordInput(),
              const SizedBox(height: 30),
              _LoginButton(),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.user?.phone ?? "",
          key: const Key('loginForm_phoneInput_textField'),
          keyboardType: TextInputType.text,
          onChanged: (value) {
            if (value.isNotEmpty) {
              context.read<AuthBloc>().add(LoginPhoneChanged(phone: value));
            }
          },
          decoration: InputDecoration(
            labelText: "Phone",
            labelStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.7)
                    : Theme.of(context).colorScheme.secondary),
            contentPadding: const EdgeInsets.all(12),
            hintText: '',
            hintStyle:
                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
            prefixIcon: Icon(Icons.phone,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).colorScheme.secondary),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.2))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).hintColor.withOpacity(0.5))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).hintColor.withOpacity(0.2))),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.isHidePassword != current.isHidePassword,
      builder: (context, state) {
        return TextFormField(
          key: const Key('loginForm_passwordInput_textField'),

          keyboardType: TextInputType.text,
          //  onSaved: (input) => _con!.user.password = input,
          onChanged: (value) {
            context.read<AuthBloc>().add(LoginPasswordChanged(password: value));
          },
          obscureText: state.isHidePassword,
          decoration: InputDecoration(
            labelText: "Mật khẩu",
            labelStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.7)
                    : Theme.of(context).colorScheme.secondary),
            contentPadding: const EdgeInsets.all(12),
            hintText: '••••••••••••',
            hintStyle:
                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
            prefixIcon: Icon(Icons.lock_outline,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).colorScheme.secondary),
            suffixIcon: IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(HidePasswordChanged());
              },
              color: Theme.of(context).focusColor,
              icon: Icon(state.isHidePassword
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.2))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).hintColor.withOpacity(0.5))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).hintColor.withOpacity(0.2))),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return BlockButtonWidget(
          text: Text(
            state.status != AuthStatusBloc.loading
                ? "Đăng nhập"
                : 'Đang đăng nhập',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          color: state.status != AuthStatusBloc.loading
              ? Theme.of(context).colorScheme.secondary
              : Colors.grey,
          onPressed: state.status == AuthStatusBloc.loading
              ? () {}
              : () {
                  context.read<AuthBloc>().add(LoginSubmitted());
                },
        );
      },
    );
  }
}
 */