import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/pref_manager.dart';
import '../../../../di/injector.dart';

class SlashPage extends StatefulWidget {
  const SlashPage({super.key});

  @override
  State<SlashPage> createState() => _SlashPageState();
}

class _SlashPageState extends State<SlashPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(milliseconds: 500), onDoneLoading);
  }

  onDoneLoading() async {
    /*  if (_con!.isShow) {
      _con!.onBackPressed(context);
    } else { */
    final pref = injector<PrefManager>();
    if (pref.token == "" || pref.token == null) {
      Navigator.of(context).pushReplacementNamed('/Login');
    } else {
      if (pref.vehicleType == "" || pref.vehicleType == null) {
        Navigator.of(context).pushReplacementNamed('/Home');
      } else {
        switch (pref.vehicleType) {
          case "0":
            Navigator.of(context).pushReplacementNamed('/Car');
            break;
          case "1":
            Navigator.of(context).pushReplacementNamed('/Motorbike');
            break;
        }
      }
    }
    /* } */
  }

  @override
  Widget build(BuildContext context) {
    print('splashsrceen');
    return Scaffold(
      // key: _con.scaffoldKey,
      //drawer: DrawerScreen(),
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0x1cae81).withOpacity(1),
        ),
        child: const Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
