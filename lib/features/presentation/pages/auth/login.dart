import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadside_assistance/core/routes/routes.dart';
import 'package:roadside_assistance/features/presentation/pages/auth/widget/block_button_widget.dart';

import '../../blocs/auth/auth_bloc.dart';

part 'widget/login_form_widget.dart';
part 'widget/contact_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatusBloc.failure) {
          print(1111);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 1),
            content: Text(state.messageError),
          ));
        }
        if (state.status == AuthStatusBloc.authenticated) {
          AppNavigator.push(Routes.home);
        }
      },
      child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
              //key: _con!.scaffoldKey,
              resizeToAvoidBottomInset: false,
              body: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: <Widget>[
                    _buildLogo(),
                    const LoginFormWidget(),
                    _buildRegister(),
                  ]))),
    );
  }

  Widget _buildLogo() {
    return Positioned(
      top: 0,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  "BITRU ".toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "HELP  ".toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ) /* Theme.of(context).brightness == Brightness.dark
                ? Image.asset('assets/img/logo_tach_black.png', height: 200)
                : Image.asset('assets/img/logo_tach.png', height: 200) */
            ,
          )),
    );
  }

  Widget _buildRegister() {
    return Positioned(
      bottom: MediaQuery.of(context).size.height / 5,
      child: MaterialButton(
          child: Row(
            children: [
              Text("Chưa có tài khoản? ",
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                      TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Theme.of(context).hintColor)))
            ],
          ),
          onPressed: () {
            AppNavigator.push(Routes.register);
          }),
    );
  }
}
