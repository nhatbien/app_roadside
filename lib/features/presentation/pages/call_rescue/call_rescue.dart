import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadside_assistance/features/presentation/blocs/location/location_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../widget/map/map_order.dart';
import '../drawer/drawer_page.dart';

class MapOrder extends StatefulWidget {
  const MapOrder({super.key});

  @override
  State<MapOrder> createState() => _MapOrderState();
}

class _MapOrderState extends State<MapOrder> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  void initState() {
    /*   BlocProvider.of<LocationBloc>(context)
        .add(SaveDirection(widget.placeId, RideType.bike)); */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const DrawerPage(),
      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          _buildSlideUpPanel(),
          _buildOpenDrawer(),
          _buildTextAddress()
          // _bottomSlide(),
        ],
      ),
    );
  }

  Widget _buildTextAddress() {
    return Positioned(
      left: MediaQuery.of(context).size.width / 2.5,
      top: 70,
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return Text(
            state.currentAddressLocation?.results[0].addressComponents[0]
                    .longName ??
                "",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 50),
          );
        },
      ),
    );
  }

  Widget _buildOpenDrawer() {
    return Positioned(
      left: 10,
      top: 40,
      child: FloatingActionButton(
        heroTag: "btn3",
        onPressed: () {
          _key.currentState?.openDrawer();
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.menu_rounded,
          color: Colors.black,
          size: 35,
        ),
      ),
    );
  }

  Widget _buildSlideUpPanel() {
    return const LocationMap();
  }
/* 
  Widget _buildListCart() {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: state.listbuy.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: (() {
                context.read<LocationBloc>().add(SaveDirection(
                    widget.placeId, state.listbuy[index].vehicle));
              }),
              child: Container(
                decoration: BoxDecoration(
                    color: state.selectionRide == state.listbuy[index].vehicle
                        ? Colors.blue[100]
                        : Colors.white),
                child: ListTileVehice(
                  title: state.listbuy[index].title,
                  price: state.directionData != null
                      ? (10000 *
                                  (state.directionData!.routes[0].legs[0]
                                              .distance.value /
                                          1000)
                                      .round() *
                                  state.listbuy[index].priceCoef)
                              .toString() +
                          " đ"
                      : "",
                  icon: state.listbuy[index].vehicle == RideType.bike
                      ? Image.asset(
                          "assets/images/motorcycle.png",
                        )
                      : Image.asset(
                          "assets/images/car.png",
                        ),
                ),
              ),
            );
          }),
        );
      },
    );
  } */

  Widget _buildBackArrow() {
    return Positioned(
      left: 10,
      top: 40,
      child: FloatingActionButton(
        heroTag: "btn4",
        onPressed: () {},
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _bottomSlide() {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      color: Colors.grey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildChooseOption(),
          const SizedBox(
            height: 10,
          ),
          _buildButtonBuy()
        ],
      ),
    );
  }

  Widget _buildChooseOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: const [
            Icon(Icons.payment),
            SizedBox(
              width: 5,
            ),
            Text("Tiền Mặt"),
          ],
        ),
        /*    GestureDetector(
            onTap: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChoosePromotion()));
            }),
            child:
                context.watch<LocationBloc>().state.selectionPromotion != null
                    ? Text(context
                        .watch<LocationBloc>()
                        .state
                        .selectionPromotion!
                        .code)
                    : Text("Ưu đãi")), */
      ],
    );
  }

  Widget _buildButtonBuy() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        )),
      ),
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Text("Đặt BieBike"),
          SizedBox(
            width: 30,
          ),
          Text("400.000đ"),
        ],
      ),
    );
  }
}

class BarIndicator extends StatelessWidget {
  const BarIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 15),
      child: Container(
        width: 40,
        height: 3,
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
