part of 'pages.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with SingleTickerProviderStateMixin {
  int navBarIndex = 0;
  TabController controller;
  @override
  void initState() {
    context.read<VoucherCubit>().showAllVoucher(); //load all Avaiable voucher
    controller = new TabController(length: 3, vsync: this, initialIndex: navBarIndex);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Wallet', style: blackTextFont.copyWith()),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        bottom: TabBar(
          unselectedLabelColor: Colors.grey,
          controller: controller,
          labelColor: Colors.black,
          labelStyle: blackTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
          tabs: [
            Tab(
              icon: Icon(Icons.local_activity_outlined),
              text: "VOUCHER",
            ),
            Tab(
              icon: Icon(Icons.credit_card),
              text: "CREDIT CARD",
            ),
            Tab(
              icon: Icon(Icons.attach_money),
              text: "E-CASH",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          VoucherPage(),
          CreditCard(),
          ECash(),
        ],
      ),
    );
  }
}

class CreditCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('This Feature Not Avaiable For Now', style: blackTextFont));
  }
}

class ECash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('This Feature Not Avaiable For Now', style: blackTextFont));
  }
}

class VoucherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: BlocBuilder<VoucherCubit, VoucherState>(builder: (_, state) {
          if (state is VoucherLoaded) {
            List<Voucher> voucher = state.voucher;
            return Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: voucher.length,
                itemBuilder: (_, index) => Container(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    direction: Axis.vertical,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    children: [
                                      VoucherCard(voucher[index]),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                                        child: Column(
                                          children: [
                                            Divider(),
                                            Text('Voucher Code :', style: redNumberFont),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  voucher[index].voucherCode,
                                                  style: redNumberFont.copyWith(fontSize: 18),
                                                ),
                                                SizedBox(width: 9),
                                                OutlineButton(
                                                  color: Colors.amber,
                                                  onPressed: () {
                                                    Get.back();
                                                    FlutterClipboard.copy(
                                                            voucher[index].voucherCode)
                                                        .then((value) => Get.snackbar(
                                                            'Copied Promo Code To Clipboard',
                                                            'Promo Code has Been Added to your clipboard',
                                                            duration:
                                                                Duration(milliseconds: 1000)));
                                                  },
                                                  child: Text(
                                                    'Copy',
                                                    style: redNumberFont.copyWith(fontSize: 14),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Divider(),
                                            Text('Terms & Conditions',
                                                style: blackTextFont.copyWith(
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(height: 5),
                                            Text(
                                                '1. Voucher hanya bisa digunakan sesuai kuota dan tidak dapat diuangkan',
                                                style: blackTextFont.copyWith(fontSize: 12)),
                                            Text(
                                                '2. Nilai belanja lebih kecil daripada nilai voucher, maka selisihnya tidak bisa digunakan ataupun diuangkan',
                                                style: blackTextFont.copyWith(fontSize: 12)),
                                            QrImage(
                                              data: voucher[index].voucherCode,
                                              version: QrVersions.auto,
                                              size: 125,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: VoucherCard(voucher[index])),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
