import 'package:flutter/material.dart';
import 'package:roadside_assistance/features/presentation/widget/map/widget/ripple_animation.dart';

class MarkerVipPro extends StatelessWidget {
  const MarkerVipPro({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
