part of 'widgets.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  OrderCard({this.order});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id', null); // Init Date Format for Indonesia
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                          : AssetImage('assets/defaultProfile.png'),
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
                FlatButton(
                    shape: StadiumBorder(),
                    color: Colors.green,
                    child: Text('Detail Order',
                        style: blackTextFont.copyWith(color: Colors.white, fontSize: 14)),
                    onPressed: () {
                      //TODO: get order details here
                      Get.to(DetailOrderPage(idOrder: order.id.toString()));
                    }),
                Container(
                  alignment: Alignment.centerRight,
                  child: (order.orderStatus == 'FINISHED')
                      ? FlatButton(
                          onPressed: () {
                            Get.snackbar('Nothing', 'Soon');
                          },
                          child: Text('Give Star & Review',
                              style:
                                  blackTextFont.copyWith(color: Colors.blueAccent, fontSize: 11)),
                        )
                      : Container(),
                ),
              ],
            ),
          )
        ],
      ),
    );
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
                width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) / 6,
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
                width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) / 6,
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
                width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) / 6,
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
                width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) / 6,
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
                width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) / 6,
                decoration: BoxDecoration(
                  color: (order.orderStatus == 'FINISHED') ? HexColor('#69bf7e') : Colors.grey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                ),
              ),
              Text(
                'FINISHED',
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
