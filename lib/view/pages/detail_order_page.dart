part of 'pages.dart';

class DetailOrderPage extends StatefulWidget {
  final Order order;
  DetailOrderPage({this.order});
  @override
  _DetailOrderPageState createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  @override
  void initState() {
    super.initState();
    context.read<DetailorderCubit>().showDetailOrder(widget.order.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        context.read<DetailorderCubit>().showDetailOrder(widget.order.id.toString());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Detail Order', style: blackTextFont.copyWith()),
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
              context.read<DetailorderCubit>().clear();
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
                                      child: DetailProductOrderTile(detail: e, order: widget.order),
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
      ),
    );
  }
}

class DetailProductOrderTile extends StatelessWidget {
  final DetailOrder detail;
  final Order order;
  DetailProductOrderTile({this.detail, this.order});

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
                              .format(detail.productPrice),
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
            (order.orderStatus == 'FINISHED')
                ? Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        _reviewProductBottomSheet(context, detail);
                      },
                      child: Text('Review Product'),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void _reviewProductBottomSheet(BuildContext context, DetailOrder detail) {
    TextEditingController reviewMerchantController = new TextEditingController();
    double valueProduct;
    bool status = false;
    showModalBottomSheet(
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black.withAlpha(1),
        builder: (builder) {
          return Container(
            alignment: Alignment.topCenter,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.close, color: Colors.white),
                            GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(Icons.close, color: Colors.black)),
                          ],
                        ),
                        Text(
                          "Let`s Rate & Review This Product",
                          style: blackMonstadtTextFont.copyWith(fontSize: 14),
                        ),
                        SmoothStarRating(
                          starCount: 5,
                          rating: 0,
                          size: 40.0,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half,
                          color: Colors.yellowAccent,
                          borderColor: Colors.grey[400],
                          onRated: (v) {
                            valueProduct = v;
                          },
                        ),
                        Divider(),
                        TextField(
                          autofocus: true,
                          controller: reviewMerchantController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Type your review here...',
                          ),
                        ),
                        //switch hidden name
                        StatefulBuilder(builder: (context, setState) {
                          return CheckboxListTile(
                            title: Text("Hide my name",
                                style: blackMonstadtTextFont.copyWith(fontSize: 12)),
                            value: status,
                            onChanged: (newValue) {
                              setState(() {
                                status = newValue;
                              });
                              (status) ? print('1') : print('0');
                            },
                            controlAffinity:
                                ListTileControlAffinity.leading, //  <-- leading Checkbox
                          );
                        }),

                        FlatButton(
                          color: Colors.greenAccent,
                          disabledColor: Colors.grey,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15)),
                          child: Text(
                            'Submit',
                            style: blackMonstadtTextFont.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: (reviewMerchantController.text != null &&
                                  valueProduct != null &&
                                  reviewMerchantController.text != '' &&
                                  valueProduct != 0)
                              ? () async {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      });
                                  await ReviewServices.createReviewProduct(
                                    ReviewProduct(
                                      idProduct: detail.idProduct,
                                      isHiddenName: status ? 1 : 0,
                                      stars: valueProduct,
                                      description: reviewMerchantController.text,
                                    ),
                                  );
                                  Get.back();
                                  Get.back();
                                  Get.snackbar(
                                      'Review Product Success', 'Your Review Success Posted');
                                }
                              : null,
                        )
                      ],
                    ),
                  ),
                )),
          );
        });
  }
}
