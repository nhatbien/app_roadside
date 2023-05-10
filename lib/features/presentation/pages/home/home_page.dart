import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadside_assistance/features/presentation/blocs/auth/auth_bloc.dart';

import '../call_rescue/call_rescue.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<AuthBloc>().add(GetUserInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MapOrder();
  }
}
