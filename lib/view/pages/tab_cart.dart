part of 'pages.dart';

class CartTab extends StatefulWidget {
  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController promoController = TextEditingController();
  bool isempty = false;
  bool voucherCheck = false;
  bool isLoading = false;
  Address mockAddress;
  List<Cart> _cart = [];

  double subtotal;
  double weightTotal;
  int idVoucher;
  int idMerchant;
  String merchantName;
  String urlMerchant;
  String idProvinceM;
  String idCityM;
  String selectedCourier, selectedSubCourier, ongkir;
  //((subtotal - voucher.discAmount) * voucher.discRate) + ongkir
  double total;
  double amountVoucher, rateVoucher;

  @override
  void initState() {
    super.initState();
    context.read<WishlistCubit>().showWishlist(); //Get Wishlist

    //note: set address to first list
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
    total = 0; //Set total
    subtotal = 0; //Set subtotal
    weightTotal = 0; //Set weight total
    amountVoucher = 0;
    rateVoucher = 1;
    LocalStorage.db.getCart().then((cartList) {
      if (cartList.length != 0) {
        _cart = cartList;
        idMerchant = cartList.first.idMerchant; //Get Id Merchant
        merchantName = cartList.first.merchantName; //Get Merchant name
        urlMerchant = cartList.first.merchantLogo; // Get Merchant Url Logo
        idProvinceM = cartList.first.idProvinceM; //Get idProvince Merhcant
        idCityM = cartList.first.idCityM; //Get idCity Merchant
        print(idProvinceM);
        for (int i = 0; i <= _cart.length - 1; i++) {
          subtotal = subtotal + (_cart[i].price * _cart[i].qty); // Set Subtotal init
          weightTotal = weightTotal + (_cart[i].weight);
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

  void updateTotal(double newTotal) {
    setState(() {
      total = newTotal;
    });
  }

  void updateCart() {
    LocalStorage.db.getCart().then((cartList) {
      _cart = cartList;
      merchantName = cartList.first.merchantName; //Get Merchant name
      urlMerchant = cartList.first.merchantLogo; // Get Merchant Url Logo
      idProvinceM = cartList.first.idProvinceM; //Get idProvince Merhcant
      idCityM = cartList.first.idCityM; //Get idCity Merchant
      for (int i = 0; i <= _cart.length - 1; i++) {
        subtotal = subtotal + (_cart[i].price * _cart[i].qty); // Set Subtotal init
      }
      setState(() {});
    });
  }

  getOngkir(var idCityOrigin, var idCityDest, var weight, var courier) async {
    final response = await http.post(apiRajaOngkir + 'cost', headers: {
      "key": apiKeyOngkir
    }, body: {
      "origin": idCityOrigin,
      "destination": idCityDest,
      "weight": weight, //gram
      "courier": courier //jne, pos, tiki
    });
    print(response.body);
    var jsonObject = jsonDecode(response.body);
    var data = await (jsonObject as Map<String, dynamic>)['rajaongkir']['results'];
    // for (int i = 0; i < data.length; i++) {
    //_listCourier.add();
    selectedSubCourier = data[0]['costs'][0]['service'];
    ongkir = data[0]['costs'][0]['cost'][0]['value'].toString();
    print(data[0]['costs'][0]['service']); //Service suatu paket
    print(data[0]['costs'][0]['cost'][0]['value']); //Harga suatu paket
    selectedCourier = data[0]['name'];
  }

  Future<void> _orderSubmit(Order order) async {
    //id_merchant, id_buyer(auto), id_destination, id_voucher,order_number(auto), order_status,shipping_price, discount_price, total_price
    //note: API create Order
    // OrderServices.createOrder(order: order);
    await context.read<OrderCubit>().createOrder(order);
    print('Cart length  =  ' + _cart.length.toString());
    SharedPreferences orders = await SharedPreferences.getInstance();
    int lastId = orders.getInt('lastId');

    for (int i = 0; i <= _cart.length - 1; i++) {
      // print('id product' + _cart[i].id.toString());
      // print('amount ' + _cart[i].qty.toString());
      // print('subtot ' + (_cart[i].qty * _cart[i].price).toString());
      _detailOrderSubmit(
        DetailOrder(
          idOrder: lastId,
          idProduct: _cart[i].id,
          amount: _cart[i].qty,
          subtotal: (_cart[i].qty * _cart[i].price),
        ),
      );
    }
    return null;
  }

  Future<void> _detailOrderSubmit(DetailOrder detail) {
    //note: API create Detail Order
    OrderServices.createDetailOrder(detail: detail);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
            child: GestureDetector(
              onTap: () {
                //note: unfocusing keyboard and TextField Promo Code
                FocusScope.of(context).requestFocus(new FocusNode());
              },
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
                                                  offset:
                                                      Offset(0, 3), // changes position of shadow
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
                                                    mockAddress.addressSaveName ?? '',
                                                    maxLines: 1,
                                                    style: blackTextFont.copyWith(
                                                        fontSize: 10, fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    mockAddress.address ?? '',
                                                    maxLines: 2,
                                                    style: blackTextFont.copyWith(fontSize: 10),
                                                  ),
                                                  Text(
                                                    mockAddress.province ??
                                                        '' + ', ' + mockAddress.city ??
                                                        '',
                                                    style: blackTextFont.copyWith(fontSize: 10),
                                                  ),
                                                  Text(
                                                    mockAddress.postalCode ?? '',
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('Weight total : ',
                                          style: redNumberFont.copyWith(
                                              fontSize: 12, color: Colors.grey)),
                                      Text(
                                        weightTotal.toString() + ' gram',
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
                                          'Shipping ' + idProvinceM.toString(),
                                          style: blackTextFont.copyWith(
                                              fontWeight: FontWeight.bold, fontSize: 12),
                                        ),
                                        InkWell(
                                          child: Text(
                                            'Edit',
                                            style: blackTextFont.copyWith(
                                                color: Colors.blue, fontSize: 12),
                                          ),
                                          onTap: () {
                                            if (mockAddress.id == '') {
                                              Get.snackbar('No Address Assign',
                                                  'Please Pick Shipping Address',
                                                  snackPosition: SnackPosition.BOTTOM);
                                            } else {
                                              _onEditShipping();
                                              setState(() {});
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 9),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              selectedCourier ?? 'Courier',
                                              style: blackTextFont.copyWith(
                                                  fontSize: 10, fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              selectedSubCourier ?? ' ',
                                              style: blackTextFont.copyWith(
                                                  fontSize: 9, fontWeight: FontWeight.w200),
                                            ),
                                          ]),
                                      Text(
                                        NumberFormat.currency(
                                                locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                            .format(double.parse(ongkir ?? '0')),
                                        style: redNumberFont.copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // DropdownButton(
                                      //     isExpanded: true,
                                      //     hint: Text('Select City'),
                                      //     value: _valueCity,
                                      //     items: _dataCity.map((item) {
                                      //       return DropdownMenuItem(
                                      //         child: Text(item['city_name']),
                                      //         value: item['city_id'],
                                      //         onTap: () {
                                      //           //_cityName = item['city_name']; //Get City Name
                                      //         },
                                      //       );
                                      //     }).toList(),
                                      //     onChanged: (value) {
                                      //       setState(() {
                                      //         // _valueCity = value;
                                      //         // _valueCity != '' ? iscity = true : iscity = false;
                                      //         // print("City id :" + _valueCity.toString());
                                      //       });
                                      //     })
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: StatefulBuilder(
                                            builder: (thisLowerContext, innerSetState) {
                                          return FlatButton(
                                            height: 30,
                                            disabledColor: Color(0xFFE4E4E4),
                                            child: Text(
                                              (idVoucher == null)
                                                  ? 'Add Voucher'
                                                  : 'Remove Voucher',
                                              style: blackTextFont.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: (idVoucher == null)
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: new BorderRadius.circular(30.0)),
                                            color: (idVoucher == null) ? accentColor2 : Colors.red,
                                            onPressed: () async {
                                              //note: press Voucher
                                              print('TEST TEST ' + idVoucher.toString());
                                              if (idVoucher == null) {
                                                showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return Center(
                                                        child: CircularProgressIndicator(),
                                                      );
                                                    });
                                                await context
                                                    .read<VoucherCubit>()
                                                    .checkVoucher(promoController.text.trim());

                                                innerSetState(() {
                                                  total =
                                                      (((subtotal - amountVoucher) * rateVoucher) +
                                                          double.parse(ongkir ?? '0'));
                                                });
                                                Navigator.pop(context);
                                              } else {
                                                await context
                                                    .read<VoucherCubit>()
                                                    .clear(); //Clear Bloc State in Bottom
                                                promoController.clear(); //Clear TextField Voucher
                                                idVoucher = null; //set idVoucher to null
                                                amountVoucher = 0; //set to default
                                                rateVoucher = 1; //set to default
                                                innerSetState(() {
                                                  total =
                                                      (((subtotal - amountVoucher) * rateVoucher) +
                                                          double.parse(ongkir ?? '0'));
                                                });
                                              }
                                            },
                                          );
                                        }),
                                      ),
                                      SizedBox(width: 9),
                                      Expanded(
                                        child: TextField(
                                          controller: promoController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Promo Code',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  BlocBuilder<VoucherCubit, VoucherState>(
                                      builder: (context, state) {
                                    if (state is VoucherLoadingFailed) {
                                      return Container(child: Text('Voucher Not Applied'));
                                    } else if (state is VoucherUsed) {
                                      idVoucher = state.voucher.id;
                                      amountVoucher = state.voucher.discAmount;
                                      rateVoucher = state.voucher.discRate;
                                      print(idVoucher);
                                      print(amountVoucher);
                                      print(rateVoucher);
                                      return Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text('Voucher Name: '),
                                                Text(
                                                  state.voucher.voucherName,
                                                  style: blackTextFont.copyWith(),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Voucher Type: '),
                                                Text(
                                                  state.voucher.voucherType,
                                                  style: blackTextFont.copyWith(),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Value: '),
                                                Container(
                                                  child: (state.voucher.voucherType == "Amount")
                                                      ? Text(state.voucher.discAmount.toString())
                                                      : Text((100 - (state.voucher.discRate * 100))
                                                              .toString() +
                                                          '%'),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Container(child: Text(''));
                                    }
                                  }),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'TOTAL',
                                          style:
                                              blackTextFont.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        //((subtotal - voucher.discAmount) * voucher.discRate) + ongkir
                                        //total = (subtotal - amountVoucher) + double.parse(ongkir)
                                        StreamBuilder(
                                            stream: null,
                                            initialData: total,
                                            builder: (context, snapshot) {
                                              return Text(
                                                NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: 'Rp ',
                                                        decimalDigits: 0)
                                                    .format(total = (((subtotal - amountVoucher) *
                                                            rateVoucher) +
                                                        double.parse(ongkir ?? '0'))),
                                                style: redNumberFont.copyWith(fontSize: 12),
                                              );
                                            }),
                                        // Text(
                                        //   NumberFormat.currency(
                                        //           locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                        //       .format(total =
                                        //           (((subtotal - amountVoucher) * rateVoucher) +
                                        //               double.parse(ongkir ?? '0'))),
                                        //   style: redNumberFont.copyWith(fontSize: 12),
                                        // )
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    disabledColor: Color(0xFFE4E4E4),
                                    minWidth:
                                        MediaQuery.of(context).size.width - (2 * defaultMargin),
                                    color: HexColor('#65C07D'),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(30.0)),
                                    child: Text(
                                      'Submit and Go To Payment',
                                      style: blackTextFont.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      //id_merchant,id_destination, id_voucher, order_status,shipping_price, discount_price, total_price
                                      //Get.to(PaymentPage());
                                      if (ongkir != null) {
                                        _scaffoldKey.currentState.showSnackBar(new SnackBar(
                                          // duration: new Duration(seconds: 4),
                                          content: new Row(
                                            children: <Widget>[
                                              new CircularProgressIndicator(),
                                              new Text("  Submitting Order...")
                                            ],
                                          ),
                                        ));
                                        // note: Voucher Debug
                                        if (idVoucher != null) {
                                          print('Voucher Used id :' + idVoucher.toString());
                                        } else {
                                          print('Voucher Not Used');
                                        }
                                        await _orderSubmit(
                                          Order(
                                            idMerchant: idMerchant,
                                            idDestination: int.parse(mockAddress.id),
                                            idVoucher: idVoucher,
                                            orderStatus: 'WAITING FOR PAYMENT',
                                            shippingPrice: double.parse(ongkir),
                                            discountPrice: (amountVoucher != 0)
                                                ? ((subtotal * rateVoucher))
                                                : amountVoucher,
                                            totalPrice: total,
                                          ),
                                        );
                                        SharedPreferences orders =
                                            await SharedPreferences.getInstance();
                                        int tempLastId = orders.getInt('lastId');
                                        Get.to(PaymentPage(
                                          total: total,
                                          idTemp: tempLastId,
                                        ));
                                        LocalStorage.db.deleteAll(); // Clear Cart
                                        await orders.clear(); //clear shared pref id order
                                      } else if ((context.read<UserCubit>().state as UserLoaded)
                                              .user
                                              .email_verified_at ==
                                          null) {
                                        Get.snackbar(
                                          'Your Account Not Verified',
                                          'Please Verify Email in Edit Profile',
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      } else {
                                        Get.snackbar(
                                          'Missing Address or Courier',
                                          'Please Fill your Shipping and Address',
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      }
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
                      onPressed: () async {
                        Get.to(MainPage(bottomNavBarIndex: 0));
                        SharedPreferences orders = await SharedPreferences.getInstance();
                        orders.clear();
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
                                      style:
                                          blackTextFont.copyWith(fontSize: 16, color: Colors.red),
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

                                  weightTotal -= (_cart[index].weight);
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
                                weightTotal += (_cart[index].weight);
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

  void _onEditShipping() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              ListTile(
                title: Text('POS'),
                onTap: () async {
                  if (mockAddress.address == '') {
                    Get.back();
                    Get.back();
                    Get.snackbar('Pick Address First', 'Address Should be not Empty',
                        duration: Duration(milliseconds: 800));
                  } else {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                    await getOngkir(
                        idCityM, mockAddress.idCity.toString(), weightTotal.toString(), 'pos');
                    Get.back();
                    _selectedCourier(selectedCourier, selectedSubCourier ?? '', ongkir ?? '0');
                    setState(() {});
                  }
                },
              ),
              ListTile(
                title: Text('JNE'),
                onTap: () async {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                  await getOngkir(
                      idCityM, mockAddress.idCity.toString(), weightTotal.toString(), 'jne');
                  Get.back();
                  _selectedCourier(selectedCourier, selectedSubCourier ?? '', ongkir ?? '0');
                  setState(() {});
                },
              ),
              ListTile(
                  title: Text('TIKI'),
                  onTap: () async {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                    await getOngkir(
                        idCityM, mockAddress.idCity.toString(), weightTotal.toString(), 'tiki');
                    Get.back();
                    _selectedCourier(selectedCourier, selectedSubCourier ?? '', ongkir ?? '0');
                    setState(() {});
                  }),
            ],
          );
        });
  }

  void _selectedCourier(String courier, String sub, String price) {
    Get.back();
    setState(() {
      selectedCourier = courier;
      selectedSubCourier = sub;
      ongkir = price;
    });
  }
}
