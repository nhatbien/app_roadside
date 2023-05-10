import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadside_assistance/core/routes/routes.dart';
import 'package:roadside_assistance/features/presentation/blocs/auth/auth_bloc.dart';

import '../../../data/resource/remote/request/login_user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showPassword = false;
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Đăng ký tài khoản",
                style: TextStyle(color: Colors.green)),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 1,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.green,
              ),
              onPressed: () {
                AppNavigator.pop();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.green,
                ),
                onPressed: () {
                  /* Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SettingsPage())); */
                },
              ),
            ],
          ),
          body: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      buildTextField(
                        "Họ tên",
                        _fullNameController,
                      ),
                      buildTextField(
                        "SĐT",
                        _phoneController,
                      ),
                      /*                   buildTextField("Password", "********", true),
                 */
                      buildTextField("Địa chỉ", _addressController),
                      buildTextField("Tuổi", _ageController),
                      buildTextField("Password", _passwordController),
                      buildTextField("UserName", _userName),
                      buildTextField("Email", _email),
                      MaterialButton(
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Đăng ký',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                            )),
                        onPressed: () {
                          context.read<AuthBloc>().add(Register(
                                  registerRequest: RegisterRequest(
                                fullName: _fullNameController.text,
                                phone: _phoneController.text,
                                address: _addressController.text,
                                email: _email.text,
                                age: int.parse(_ageController.text),
                                password: _passwordController.text,
                                username: _userName.text,
                              )));
                        },
                      ),
                      Text(
                        state.registerStatus == AuthStatusBloc.loaded
                            ? 'Đăng ký thành công'
                            : '',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        state.registerStatus == AuthStatusBloc.failure
                            ? state.messageError
                            : '',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        child: Text("Trở về trang đăng nhập"),
                        onTap: () {
                          AppNavigator.pop();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          /*  OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {},
                        child: Text("CANCEL",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      ) */
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        BlocBuilder<AuthBloc, AuthState>(
          bloc: context.read<AuthBloc>(),
          builder: (context, state) {
            if (state.registerStatus == AuthStatusBloc.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        )
      ],
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
