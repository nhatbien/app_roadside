import 'package:flutter/material.dart';
import 'package:roadside_assistance/features/presentation/pages/call_rescue/call_rescue.dart';

import '../../widget/grid_icon_service.dart';

class CarPage extends StatefulWidget {
  const CarPage({super.key});

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return const MapOrder();
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () => _key.currentState!.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0x1cae81).withOpacity(1),
        title: const Text("Bảng dịch vụ"),
      ),
      //drawer: const NavigationDrawer(),
      backgroundColor: Colors.white,
      body: Stack(children: [
        _buildBody(),
/*         _buildOpenDrawer(),
 */
      ]),
    );
  }
/* 
  Widget _buildOpenDrawer() {
    return Positioned(
      left: 10,
      top: 40,
      child: FloatingActionButton(
        heroTag: "btn2",
        onPressed: () {
          _key.currentState?.openDrawer();
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.menu,
          color: Colors.black87,
        ),
      ),
    );
  } */

  Widget _buildBody() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  GridIconService(
                    images: 'assets/img/battery_icon.png',
                    title: 'Ắc quy',
                  ),
                  GridIconService(
                    images: 'assets/img/flat-tire.png',
                    title: 'Bánh xe',
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  GridIconService(
                    images: 'assets/img/locked-out.png',
                    title: 'Quên chìa khóa',
                  ),
                  GridIconService(
                    images: 'assets/img/ev.webp',
                    title: 'Hết xăng',
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  GridIconService(
                    images: 'assets/img/car-crash-2.webp',
                    title: 'Bị kẹt',
                  ),
                  GridIconService(
                    images: 'assets/img/car-crash.png',
                    title: 'Tai nạn',
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  GridIconService(
                    images: 'assets/img/car-dont-start.png',
                    title: 'Không khởi động được',
                  ),
                  GridIconService(
                    images: 'assets/img/town.png',
                    title: 'Cần Xe Kéo',
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              height: MediaQuery.of(context).size.height / 5.5,
              width: MediaQuery.of(context).size.width / 1.08,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/car-repair.png",
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Flexible(
                      child: Text(
                        "Khác".toUpperCase(),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 23),
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
