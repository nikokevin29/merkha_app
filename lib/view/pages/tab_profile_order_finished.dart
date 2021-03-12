part of 'pages.dart';

class OrderPageFinished extends StatefulWidget {
  @override
  _OrderPageFinishedState createState() => _OrderPageFinishedState();
}

class _OrderPageFinishedState extends State<OrderPageFinished> {
  @override
  void initState() {
    super.initState();
    context.read<OrderFinishCubit>().showFinishedOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<OrderFinishCubit, OrderFinishState>(builder: (_, state) {
        if (state is OrderFinishListLoaded) {
          return ListView(shrinkWrap: true, children: [
            TextDividerOrder(text: 'FINISHED ORDER'),
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
