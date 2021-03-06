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
      child: BlocBuilder<OrderCubit, OrderState>(builder: (_, state) {
        if (state is OrderListLoaded) {
          return ListView(shrinkWrap: true, children: [
            TextDividerOrder(text: 'ACTIVE ORDER'),
            Column(
              children: state.order
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.only(
                          top: (e == state.order.first) ? 0 : 0,
                          bottom: (e == state.order.last) ? 15 : 0),
                      child: OrderCard(order: e),
                    ),
                  )
                  .toList(),
            )
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
