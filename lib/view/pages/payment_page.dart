part of 'pages.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Payment Bank Transfer', style: blackTextFont.copyWith()),
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Get.back();
            return false;
          },
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BankCard(
                    color: '#A7A0BA',
                    cardNumber: '1234 1234 1234 1234',
                    assetIcon: 'assets/bca.png',
                    value: '100000000',
                  ),
                  BankCard(
                    color: '#0C2855',
                    cardNumber: '1234 1234 1234 1234',
                    assetIcon: 'assets/mandiri.png',
                    value: '100000000',
                  ),
                  //
                  OutlineButton(
                      child: Text("Choose Payment",
                          style: blackTextFont.copyWith(
                            fontSize: 14,
                          )),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        //
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}

class BankCard extends StatelessWidget {
  final String color, cardNumber, assetIcon, value;
  BankCard({
    this.color,
    this.cardNumber,
    this.assetIcon,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: HexColor(color),
      child: Container(
        width: MediaQuery.of(context).size.width - (2 * defaultMargin),
        height: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.only(left: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  height: 75,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(assetIcon),
                    ),
                  ),
                ),
              ],
            ),
            Text(cardNumber,
                style: blackTextFont.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                )),
            Text('PT. Merkha Indonesia',
                style: blackTextFont.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                )),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(right: defaultMargin),
              alignment: Alignment.centerRight,
              child: Text(
                  NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                      .format(double.parse(value)),
                  style: blackTextFont.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
