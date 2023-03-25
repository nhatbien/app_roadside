import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadside_assistance/features/presentation/blocs/order/order_bloc.dart';
import 'package:roadside_assistance/features/presentation/widget/map/widget/ripple_animation.dart';

class MarkerVipPro extends StatelessWidget {
  const MarkerVipPro({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state.order != null) {
          return RippleAnimation(
            color: state.order!.status == 1
                ? Colors.deepOrange
                : state.order!.status == 2 || state.order!.status == 3
                    ? Colors.green
                    : Colors.red,
            delay: const Duration(milliseconds: 300),
            repeat: true,
            minRadius: 35,
            ripplesCount: 6,
            duration: const Duration(milliseconds: 6 * 300),
            child: const CircleAvatar(
              minRadius: 75,
              maxRadius: 75,
              backgroundImage: AssetImage(
                  "assets/img/user.png"), /* NetworkImage(
              "") */
            ),
          );
        }
        return const RippleAnimation(
          color: Colors.deepOrange,
          delay: Duration(milliseconds: 300),
          repeat: true,
          minRadius: 35,
          ripplesCount: 6,
          duration: Duration(milliseconds: 6 * 300),
          child: CircleAvatar(
            minRadius: 75,
            maxRadius: 75,
            backgroundImage: AssetImage(
                "assets/img/user.png"), /* NetworkImage(
              "") */
          ),
        );
      },
    );
  }
}
