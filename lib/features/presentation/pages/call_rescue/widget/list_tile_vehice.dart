import 'package:flutter/material.dart';

class ListTileVehice extends StatelessWidget {
  final String title;
  final String price;
  final Widget icon;
  const ListTileVehice(
      {super.key,
      required this.title,
      required this.price,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(3),
        width: MediaQuery.of(context).size.width / 7,
        /*  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ), */
        child: icon,
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        price,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
