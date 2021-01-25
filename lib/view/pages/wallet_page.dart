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
              icon: Icon(Icons.credit_card),
              text: "CREDIT CARD",
            ),
            Tab(
              icon: Icon(Icons.attach_money),
              text: "E-CASH",
            ),
            Tab(
              icon: Icon(Icons.local_activity_outlined),
              text: "VOUCHER",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          CreditCard(),
          ECash(),
          VoucherPage(),
        ],
      ),
    );
  }
}

class CreditCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ECash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
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
                                            Text('Promo Code :', style: redNumberFont),
                                            Text(voucher[index].voucherCode,
                                                style: redNumberFont.copyWith(fontSize: 18)),
                                            Divider(),
                                            Text('Terms & Conditions',
                                                style: blackTextFont.copyWith(
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(height: 5),
                                            Text(
                                                '1. Voucher hanya bisa digunakan sekali dan tidak dapat diuangkan',
                                                style: blackTextFont.copyWith(fontSize: 12)),
                                            Text(
                                                '2. nilai belanja lebih kecil daripada nilai voucher, maka selisihnya tidak bisa digunakan ataupun diuangkan',
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
