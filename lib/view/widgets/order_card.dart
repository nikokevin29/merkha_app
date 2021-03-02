part of 'widgets.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  OrderCard({this.order});
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id', null); // Init Date Format for Indonesia
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ExpansionCard(
        margin: EdgeInsets.only(top: 5),
        title: Column(
          children: [
            Row(
              children: [
                Container(
                  height: (MediaQuery.of(context).size.width - (2 * defaultMargin)) * 0.25,
                  width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) * 0.25,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(
                      color: Colors.grey[200],
                    ),
                    image: DecorationImage(
                      image: (order.preview != null)
                          ? NetworkImage(order.preview)
                          : AssetImage('assets/img_not_available.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order.orderStatus,
                          style: blackTextFont.copyWith(
                            fontSize: 15,
                            color: HexColor('#B3E2AC'),
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 9),
                      Text(order.orderNumber ?? '',
                          style: blackTextFont.copyWith(fontSize: 15)), // ORD-TGL-BLN-THN-ID
                      Row(
                        children: [
                          Icon(Icons.schedule, size: 15),
                          Text(
                              DateFormat.Hms('id')
                                  .format(DateFormat("yyyy-MM-dd HH:mm:ss").parse(order.createdAt)),
                              style: blackTextFont.copyWith(fontSize: 15)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 15),
                          Text(
                            DateFormat.yMMMMd('id')
                                .format(DateFormat("yyyy-MM-dd HH:mm:ss").parse(order.createdAt)),
                            style: blackTextFont.copyWith(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 9),
                      Text(
                        order.merchantName,
                        style: blackTextFont.copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        'To: ' + order.address,
                        style: blackTextFont.copyWith(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        order.city + ', ' + order.province,
                        style: blackTextFont.copyWith(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal : ", style: blackTextFont),
                    Text(
                        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                            .format(order.totalPrice - order.shippingPrice),
                        style: redNumberFont.copyWith()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Shipping : ", style: blackTextFont),
                    Text(
                        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                            .format(order.shippingPrice),
                        style: redNumberFont.copyWith()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total : ", style: blackTextFont),
                    Text(
                      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                          .format(order.totalPrice),
                      style: redNumberFont.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Divider(),
                OrderStatusWidget(order: order),
                //note: ON WAITING FOR PAYMENT STATE
                (order.orderStatus == 'WAITING FOR PAYMENT')
                    ? Container(
                        width: MediaQuery.of(context).size.width - (2 * defaultMargin),
                        margin: EdgeInsets.symmetric(vertical: 7),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: HexColor('#fcecec'),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          children: [
                            RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                style: blackMonstadtTextFont.copyWith(
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(text: 'Harap segera melakukan transfer senilai '),
                                  TextSpan(
                                    text: NumberFormat.currency(
                                            locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                        .format(order.totalPrice),
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: ' ke rekening '),
                                  TextSpan(
                                      text: 'BCA: ' + rekBCA, // norek in shared_value
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: ' a.n '),
                                  TextSpan(
                                      text: 'PT Merkha Teknologi Indonesia',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: ' dan upload bukti transfernya sebelum '),
                                  TextSpan(
                                      text: DateFormat.yMMMMd('id').format(
                                          DateFormat("yyyy-MM-dd HH:mm:ss")
                                              .parse(order.createdAt)
                                              .add(Duration(days: 1)))),
                                  TextSpan(
                                      text: ' pk ' +
                                          DateFormat.Hm('id').format(
                                              DateFormat("yyyy-MM-dd HH:mm:ss")
                                                  .parse(order.createdAt))),
                                  TextSpan(
                                      text:
                                          ' (24 jam dari sekarang). Transaksi akan batal otomatis apabila sudah melewati batas waktu tersebut.'),
                                ],
                              ),
                            ),
                            FlatButton(
                              shape: StadiumBorder(),
                              color: Colors.greenAccent,
                              child: Text('Upload', style: blackTextFont),
                              onPressed: () {
                                Get.to(ConfirmPaymentPage(idOrders: order.id.toString()));
                              },
                            )
                          ],
                        ),
                      )
                    : Container(),
                //note: Button Detail Order
                FlatButton(
                    shape: StadiumBorder(),
                    color: Colors.green,
                    child: Text('Detail Order',
                        style: blackTextFont.copyWith(color: Colors.white, fontSize: 14)),
                    onPressed: () {
                      Get.to(DetailOrderPage(order: order));
                    }),
                //note: ON DELIVERY STATE
                (order.orderStatus == 'ON DELIVERY')
                    ? FlatButton(
                        shape: StadiumBorder(),
                        color: Colors.green,
                        child: Text('Order Reveiced',
                            style: blackTextFont.copyWith(color: Colors.white, fontSize: 14)),
                        onPressed: () async {
                          //TODO: change orderStatus to FINISHED
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              });
                          await OrderServices.updateStatusOrder(
                            order: Order(
                              id: order.id,
                              orderStatus: 'FINISHED',
                            ),
                          );
                          context.read<OrderCubit>().showOngoingOrder();
                          context.read<OrderFinishCubit>().showFinishedOrder();
                          Navigator.pop(context);
                        })
                    : Container(),
                //note: ON FINISHED STATE (REVIEW MERCHANT)
                (order.orderStatus == 'FINISHED')
                    ? Container(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                            child: Text('Give Star & Review',
                                style:
                                    blackTextFont.copyWith(color: Colors.blueAccent, fontSize: 11)),
                            onPressed: () async {
                              //
                              var check;
                              await ReviewServices.checkReviewMerchant(idOrder: order.id.toString())
                                  .then((var value) => check = value);
                              if (check == 0) {
                                _reviewMerchantBottomSheet(context, order);
                              } else {
                                Get.snackbar('Review Complete', 'Your Order Already Reviewed');
                              }
                            }),
                      )
                    : Container(),
                // Container(
                //   alignment: Alignment.centerRight,
                //   child: (order.orderStatus != 'FINISHED')
                //       ? Container()
                //       : FutureBuilder(
                //           future: ReviewServices.checkReviewMerchant(idOrder: order.id.toString()),
                //           builder: (context, snapshot) {
                //             if (snapshot.data == 1) {
                //               return FlatButton(
                //                 onPressed: () {
                //                   _reviewMerchantBottomSheet(context, order);
                //                 },
                //                 child: Text('Give Star & Review',
                //                     style: blackTextFont.copyWith(
                //                         color: Colors.blueAccent, fontSize: 11)),
                //               );
                //             } else {
                //               return Container();
                //             }
                //           }),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _reviewMerchantBottomSheet(BuildContext context, Order order) {
    TextEditingController reviewMerchantController = new TextEditingController();
    double valueMerchant;
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
                          "How This Merchant Services ?",
                          style: blackMonstadtTextFont.copyWith(fontSize: 14),
                        ),
                        SmoothStarRating(
                          starCount: 5,
                          rating: 1,
                          size: 40.0,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half,
                          color: Colors.yellowAccent,
                          borderColor: Colors.grey[400],
                          onRated: (v) {
                            valueMerchant = v;
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
                                  valueMerchant != null &&
                                  reviewMerchantController.text != '' &&
                                  valueMerchant != 0)
                              ? () async {
                                  //TODO: buat logic submit review merchant
                                  //id_order,id_user,is_hidden_name,description,id_merchant
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      });
                                  await ReviewServices.createReviewMerchant(
                                    ReviewMerchant(
                                      idOrder: order.id,
                                      idMerchant: order.idMerchant,
                                      isHiddenName: (status) ? '1' : '0',
                                      stars: valueMerchant,
                                      description: reviewMerchantController.text,
                                    ),
                                  );
                                  Get.back();
                                  Get.back();
                                  Get.snackbar('Review Success', 'Your Review Success Posted');
                                  context
                                      .read<ReviewMerchantCubit>()
                                      .showReviewMerchant(merchantId: order.idMerchant.toString());
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

class OrderStatusWidget extends StatelessWidget {
  final Order order;
  const OrderStatusWidget({@required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - (2 * defaultMargin),
      height: 30,
      alignment: Alignment.center,
      child: Wrap(
        spacing: 3.0,
        children: [
          Column(
            children: [
              Container(
                height: 10,
                width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) / 7,
                decoration: BoxDecoration(
                  color: (order.orderStatus == 'WAITING FOR PAYMENT')
                      ? HexColor('#69bf7e')
                      : Colors.grey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                ),
              ),
              Text(
                'Waiting For\nPayment',
                style: blackTextFont.copyWith(fontSize: 8, color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 10,
                width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) / 7,
                color:
                    (order.orderStatus == 'PAYMENT CONFIRMED') ? HexColor('#69bf7e') : Colors.grey,
              ),
              Text(
                'Payment\nConfirmed',
                style: blackTextFont.copyWith(fontSize: 8, color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 10,
                width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) / 7,
                color: (order.orderStatus == 'ORDER CONFIRMED') ? HexColor('#69bf7e') : Colors.grey,
              ),
              Text(
                'Order\nConfirmed',
                style: blackTextFont.copyWith(fontSize: 8, color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 10,
                width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) / 7,
                color: (order.orderStatus == 'ON DELIVERY') ? HexColor('#69bf7e') : Colors.grey,
              ),
              Text(
                'On Delivery',
                style: blackTextFont.copyWith(fontSize: 8, color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 10,
                width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) / 7,
                color: (order.orderStatus == 'DELIVERED') ? HexColor('#69bf7e') : Colors.grey,
              ),
              Text(
                'Delivered',
                style: blackTextFont.copyWith(fontSize: 8, color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 10,
                width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) / 7,
                decoration: BoxDecoration(
                  color: (order.orderStatus == 'FINISHED') ? HexColor('#69bf7e') : Colors.grey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                ),
              ),
              Text(
                'Finished',
                style: blackTextFont.copyWith(fontSize: 8, color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
