part of 'pages.dart';

class DetailOrderPage extends StatefulWidget {
  final String idOrder;
  DetailOrderPage({this.idOrder});
  @override
  _DetailOrderPageState createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  @override
  void initState() {
    super.initState();
    context.read<DetailorderCubit>().showDetailOrder(widget.idOrder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Detail Order', style: blackTextFont.copyWith()),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
              child: Container(
            width: MediaQuery.of(context).size.width - (2 * defaultMargin),
            height: MediaQuery.of(context).size.height * 0.84,
            alignment: Alignment.center,
            child: BlocBuilder<DetailorderCubit, DetailorderState>(
              builder: (_, state) => (state is DetailOrderListLoaded)
                  ? ListView(children: [
                      Column(
                        children: state.detailOrder
                            .map((e) => Padding(
                                  padding: EdgeInsets.only(
                                      top: (e == state.detailOrder.first) ? 0 : 0,
                                      bottom: (e == state.detailOrder.last) ? 0 : 0),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: DetailProductOrderTile(detail: e),
                                  ),
                                ))
                            .toList(),
                      ),
                    ])
                  : Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
            ),
          ))),
    );
  }
}

class DetailProductOrderTile extends StatelessWidget {
  final DetailOrder detail;
  DetailProductOrderTile({this.detail});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail.productName,
                        style: blackTextFont.copyWith(),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                      SizedBox(height: 3),
                      Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                              .format(detail.price),
                          style: redNumberFont.copyWith()),
                    ],
                  ),
                ),
                Text(' X  ', style: redNumberFont.copyWith(color: Colors.black)),
                Text(detail.amount.toString(), style: redNumberFont.copyWith(color: Colors.black)),
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                  'Subtotal: ' +
                      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                          .format(detail.subtotal),
                  style: redNumberFont.copyWith(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
