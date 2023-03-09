import 'package:flutter/material.dart';

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget(
      {super.key,
      required this.color,
      required this.text,
      required this.onPressed});

  final Color color;
  final Text text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 2,
              offset: const Offset(0, 3))
        ],
        borderRadius: const BorderRadius.all(Radius.circular(100)),
      ),
      // ignore: deprecated_member_use
      child: MaterialButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(horizontal: 66, vertical: 14),
        color: color,
        shape: const StadiumBorder(),
        child: text,
      ),
    );
  }
}
