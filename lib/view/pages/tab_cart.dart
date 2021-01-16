part of 'pages.dart';

class CartTab extends StatefulWidget {
  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  List<Product> _cart = [];
  Product _activeProduct = null;

  // _addOneItemToCart(Product p) {
  //   Product found = _cart.firstWhere((element) => element.id == p.id, orElse: () => null);
  //   if (found != null) {
  //     found.qty += 1;
  //   } else {
  //     _cart.add(p);
  //   }
  // }

  // _removeOneItemToCart(Product p) {
  //   Product found = _cart.firstWhere((element) => element.id == p.id, orElse: () => null);
  //   if (found != null) {
  //     _cart.remove(p);
  //   } else {
  //     found.qty -= 1;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    context.read<WishlistCubit>().showWishlist(); //Get Wishlist
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "My Cart",
            style: blackTextFont.copyWith(fontSize: 24),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://cf.shopee.co.id/file/212900d04161ecd95384307754aa7462'),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                                child: Text(
                              'Woodka',
                              style: blackTextFont.copyWith(),
                              maxLines: 1,
                            )),
                          ]),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Shipping Address :',
                                      style: blackTextFont.copyWith(
                                          fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Jl. bangka Raya No.45A',
                                            maxLines: 2,
                                            style: blackTextFont.copyWith(fontSize: 10),
                                          ),
                                          Text(
                                            'Jakarta Selatan' + ', ' + 'DKI Jakarta',
                                            style: blackTextFont.copyWith(fontSize: 10),
                                          ),
                                          Text(
                                            '53176',
                                            style: blackTextFont.copyWith(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    print('tap edit address');
                                  },
                                  child: Text(
                                    'Edit',
                                    style: blackTextFont.copyWith(
                                        color: Colors.blueAccent, fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Item',
                              style:
                                  blackTextFont.copyWith(fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          //Cart Builder Here
                          ProductCardCard(),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping',
                                  style: blackTextFont.copyWith(
                                      fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                InkWell(
                                  child: Text(
                                    'Edit',
                                    style: blackTextFont.copyWith(color: Colors.blue, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 9),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(
                                  'JNE',
                                  style: blackTextFont.copyWith(
                                      fontSize: 10, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'YES (Yakin Esok Sampai)',
                                  style: blackTextFont.copyWith(
                                      fontSize: 9, fontWeight: FontWeight.w200),
                                ),
                              ]),
                              Text(
                                NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                    .format(8000),
                                style: redNumberFont.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          Divider(),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: FlatButton(
                              height: 30,
                              disabledColor: Color(0xFFE4E4E4),
                              child: Text(
                                'Add Voucher',
                                style: blackTextFont.copyWith(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0)),
                              color: accentColor2,
                              onPressed: () {
                                //note: press Voucher
                              },
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'TOTAL',
                                  style: blackTextFont.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  NumberFormat.currency(
                                          locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                      .format(100000),
                                  style: redNumberFont.copyWith(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          FlatButton(
                            disabledColor: Color(0xFFE4E4E4),
                            minWidth: MediaQuery.of(context).size.width - (2 * defaultMargin),
                            color: HexColor('#65C07D'),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            child: Text(
                              'Payment',
                              style: blackTextFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            onPressed: () {
                              //
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  width: 200,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue Shopping',
                          style: blackTextFont.copyWith(
                            color: HexColor('#4A95E9'),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.home, color: HexColor('#4A95E9'))
                      ],
                    ),
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () {
                      Get.to(MainPage(bottomNavBarIndex: 0));
                      //BUG
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text('My Wishlist',
                      style: blackTextFont.copyWith(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
                BlocBuilder<WishlistCubit, WishlistState>(builder: (_, state) {
                  if (state is WishlistLoaded) {
                    List<Product> wishlist = state.wishlist;
                    return Container(
                      width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                      child: (wishlist.length != 0)
                          ? GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.73,
                              ),
                              itemCount: wishlist.length,
                              itemBuilder: (_, index) => Container(
                                  child: Wrap(
                                alignment: WrapAlignment.center,
                                direction: Axis.horizontal,
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  ItemCardWishlist(product: wishlist[index]),
                                ],
                              )),
                            )
                          : Center(
                              child: Column(
                                children: [
                                  SizedBox(height: 50),
                                  Text(
                                    'Wishlist Empty',
                                    style: blackTextFont.copyWith(fontSize: 16, color: Colors.red),
                                  ),
                                  SizedBox(height: 50),
                                  FlatButton(
                                      color: accentColor2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(30.0)),
                                      onPressed: () {
                                        Get.off(MainPage(bottomNavBarIndex: 0));
                                      },
                                      child: Text('Go To Home'))
                                ],
                              ),
                            ),
                    );
                  } else {
                    return Container();
                  }
                }),
              ],
            ),
          ),
        ));
  }
}
