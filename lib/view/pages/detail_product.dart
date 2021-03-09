part of 'pages.dart';

class DetailProduct extends StatefulWidget {
  final Product product;
  DetailProduct({this.product});

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  String avgRev;
  @override
  void initState() {
    super.initState();
    context.read<ReviewProductCubit>().showReviewProduct(productId: widget.product.id.toString());
    ReviewServices.avgReviewProduct(productId: widget.product.id.toString()).then((value) {
      avgRev = value;
    });
    //note: Increase Viewed Product
    ProductServices.incrementViewed(id: widget.product.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.grey,
          onPressed: () {
            Get.back();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 35,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: (widget.product.merchantLogo.toString() != null)
                        ? NetworkImage(widget.product.merchantLogo)
                        : AssetImage('assets/defaultProfile.png')),
                boxShadow: [
                  BoxShadow(spreadRadius: 3, blurRadius: 7, color: Colors.black12),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 200,
                  child: Text(
                    widget.product.merchant.toString() ?? '',
                    style: blackTextFont.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Text(
                  widget.product.merchantLocation.toString() ?? '',
                  style: blackTextFont.copyWith(fontSize: 8, fontWeight: FontWeight.w200),
                ),
              ],
            )
          ],
        ),
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_vert, color: Colors.grey),
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: 'more',
                        child: InkWell(
                          onTap: () async {},
                          child: FutureBuilder(
                              future: ReportService.checkReportProduct(
                                  id: widget.product.id.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return FlatButton(
                                    height: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(30.0)),
                                    child: SizedBox(
                                      width: 80,
                                      child: Center(
                                          child: (snapshot.data.toString() ==
                                                  widget.product.id.toString())
                                              ? Text(
                                                  'Cancel Report',
                                                  style: whiteNumberFont.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black),
                                                )
                                              : Text(
                                                  'Report Product',
                                                  style: whiteNumberFont.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                    ),
                                    onPressed: () async {
                                      if (snapshot.data.toString() ==
                                          widget.product.id.toString()) {
                                        print('cancel report ' +
                                            snapshot.data.toString() +
                                            '   ' +
                                            widget.product.id.toString());
                                        await ReportService.deleteReportProduct(
                                            widget.product.id.toString());
                                        Get.back();
                                        Get.snackbar('Product Report Canceled',
                                            'This Product Has Been Unreported');
                                        if (this.mounted) setState(() {});
                                      } else {
                                        print('report product ' +
                                            snapshot.data.toString() +
                                            '   ' +
                                            widget.product.id.toString());
                                        await ReportService.createReportProduct(
                                            widget.product.id.toString());
                                        Get.back();
                                        Get.snackbar('Product Reported',
                                            'This Product Has Been Reported and will be check soon');
                                        if (this.mounted) setState(() {});
                                      }
                                    },
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }),
                          // Row(
                          //   children: [
                          //     Icon(
                          //       Icons.access_alarm_sharp,
                          //       color: Colors.grey,
                          //     ),
                          //     Text(' Option'),
                          //   ],
                          // ),
                        )),
                  ])
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: defaultMargin),
          child: Column(
            children: [
              //note: Image Product
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.width - (2 * defaultMargin),
                ),
                items: widget.product.photo
                    .substring(1, widget.product.photo.length - 1)
                    .split(', ')
                    .toList()
                    .map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(i),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(spreadRadius: 3, blurRadius: 7, color: Colors.black12)
                          ],
                        ),
                        //child: Text(i ?? 'Image not Found'), //Debug Show Link image
                      );
                    },
                  );
                }).toList(),
              ),
              Divider(color: Colors.transparent, height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // note: Product Name
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Text(widget.product.productName ?? '',
                        style: blackTextFont.copyWith(fontWeight: FontWeight.w400, fontSize: 20),
                        overflow: TextOverflow.clip),
                  ),
                  //note: Wishlist Button
                  // SizedBox(
                  //   height: 22,
                  //   width: 17,
                  //   child: InkWell(
                  //     child: Icon(Icons.bookmark_border, color: Colors.grey),
                  //     onTap: () {
                  //       print('tap bookmark detaill product');
                  //       context
                  //           .read<WishlistCubit>()
                  //           .addWishlist(Wishlist(idProduct: widget.product.id));
                  //       Get.snackbar(
                  //           'Product Added', widget.product.productName + ' Added to Wishlist');
                  //     },
                  //   ),
                  // ),
                  FutureBuilder(
                      future: WishlistService.checkWishlistStatus(
                          idProduct: widget.product.id.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.data.toString() == widget.product.id.toString()) {
                          return SizedBox(
                            height: 22,
                            width: 17,
                            child: InkWell(
                              child: Icon(Icons.bookmark, color: Colors.blueAccent),
                              onTap: () {
                                print('delete wishlist status ' +
                                    snapshot.data.toString() +
                                    '   ' +
                                    widget.product.id.toString());
                                context
                                    .read<WishlistCubit>()
                                    .deleteWishlist(widget.product.id.toString()); //delete wishlist
                                WishlistService.deleteWishlistStatus(
                                    idProduct:
                                        widget.product.id.toString()); //delete status wishlist
                                if (this.mounted) setState(() {});
                              },
                            ),
                          );
                        } else {
                          return SizedBox(
                            height: 22,
                            width: 17,
                            child: InkWell(
                              child: Icon(Icons.bookmark_border, color: Colors.grey),
                              onTap: () {
                                print('wishlist product ' +
                                    snapshot.data.toString() +
                                    '   ' +
                                    widget.product.id.toString());
                                context.read<WishlistCubit>().addWishlist(
                                    Wishlist(idProduct: widget.product.id)); // add wishlist
                                WishlistService.createWishlistStatus(
                                    idProduct: widget.product.id.toString()); //add status wishlist.
                                if (this.mounted) setState(() {});
                              },
                            ),
                          );
                        }
                      }),
                ],
              ),
              // note: Price Product
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                      .format(widget.product.price.toDouble()),
                  style: redNumberFont.copyWith(fontSize: 20),
                ),
              ),
              //note: Rating Product
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 8),
                  FutureBuilder(
                    future:
                        ReviewServices.avgReviewProduct(productId: widget.product.id.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text((snapshot.data != null) ? snapshot.data : 'No Review',
                            style: redNumberFont.copyWith(color: Colors.grey));
                      } else {
                        return SizedBox(
                          width: 20,
                          height: 20,
                          child: Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.grey,
                            child: Container(width: 10, height: 10, color: Colors.grey),
                          ),
                        );
                      }
                    },
                  ),

                  SizedBox(width: 5),
                  // Text(
                  //     '(' +
                  //         (context.watch<ReviewProductCubit>().state as ReviewProductLoaded)
                  //             .review
                  //             .length
                  //             .toString() +
                  //         ' Rating)',
                  //     style: blackTextFont.copyWith(color: Colors.grey)), //
                ],
              ),
              Divider(),
              // note: Description
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description', style: blackMonstadtTextFont.copyWith(fontSize: 14)),
                    SizedBox(height: 9),
                    //note: Description
                    Text(
                      widget.product.description ?? '',
                      style:
                          blackMonstadtTextFont.copyWith(fontSize: 14, fontWeight: FontWeight.w200),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: 250,
                child: BlocBuilder<ReviewProductCubit, ReviewProductState>(builder: (_, state) {
                  //
                  if (state is ReviewProductLoaded) {
                    List<ReviewProduct> review = state.review;
                    return (review.length != 0)
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: review.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) => Container(
                              margin: EdgeInsets.all(5),
                              child: ReviewProductCard(review: review[index]),
                            ),
                          )
                        : Center(child: Text('No Review', style: blackMonstadtTextFont));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
              ),
              Divider(),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Information Details',
                        style: blackMonstadtTextFont.copyWith(fontSize: 14)),
                    SizedBox(height: 9),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Seller',
                            style: blackMonstadtTextFont.copyWith(
                                fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w100)),
                        Text(widget.product.merchant.toString(),
                            style: blackMonstadtTextFont.copyWith(fontSize: 14)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Seller Location',
                            style:
                                blackMonstadtTextFont.copyWith(fontSize: 14, color: Colors.grey)),
                        Text(widget.product.merchantLocation.toString(),
                            style: blackMonstadtTextFont.copyWith(fontSize: 14)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Weight',
                            style:
                                blackMonstadtTextFont.copyWith(fontSize: 14, color: Colors.grey)),
                        Text(widget.product.weight.toString() + ' Grams',
                            style: redNumberFont.copyWith(fontSize: 14, color: Colors.black)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Category',
                            style:
                                blackMonstadtTextFont.copyWith(fontSize: 14, color: Colors.grey)),
                        Text(widget.product.category.toString(),
                            style: blackMonstadtTextFont.copyWith(fontSize: 14)),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Seller Website',
                            style:
                                blackMonstadtTextFont.copyWith(fontSize: 14, color: Colors.grey)),
                        Text(widget.product.website ?? '-',
                            style: blackMonstadtTextFont.copyWith(fontSize: 14)),
                      ],
                    ),
                    SizedBox(height: 88)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 88,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          alignment: Alignment.center,
          child: Wrap(
            spacing: 15,
            runSpacing: 5,
            children: [
              FlatButton(
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                minWidth: (MediaQuery.of(context).size.width - (2 * defaultMargin)) * 0.7,
                color: Colors.blue,
                child: Text(
                  'BUY',
                  style: blackTextFont.copyWith(
                      fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  SharedPreferences isMerchant =
                      await SharedPreferences.getInstance(); //Save isMerchant
                  int checkMerchant = (isMerchant.getInt('isMerchant'));
                  print('Buy Tapped ' + checkMerchant.toString());
                  Cart cart = Cart(
                    id: widget.product.id,
                    productName: widget.product.productName,
                    urlPreview: widget.product.preview,
                    price: widget.product.price,
                    qty: 1,
                    weight: widget.product.weight,
                    idMerchant: widget.product.merchantId,
                    merchantName: widget.product.merchant,
                    merchantLogo: widget.product.merchantLogo,
                    idProvinceM: widget.product.idProvinceM,
                    idCityM: widget.product.idCityM,
                  );
                  List<Cart> _cart = []; //Init Empty String

                  LocalStorage.db.getCart().then((value) async {
                    _cart = value;
                    print(_cart);
                    if (_cart.length == 0) {
                      await isMerchant.setInt('isMerchant', cart.idMerchant);
                      LocalStorage.db.insert(cart);
                      Get.snackbar('Product Added to Cart', 'This Product Has been added to Cart');
                    } else {
                      for (int i = 0; i <= _cart.length - 1; i++) {
                        if (cart.idMerchant != checkMerchant) {
                          Widget cancelButton = FlatButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Get.back();
                            },
                          );
                          Widget continueButton = FlatButton(
                            child: Text("Add"),
                            onPressed: () async {
                              LocalStorage.db.deleteAll();
                              LocalStorage.db.insert(cart);
                              await isMerchant.setInt('isMerchant', cart.idMerchant);
                              Get.back();
                              Get.snackbar(
                                  'Product Added to Cart', 'This Product Has been added to Cart');
                            },
                          );
                          AlertDialog alert = AlertDialog(
                            title: Text("Already Have Product From Another Merchant"),
                            content:
                                Text("Are you sure to add this item and remove old item in cart ?"),
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
                          break;
                        } else if (cart.id == _cart[i].id) {
                          Get.snackbar('Product Exist In Cart', 'This Product exist in cart');
                          break;
                        } else if (cart.id != _cart[i].id) {
                          Get.snackbar(
                              'Product Added to Cart', 'This Product Has been added to Cart.');
                          await isMerchant.setInt('isMerchant', cart.idMerchant);
                          LocalStorage.db.insert(cart);
                        }
                      }
                    }
                  });
                },
              ),
              InkWell(
                onTap: () {
                  print('Chat Tapped');

                  FirebaseFirestore.instance
                      .collection('rooms')
                      .doc(widget.product.merchantId.toString() +
                          '-' +
                          (context.read<UserCubit>().state as UserLoaded)
                              .user
                              .id
                              .toString()) //idMerchant-idUser
                      .set({
                    'id_merchant': widget.product.merchantId.toString(), //Id Merchant
                    'id_user': (context.read<UserCubit>().state as UserLoaded)
                        .user
                        .id
                        .toString(), //Id Merchant
                    'url_photo': widget.product.merchantLogo,
                    'merchant_name': widget.product.merchant,
                    'created_at': DateTime.now(),
                  });
                  Get.to(DetailChat(
                      peerId: widget.product.merchantId.toString(),
                      peerAvatar: widget.product.merchantLogo,
                      peerName: widget.product.merchant));
                },
                child: SizedBox(
                  height: 50,
                  width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) * 0.2,
                  child: Icon(Icons.chat, color: HexColor('#373E4C')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
