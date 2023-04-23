import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:latlong2/latlong.dart';
import 'package:roadside_assistance/core/routes/routes.dart';
import 'package:roadside_assistance/features/presentation/blocs/location/location_bloc.dart';
import 'package:roadside_assistance/features/presentation/blocs/order/order_bloc.dart';
import 'package:roadside_assistance/ultils/helper.dart';

import '../../widget/map/map_called.dart';
import '../call_rescue/call_rescue.dart';
import '../drawer/drawer_page.dart';

class CalledMapOrder extends StatefulWidget {
  final int orderId;
  const CalledMapOrder({super.key, required this.orderId});

  @override
  State<CalledMapOrder> createState() => _CalledMapOrderState();
}

class _CalledMapOrderState extends State<CalledMapOrder> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  double initFabHeight = 120.0;
  double fabHeight = 0;
  double panelHeightOpen = 0;
  double panelHeightClosed = 195.0;
  double ratingStats = 0;
  @override
  void initState() {
    BlocProvider.of<OrderBloc>(context).add(GetOrder(widget.orderId));
    BlocProvider.of<OrderBloc>(context).add(ListenOrder(widget.orderId));
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<OrderBloc>(AppNavigator.navigatorKey.currentState!.context)
        .add(Reset());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const DrawerPage(),
      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          const LocationCalledMap(),
          _buildBottom(),
          _buildOpenDrawer(),
          _buildTextAddress()
          // _bottomSlide(),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return BlocConsumer<OrderBloc, OrderState>(
      listenWhen: (previous, current) =>
          previous.count != current.count &&
          previous.order?.status != current.order?.status,
      listener: (context, state) {
        if (state.order!.status == 4) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Thành công"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Bạn đã hoàn thành đơn hàng"),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          ratingStats = rating;
                        });
                      },
                    )
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.read<OrderBloc>().add(
                          StatsChanged(state.order!.id!, stats: ratingStats));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MapOrder()));
                    },
                    child: const Text("OK"),
                  )
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state.status == OrderStatusBloc.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          height: MediaQuery.of(context).size.height / 3.5,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleOrder(
                      color: state.order!.status! >= 1
                          ? Colors.green
                          : Colors.white,
                    ),
                    BarIndicator(
                      color:
                          state.order!.status! > 1 ? Colors.green : Colors.grey,
                    ),
                    CircleOrder(
                      color: state.order!.status! >= 2
                          ? Colors.green
                          : Colors.white,
                    ),
                    BarIndicator(
                      color:
                          state.order!.status! > 2 ? Colors.green : Colors.grey,
                    ),
                    CircleOrder(
                      color: state.order!.status! >= 3
                          ? Colors.green
                          : Colors.white,
                    ),
                    BarIndicator(
                      color:
                          state.order!.status! > 3 ? Colors.green : Colors.grey,
                    ),
                    CircleOrder(
                      color: state.order!.status! >= 4
                          ? Colors.green
                          : Colors.white,
                    ),
                  ],
                ),
              ),
              Text(
                Helper.orderStatusToText(state.order?.status ?? 0),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(state.order?.status == 1
                  ? "BieTru sẽ báo cho bạn khi có đơn vị cứu hộ nhận đơn"
                  : "Người cứu hộ của bạn là ${state.order?.rescueUnit?.name ?? ""} có SĐT : ${state.order?.rescueUnit?.phone ?? ""}"),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Địa chỉ :",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Flexible(
                            child: Text(
                              state.order!.address!.length > 20
                                  ? "${state.order!.address!.substring(0, 20)}..."
                                  : state.order?.address ?? "",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Tên :",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Flexible(
                            child: Text(
                              state.order?.user?.fullName ?? "",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "SĐT :",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Flexible(
                            child: Text(
                              state.order?.user?.phone ?? "",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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

  Widget _body() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(40.441589, -80.010948),
        zoom: 13,
        maxZoom: 15,
      ),
      children: [
        TileLayer(
            urlTemplate: "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png"),
        MarkerLayer(markers: [
          Marker(
              point: LatLng(40.441753, -80.011476),
              builder: (ctx) => const Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 48.0,
                  ),
              height: 60),
        ]),
      ],
    );
  }
}

class BarIndicator extends StatelessWidget {
  final Color? color;
  const BarIndicator({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 15),
      child: Container(
        width: 30,
        height: 2,
        decoration: BoxDecoration(
          color: color ?? Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}

class CircleOrder extends StatelessWidget {
  final Color? color;
  const CircleOrder({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: 50,
        height: 50,
      ),
    );
  }
}
