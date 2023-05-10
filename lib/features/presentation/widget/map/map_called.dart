import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:roadside_assistance/core/routes/routes.dart';
import 'package:roadside_assistance/features/presentation/blocs/location/location_bloc.dart';
import 'package:roadside_assistance/features/presentation/widget/map/widget/marker_widget.dart';
import 'package:roadside_assistance/features/presentation/widget/map/widget/scale_layout_widget.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../ultils/helper.dart';
import '../../blocs/order/order_bloc.dart';

class LocationCalledMap extends StatefulWidget {
  const LocationCalledMap({super.key});

  @override
  State<StatefulWidget> createState() => LocationCalledMapState();
}

class LocationCalledMapState extends State<LocationCalledMap>
    with TickerProviderStateMixin {
  late final MapController _mapController;
  Uint8List? sourceIcon;
  double pinPillPosition = -100;
  Timer? timeHandle;

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    _initData();
    /*  Future.delayed(const Duration(milliseconds: 1000), () {
      final location = context.read<LocationBloc>().state.currentLocation;
      if (location != null) updatePinOnMap(location);
    }); */
  }

  void _initData() async {
    //await loadDataProvine();

    setSourceAndDestinationIcons();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await Helper.getBytesFromAsset('assets/img/user.png', 80);
  }

  Future<void> _animatedMapMove(LatLng destLocation, double destZoom) async {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);
    final _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // Create a animation controller that has a duration and a TickerProvider.

    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation = CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn);

    _animationController.addListener(() {
      _mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.dispose();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.dispose();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return state.status == LocationStatus.loading
              ? Center(
                  child: SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.9),
                    strokeWidth: 3.3,
                  ),
                ))
              : FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    //bounds: state.bounds,
                    onPositionChanged: (position, hasGesture) {
                      /* if (timeHandle != null) {
                        timeHandle!.cancel();
                      }
                      timeHandle = Timer(const Duration(milliseconds: 300), () {
                        context.read<LocationBloc>().add(GetAddressFormLatLng(
                            LatLng(position.center!.latitude,
                                position.center!.longitude)));
                      }); */
                    },
                    keepAlive: true,
                    enableScrollWheel: true,
                    maxZoom: 18,
                    center: LatLng(
                        state.currentLocation?.latitude ?? 10.0380717,
                        state.currentLocation?.longitude ?? 105.7709829),
                    zoom: state.zoom,
                    // slideOnBoundaries: true,
                  ),
                  nonRotatedChildren: [
                    ScaleLayerWidget(
                        options: ScaleLayerPluginOption(
                      lineColor: Colors.blue,
                      lineWidth: 3,
                      textStyle:
                          const TextStyle(color: Colors.blue, fontSize: 12),
                      padding: const EdgeInsets.all(10),
                    )),
                  ],
                  children: [
                    TileLayer(
                      updateInterval: const Duration(milliseconds: 300),
                      /*  urlTemplate:
                                "https://mts1.google.com/vt/&x={x}&y={y}&z={z}",
               */
                      urlTemplate:
                          //'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          'https://www.google.com/maps/vt/pb=!1m4!1m3!1i{z}!2i{x}!3i{y}!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425',
                      // 'https://www.google.com/maps/vt/pb=!1m4!1m3!1i{z}!2i{x}!3i{y}!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425',
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    PolylineLayer(
                      polylineCulling: true,
                      polylines: [
                        Polyline(
                            strokeCap: StrokeCap.butt,
                            points: state.polylineListPoints,
                            strokeWidth: 5,
                            color: Colors.green),
                      ],
                    ),
                    AnimatedLocationMarkerLayer(
                      style: const LocationMarkerStyle(
                        marker: DefaultLocationMarker(),
                        markerSize: Size(40, 40),
                        markerDirection: MarkerDirection.heading,
                      ),
                      position: LocationMarkerPosition(
                        latitude: state.currentLocation?.latitude ?? 10.0380717,
                        longitude:
                            state.currentLocation?.longitude ?? 105.7709829,
                        accuracy: 0.2,
                      ),

                      //heading: _currentHeading,
                    ),
                    MarkerLayer(rotate: true, markers: [
                      Marker(
                          width: 45,
                          height: 45,
                          point: LatLng(
                              state.currentLocation?.latitude ?? 10.0380717,
                              state.currentLocation?.longitude ?? 105.7709829),
                          builder: (ctx) => const MarkerVipPro()),
                    ]),
                    BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        return state.order?.rescueUnit?.lat != null
                            ? MarkerLayer(rotate: true, markers: [
                                Marker(
                                  width: 80,
                                  height: 80,
                                  point: LatLng(state.order!.rescueUnit!.lat!,
                                      state.order!.rescueUnit!.lng!),
                                  builder: (ctx) => const Icon(
                                    Icons.location_pin,
                                    color: Colors.purple,
                                    size: 50,
                                  ),
                                ),
                              ])
                            : const SizedBox();
                      },
                    ),
                  ],
                );
        },
      ),
      floatingActionButton: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 13,
                  child: FloatingActionButton(
                      heroTag: "btn1",
                      key: const Key("callphone"),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Icon(
                        Icons.phone,
                        size: 35,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                      ),
                      onPressed: () {
                        launchUrlString("tel:1900 1234 5678");
                      }),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 16,
                    child: ElevatedButton(
                      onPressed: () {
                        AppNavigator.push(Routes.chooseSerivce);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                      child: const Text(
                          'Gọi cứu hộ ngay'), // Text hiển thị trên button
                    )),
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 13,
                    child: FloatingActionButton(
                        heroTag: "btn2",
                        key: const Key("updatelocation"),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: Icon(
                          Icons.my_location,
                          size: 35,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white,
                        ),
                        onPressed: () {
                          if (state.currentLocation != null) {
                            updatePinOnMap(state.currentLocation!);
                          }
                        }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void updatePinOnMap(Position location) {
    _animatedMapMove(LatLng(location.latitude, location.longitude), 15);
    // _mapController.move(LatLng(location.latitude, location.longitude), 15);
  }
/* 
  Future<void> updatePinOnMap(Position? location) async {
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM2,
      tilt: 0,
      bearing: 0,
      target: LatLng(location!.latitude, location.longitude),
    );
    if (_controller != null) {
      _controller?.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    }
    setState(() {
      var pinPosition = LatLng(location.latitude, location.longitude);
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');

      _markers.add(Marker(
          markerId: const MarkerId('sourcePin'),
          position: pinPosition, // updated position
          icon: BitmapDescriptor.fromBytes(sourceIcon ?? Uint8List(5))));
    });
  } */
}
