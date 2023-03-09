import 'package:flutter/material.dart';

class GridIconService extends StatelessWidget {
  final String images;
  final String title;
  const GridIconService({super.key, required this.images, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 1.0,
        ),
        color: Colors.grey[100],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      height: MediaQuery.of(context).size.height / 4.5,
      width: MediaQuery.of(context).size.width / 2.2,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          images,
          width: MediaQuery.of(context).size.width / 4,
        ),
        const SizedBox(
          height: 3,
        ),
        Flexible(
          child: Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 23,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ]),
    );
  }
}
