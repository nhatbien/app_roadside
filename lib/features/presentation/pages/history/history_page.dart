import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadside_assistance/features/presentation/blocs/history/history_order_bloc.dart';

import 'order_item_widget.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({
    super.key,
  });

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    context.read<HistoryOrderBloc>().add(GetHistoryOrder());

    super.initState();
  }

  Future<void> onRefresh() async {
    context.read<HistoryOrderBloc>().add(GetHistoryOrder());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.grey.shade100,
      appBar: buildAppBar(context),
      body: RefreshIndicator(
        color: Theme.of(context).colorScheme.secondary,
        onRefresh: onRefresh,
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: BlocBuilder<HistoryOrderBloc, HistoryOrderState>(
              builder: (context, state) {
                if (state is HistoryOrderLoading) {
                  return Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                        strokeWidth: 3.3,
                      ),
                    ),
                  );
                }
                if (state is HistoryOrderFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (state is HistoryOrderSuccess) {
                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 5,
                    ),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) {
                      return MyOrderHistoryItemWidget(
                        order: state.orders.elementAt(index),
                        statusFontSize: true,
                        onTap: () {
                          /*     Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderPage(
                                        orderId: state.orders
                                            .elementAt(index)
                                            .id
                                            .toString(),
                                        function: () async {},
                                      ))).then((value) async {}); */
                        },
                      );
                    },
                  );
                }
                return Container();
              },
            )),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Theme.of(context).colorScheme.secondary,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Column(
        children: [
          Text(
            "ssssss",
            style: Theme.of(context).textTheme.titleLarge!.merge(TextStyle(
                letterSpacing: 1.3,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).colorScheme.secondary,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
