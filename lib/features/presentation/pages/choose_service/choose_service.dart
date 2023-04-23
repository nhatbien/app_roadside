import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadside_assistance/features/presentation/blocs/location/location_bloc.dart';
import 'package:roadside_assistance/features/presentation/blocs/order/order_bloc.dart';
import 'package:roadside_assistance/features/presentation/pages/choose_service/widget/dropdown_widget.dart';

import '../called_rescue/called_rescue.dart';

class ChooseServicePage extends StatefulWidget {
  const ChooseServicePage({super.key});

  @override
  State<ChooseServicePage> createState() => _ChooseServicePageState();
}

class _ChooseServicePageState extends State<ChooseServicePage> {
  @override
  void initState() {
    context.read<LocationBloc>().add(GetAddressFormLatLng());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    return BlocListener<OrderBloc, OrderState>(
      listenWhen: (previous, current) =>
          previous.statusCreatedOrder != current.statusCreatedOrder,
      listener: (context, state) {
        if (state.statusCreatedOrder == OrderStatusBloc.success) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CalledMapOrder(
                  orderId: state.order!.id!,
                ),
              ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chọn dịch vụ"),
        ),
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: "0916308704",
                      showCursor: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: const Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        fillColor: const Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                            color: const Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize),
                        hintText: "Phone Number",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.info_outline,
                                color: const Color(0xFF666666),
                                size: defaultIconSize,
                              ),
                              Flexible(
                                child: Text(
                                  " Địa chỉ của bạn sẽ được chúng tôi gửi đến nhà xe cứu hộ gần nhất",
                                  style: TextStyle(
                                    color: const Color(0xFF666666),
                                    fontFamily: defaultFontFamily,
                                    fontSize: defaultFontSize,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          )),
                    ),
                    BlocBuilder<LocationBloc, LocationState>(
                      builder: (context, state) {
                        if (state.status == LocationStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return TextFormField(
                          onChanged: (value) {
                            context
                                .read<OrderBloc>()
                                .add(AddressChanged(address: value));
                          },
                          initialValue: state.currentAddressLocation?.results[0]
                              .formattedAddress,
                          showCursor: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: const Color(0xFF666666),
                              size: defaultIconSize,
                            ),
                            fillColor: const Color(0xFFF2F3F5),
                            hintStyle: TextStyle(
                              color: const Color(0xFF666666),
                              fontFamily: defaultFontFamily,
                              fontSize: defaultFontSize,
                            ),
                            hintText: "Địa chỉ",
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.info_outline,
                              color: const Color(0xFF666666),
                              size: defaultIconSize,
                            ),
                            Flexible(
                              child: Text(
                                " Ghi chú: Vui lòng chọn đúng loại xe và dịch vụ bạn cần.",
                                style: TextStyle(
                                  color: const Color(0xFF666666),
                                  fontFamily: defaultFontFamily,
                                  fontSize: defaultFontSize,
                                  fontStyle: FontStyle.normal,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        )),
                    /*  const DropdownWidget(
                      items: [
                        "Xe Máy",
                        "Xe hơi",
                      ],
                      title: 'Chọn loại xe',
                    ),
                    const DropdownWidget(
                      items: [
                        "Hết xăng",
                        "Hỏng phanh",
                        "Hỏng động cơ",
                        "Mất chìa khóa",
                        "Cần kéo xe",
                        "Cần thay lốp",
                        "Bị kẹt xe",
                        "Khác",
                      ],
                      title: 'Chọn dịch vụ',
                    ), */
                    Card(
                        color: const Color(0xFFF2F3F5),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              context
                                  .read<OrderBloc>()
                                  .add(NoteChanged(note: value));
                            },
                            maxLines: 8, //or null
                            decoration: const InputDecoration.collapsed(
                                hintText: "Điền ghi chú (Không bắt buộc)"),
                          ),
                        )),
                    Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                        child: BlocBuilder<OrderBloc, OrderState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              //padding: EdgeInsets.all(17.0),
                              onPressed: () {
                                if (state.address.isEmpty) {
                                  context.read<OrderBloc>().add(AddressChanged(
                                      address: context
                                              .read<LocationBloc>()
                                              .state
                                              .currentAddressLocation
                                              ?.results[0]
                                              .formattedAddress ??
                                          ""));
                                }
                                context.read<OrderBloc>().add(CreatedOrder());
                              },
                              child: Text(
                                "Gọi ngay".toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Poppins-Medium.ttf',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              /*  color: Color(0xFFBC1F26),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              side: BorderSide(color: Color(0xFFBC1F26))), */
                            );
                          },
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state.statusCreatedOrder == OrderStatusBloc.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
