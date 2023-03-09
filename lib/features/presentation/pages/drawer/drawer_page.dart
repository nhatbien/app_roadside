import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadside_assistance/core/helper/pref_manager.dart';
import 'package:roadside_assistance/core/routes/routes.dart';
import 'package:roadside_assistance/di/injector.dart';
import 'package:roadside_assistance/features/presentation/blocs/auth/auth_bloc.dart';
import 'package:roadside_assistance/features/presentation/pages/drawer/widget/drawer_item.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  void initState() {
    context.read<AuthBloc>().add(GetUserInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerWidget(),
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0, 24, 0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    DrawerItem(
                      name: 'Lịch sử cứu hộ',
                      icon: Icons.history,
                      onPressed: () => onItemPressed(context, index: 0),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DrawerItem(
                        name: 'Thông tin cá nhân',
                        icon: Icons.account_box_rounded,
                        onPressed: () => onItemPressed(context, index: 1)),
                    const SizedBox(
                      height: 30,
                    ),
                    const Divider(
                      thickness: 1,
                      height: 10,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DrawerItem(
                        name: 'Setting',
                        icon: Icons.settings,
                        onPressed: () => onItemPressed(context, index: 4)),
                    const SizedBox(
                      height: 30,
                    ),
                    DrawerItem(
                        name: 'Log out',
                        icon: Icons.logout,
                        onPressed: () => onItemPressed(context, index: 6)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        break;
      case 1:
        AppNavigator.push(Routes.editProfile);
        break;
      case 5:
        injector<PrefManager>().vehicleType = "";
        Navigator.of(context).pushNamed("/Home");
        break;
      case 6:
        context.read<AuthBloc>().add(AuthLogout());
        break;
    }
  }

  Widget headerWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 30, left: 30, right: 30),
      decoration: BoxDecoration(
        color: const Color(0x001cae81).withOpacity(1),
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage:
                    (state.user?.avatar != null && state.user?.avatar != ""
                            ? NetworkImage(state.user?.avatar ?? "")
                            : const AssetImage('assets/img/avatar.png'))
                        as ImageProvider<Object>?,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.user?.fullName ?? "",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(state.user?.phone ?? "",
                      style: const TextStyle(fontSize: 16, color: Colors.white))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
