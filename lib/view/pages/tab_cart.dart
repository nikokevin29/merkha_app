part of 'pages.dart';

class CartTab extends StatefulWidget {
  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  Address mockAddress;
  List<Cart> _cart = [];
  double subtotal;
  String merchantName;
  String urlMerchant;

  @override
  void initState() {
    super.initState();
    context.read<WishlistCubit>().showWishlist(); //Get Wishlist

    context.read<AddressCubit>().showAddress(); //Get Address
    mockAddress = Address(
      address: '',
      addressSaveName: '',
      id: '',
      idProvince: '',
      idCity: '',
      postalCode: '',
      city: '',
      province: '',
    );
    subtotal = 0; //Set subtotal
    LocalStorage.db.getCart().then((cartList) {
      if (cartList.length != 0) {
        _cart = cartList;
        merchantName = cartList.first.merchantName; //Get Merchant name
        urlMerchant = cartList.first.merchantLogo; // Get Merchant Url Logo
        for (int i = 0; i <= _cart.length - 1; i++) {
          subtotal = subtotal + (_cart[i].price * _cart[i].qty); // Set Subtotal init
        }
        setState(() {});
      }
    });
  }

  void updateAddress(Address newAddress) {
    setState(() {
      mockAddress = newAddress;
    });
  }

  void updateCart() {
    LocalStorage.db.getCart().then((cartList) {
      _cart = cartList;
      merchantName = cartList.first.merchantName; //Get Merchant name
      urlMerchant = cartList.first.merchantLogo; // Get Merchant Url Logo
      for (int i = 0; i <= _cart.length - 1; i++) {
        subtotal = subtotal + (_cart[i].price * _cart[i].qty); // Set Subtotal init
      }
      setState(() {});
    });
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
            actions: [
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: InkWell(
              //       onTap: () async {
              //         print('cek');
              //         LocalStorage.db.deleteAll();
              //         await LocalStorage.db.getCart().then((value) {
              //           _cart = value;
              //           for (int i = 0; i <= _cart.length; i++) {
              //             _cart.remove(i);
              //           }
              //         });
              //         setState(() {});
              //       },
              //       child: Icon(Icons.delete_forever, color: Colors.black)),
              // ),
            ]),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: (merchantName != null)
                      ? Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(children: [
                                  (urlMerchant != null)
                                      ? Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(urlMerchant)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.3),
                                                spreadRadius: 3,
                                                blurRadius: 7,
                                                offset: Offset(0, 3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: (merchantName != null)
                                        ? Text(
                                            merchantName,
                                            style: blackTextFont.copyWith(),
                                            maxLines: 1,
                                          )
                                        : Text(''),
                                  ),
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
                                                  mockAddress.addressSaveName +
                                                      ' id ' +
                                                      mockAddress.id,
                                                  maxLines: 1,
                                                  style: blackTextFont.copyWith(
                                                      fontSize: 10, fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  mockAddress.address,
                                                  maxLines: 2,
                                                  style: blackTextFont.copyWith(fontSize: 10),
                                                ),
                                                Text(
                                                  mockAddress.province + ', ' + mockAddress.city,
                                                  style: blackTextFont.copyWith(fontSize: 10),
                                                ),
                                                Text(
                                                  mockAddress.postalCode,
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
                                          print('Tap pick address');
                                          Get.to(
                                              AddressFeedPick(onSonChanged: (Address newAddress) {
                                            updateAddress(newAddress);
                                          }));
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
                                    style: blackTextFont.copyWith(
                                        fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                ),
                                //TODO:Cart Builder Here
                                buildCartBuilder(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Subtotal : ',
                                        style: redNumberFont.copyWith(
                                            fontSize: 12, color: Colors.grey)),
                                    //note: Subtotal All Product
                                    Text(
                                      NumberFormat.currency(
                                              locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                          .format(subtotal),
                                      style: redNumberFont.copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Divider(),
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
                                          style: blackTextFont.copyWith(
                                              color: Colors.blue, fontSize: 12),
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
                                      NumberFormat.currency(
                                              locale: 'id', symbol: 'Rp ', decimalDigits: 0)
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  onPressed: () {
                                    //
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          child: Center(child: Text('Cart Empty')),
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

  Widget buildCartBuilder() {
    return ListView.builder(
        shrinkWrap: true, //Fixed Length
        physics: const ClampingScrollPhysics(), // Disable Touch Scroll
        itemCount: _cart.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: [
            //Product Cart
            Row(
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(_cart[index].urlPreview),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //note: Product Name
                    Text(
                      _cart[index].productName,
                      overflow: TextOverflow.clip,
                      style: blackTextFont.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Container(
                        width: 110,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          InkWell(
                              onTap: () {
                                //note: Decrease Qty
                                if (_cart[index].qty == 1) {
                                  print('min qty 1');
                                } else {
                                  LocalStorage.db.updateQty(
                                    Cart(qty: _cart[index].qty -= 1),
                                  );

                                  subtotal -= (1 * _cart[index].price);
                                  print(_cart[index].qty.toString());
                                  print(subtotal.toString());
                                }
                                setState(() {});
                              },
                              child: Icon(Icons.arrow_drop_down)),
                          Text(_cart[index].qty.toString()),
                          InkWell(
                              onTap: () {
                                //note: Increase Qty
                                LocalStorage.db.updateQty(
                                  Cart(qty: _cart[index].qty += 1),
                                );

                                subtotal += (1 * _cart[index].price);
                                print(_cart[index].qty.toString());
                                print(subtotal.toString());
                                setState(() {});
                              },
                              child: Icon(Icons.arrow_drop_up)),
                          GestureDetector(
                              onTap: () {
                                Widget cancelButton = FlatButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Get.back();
                                  },
                                );
                                Widget continueButton = FlatButton(
                                  child: Text("Delete"),
                                  onPressed: () {
                                    LocalStorage.db.delete(_cart[index].id);
                                    _cart.removeAt(index);
                                    Get.back();
                                    setState(() {});
                                  },
                                );
                                AlertDialog alert = AlertDialog(
                                  title: Text("Warning"),
                                  content: Text("Are you sure want to delete this item ?"),
                                  actions: [
                                    cancelButton,
                                    continueButton,
                                  ],
                                );
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              },
                              child: Icon(Icons.delete)),
                        ]),
                      ),
                      SizedBox(width: 10),
                      Text('X'),
                      SizedBox(width: 10),
                      //note: Price Per Product
                      SizedBox(
                        width: 85,
                        child: Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                              .format(_cart[index].price),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: redNumberFont.copyWith(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
            Divider(),
          ]);
        });
  }
}
