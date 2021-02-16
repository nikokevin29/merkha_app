part of 'pages.dart';

class PaymentPage extends StatefulWidget {
  final double total;

  final int idTemp;
  PaymentPage({this.total, this.idTemp});
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(MainPage(bottomNavBarIndex: 4));
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('Payment Bank Transfer', style: blackTextFont.copyWith()),
            backgroundColor: Colors.white,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Get.offAll(MainPage(bottomNavBarIndex: 4));
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
                      cardNumber: rekBCA,
                      assetIcon: 'assets/bca.png',
                      value: widget.total.toString(),
                    ),
                    BankCard(
                      color: '#0C2855',
                      cardNumber: rek2,
                      assetIcon: 'assets/mandiri.png',
                      value: widget.total.toString(),
                    ),
                    //
                    Divider(),
                    Text('You Need to Transfer :', style: blackMonstadtTextFont.copyWith()),
                    Text(
                        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                            .format(widget.total ?? 0),
                        style: redNumberFont.copyWith()),
                    Divider(),
                    SizedBox(height: 15),
                    Text('Confirm your order in Order Tab', style: blackTextFont.copyWith()),
                    SizedBox(height: 15),
                    OutlineButton(
                      child: Text(
                        "Go To Profile Order Page",
                        style: blackTextFont.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        Get.offAll(MainPage(bottomNavBarIndex: 4));
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
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
