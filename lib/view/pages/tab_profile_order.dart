part of 'pages.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    Key key,
  }) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().showOngoingOrder();
    context.read<OrderFinishCubit>().showFinishedOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.84,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (_, state) => (state is OrderListLoaded)
            ? ListView(shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                children: [
                    TextDividerOrder(text: 'ACTIVE ORDER'),
                    Column(
                      children: state.order
                          .map((e) => Padding(
                                padding: EdgeInsets.only(
                                    top: (e == state.order.first) ? 0 : 0,
                                    bottom: (e == state.order.last) ? 15 : 0),
                                child: GestureDetector(onTap: () {}, child: OrderCard(order: e)),
                              ))
                          .toList(),
                    ),
                    BlocBuilder<OrderFinishCubit, OrderFinishState>(
                      builder: (_, states) => (states is OrderFinishListLoaded)
                          ? ListView(shrinkWrap: true,
                              //physics: NeverScrollableScrollPhysics(),
                              children: [
                                  TextDividerOrder(text: 'FINISH ORDER'),
                                  Column(
                                    children: states.order
                                        .map((e) => Padding(
                                              padding: EdgeInsets.only(
                                                  top: (e == states.order.first) ? 0 : 0,
                                                  bottom: (e == states.order.last) ? 15 : 0),
                                              child: GestureDetector(
                                                  onTap: () {}, child: OrderCard(order: e)),
                                            ))
                                        .toList(),
                                  ),
                                ])
                          : Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                    ),
                  ])
            : Padding(
                padding: const EdgeInsets.all(50.0),
                child: Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }
}
