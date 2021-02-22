part of 'pages.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    Key key,
  }) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Order> _orderFinished = [];
  List<Order> _orderOngoing = [];
  int onSelectedStatus = 0;
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().showOngoingOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<OrderCubit, OrderState>(builder: (_, state) {
        if (state is OrderListLoaded) {
          state.order.forEach((order) {
            if (order.orderStatus == 'FINISHED') {
              _orderFinished.add(order);
            } else {
              _orderOngoing.add(order);
            }
          });
          return ListView(
              //physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                //TextDividerOrder(text: 'ACTIVE ORDER'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Chip(
                        backgroundColor:
                            (onSelectedStatus == 0) ? Colors.lightGreenAccent : HexColor('#d3d3d3'),
                        avatar: Icon(Icons.list_alt),
                        label: Text('Active Order'),
                      ),
                      onTap: () {
                        onSelectedStatus = 0;
                        _orderOngoing.clear();
                        setState(() {});
                      },
                    ),
                    InkWell(
                      child: Chip(
                        backgroundColor:
                            (onSelectedStatus != 0) ? Colors.lightGreenAccent : HexColor('#d3d3d3'),
                        avatar: Icon(Icons.done),
                        label: Text('Finished Order'),
                      ),
                      onTap: () {
                        onSelectedStatus = 1;

                        _orderFinished.clear();
                        setState(() {});
                      },
                    ),
                  ],
                ),
                (onSelectedStatus == 0)
                    ? Column(
                        children: _orderOngoing
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.only(
                                    top: (e == _orderOngoing.first) ? 0 : 0,
                                    bottom: (e == _orderOngoing.last) ? 15 : 0),
                                child: OrderCard(order: e),
                              ),
                            )
                            .toList(),
                      )
                    : Column(
                        children: _orderFinished
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.only(
                                    top: (e == state.order.first) ? 0 : 0,
                                    bottom: (e == state.order.last) ? 15 : 0),
                                child: OrderCard(order: e),
                              ),
                            )
                            .toList(),
                      ),
                // BlocBuilder<OrderFinishCubit, OrderFinishState>(
                //   builder: (_, states) => (states is OrderFinishListLoaded)
                //       ? ListView(
                //           shrinkWrap: true,
                //           physics: NeverScrollableScrollPhysics(),
                //           children: [
                //               TextDividerOrder(text: 'FINISH ORDER'),
                //               Column(
                //                 children: states.order
                //                     .map((e) => Padding(
                //                           padding: EdgeInsets.only(
                //                               top: (e == states.order.first) ? 0 : 0,
                //                               bottom: (e == states.order.last) ? 15 : 0),
                //                           child: GestureDetector(
                //                               onTap: () {}, child: OrderCard(order: e)),
                //                         ))
                //                     .toList(),
                //               ),
                //             ])
                //       : Padding(
                //           padding: const EdgeInsets.all(50.0),
                //           child: Center(child: CircularProgressIndicator()),
                //         ),
                // ),
              ]);
        } else {
          return Padding(
            padding: const EdgeInsets.all(50.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      }),
    );
  }
}
