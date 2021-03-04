part of 'widgets.dart';

class FeedCard extends StatelessWidget {
  final Feed feed;
  FeedCard({this.feed});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (feed.idMerchant != 0 || feed.idMerchant == null) {
                      Get.to(DetailMerchant(feed: feed));
                    } else {
                      User usr;
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      await UserServices.showUserById(id: feed.idUser).then((value) {
                        usr = value.value;
                      });
                      await context.read<FeedbyuseridCubit>().showFeedByUserId(id: feed.idUser);
                      Get.back();
                      Get.to(DetailUser(idUser: feed.idUser, user: usr));
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: (feed.merchantLogo != null || feed.urlPhotoUser != null)
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(feed.merchantLogo ?? feed.urlPhotoUser),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : BoxDecoration(
                                image:
                                    DecorationImage(image: AssetImage('assets/defaultProfile.png')),
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 4,
                                    blurRadius: 4,
                                    offset: Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                      ),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(feed.merchantUsername ?? feed.username,
                              style: blackMonstadtTextFont.copyWith(fontSize: 13)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - (8 * defaultMargin),
                            child: Text(
                              feed.location ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: blackMonstadtTextFont.copyWith(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: PopupMenuButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.more_vert, color: Colors.grey),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'more',
                              child: FutureBuilder(
                                  future: ReportService.checkReportFeed(id: feed.id.toString()),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return InkWell(
                                        child: (snapshot.data.toString() == feed.id.toString())
                                            ? Container(
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  'Cancel Report',
                                                  style: whiteNumberFont.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              )
                                            : Container(
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  'Report Feed',
                                                  style: whiteNumberFont.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                        onTap: () async {
                                          if (snapshot.data.toString() == feed.id.toString()) {
                                            print('cancel report feed' +
                                                snapshot.data.toString() +
                                                '   ' +
                                                feed.id.toString());
                                            await ReportService.deleteReportFeed(
                                                feed.id.toString());
                                            Get.back();
                                            Get.snackbar('Feed Report Canceled',
                                                'This Feed Has Been Unreported');
                                          } else {
                                            print('report feed ' +
                                                snapshot.data.toString() +
                                                '   ' +
                                                feed.id.toString());
                                            await ReportService.createReportFeed(
                                                feed.id.toString());
                                            Get.back();
                                            Get.snackbar('Feed Reported',
                                                'This Feed Has Been Reported and will be check soon');
                                          }
                                        },
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  }),
                            ),
                          ]),
                ),
                // InkWell(
                //   onTap: () {
                //     print('tap');
                //   },
                //   child: Icon(
                //     Icons.more_horiz,
                //     color: HexColor('#2A2A2A'),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 9),
            GestureDetector(
              onTap: () async {
                Product product;
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                await ProductServices.getProductById(id: feed.idProduct)
                    .then((value) => product = value.value);
                if (product != null) {
                    Get.back();
                    Get.to(DetailProduct(product: product));
                } else {
                  Get.back();
                  Get.snackbar('Product Doesnt Exist', 'Product has been paused or deleted');
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width - (3 * defaultMargin),
                height: MediaQuery.of(context).size.width - (3 * defaultMargin),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: (feed.urlImage != null)
                          ? NetworkImage(feed.urlImage)
                          : AssetImage('assets/img_not_available.jpeg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Wrap(spacing: 15, children: [
                    //note: Comment Button
                    InkWell(
                        onTap: () => Get.to(CommentPage(feed: feed)),
                        child: Icon(Icons.chat_bubble_outline, color: HexColor('#707070'))),
                    //note:Like Button
                    FutureBuilder(
                        future: FeedLikeService.checkStatusLike(idFeed: feed.id.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.data.toString() == feed.id.toString()) {
                            return GestureDetector(
                              onTap: () async {
                                await FeedLikeService.deleteLike(idFeed: feed.id.toString());
                              },
                              child: Icon(Icons.favorite, color: Colors.red),
                            );
                          } else if (snapshot.data.toString() != feed.id.toString()) {
                            return GestureDetector(
                              onTap: () async {
                                await FeedLikeService.createLike(idFeed: feed.id.toString());
                              },
                              child: Icon(Icons.favorite_border, color: HexColor('#707070')),
                            );
                          } else {
                            return GestureDetector(
                              // onTap: () async {
                              //   await FeedLikeService.createLike(idFeed: feed.id.toString());
                              // },
                              child: SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        }),
                  ]),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.centerLeft,
              child: Text(feed.merchantUsername ?? feed.username, //
                  style: blackTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(feed.caption ?? '',
                        style: blackTextFont.copyWith(fontSize: 12),
                        textAlign: TextAlign.justify,
                        maxLines: 10),
                  ),
                ],
              ),
            ),
            //note: Comment Button
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Get.to(CommentPage(feed: feed));
                },
                child: Text(
                  'View Comments ',
                  style: blackTextFont.copyWith(fontSize: 13, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 15),
            //note: Widget Product (productName,productPrice, and Button Add to Cart)
            (feed.productName != null)
                ? Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: HexColor('#F2F2F2'),
                        borderRadius: BorderRadius.all(Radius.circular(22))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 130,
                              child: Text(
                                feed.productName ?? '',
                                style: blackTextFont.copyWith(fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                                NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                    .format(double.parse(feed.productPrice) ?? 0),
                                style: redNumberFont.copyWith(fontSize: 12)),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            print(feed.idProduct.toString());
                            ApiReturnValue<Product> result =
                                await ProductServices.getProductById(id: feed.idProduct.toString());
                            if (result != null) {
                              SharedPreferences isMerchant =
                                  await SharedPreferences.getInstance(); //Save isMerchant
                              int checkMerchant = (isMerchant.getInt('isMerchant'));
                              print('Buy Tapped');
                              Cart cart = Cart(
                                id: result.value.id,
                                productName: result.value.productName,
                                urlPreview: result.value.preview,
                                price: result.value.price,
                                qty: 1,
                                weight: result.value.weight,
                                idMerchant: result.value.merchantId,
                                merchantName: result.value.merchant,
                                merchantLogo: result.value.merchantLogo,
                                idProvinceM: result.value.idProvinceM,
                                idCityM: result.value.idCityM,
                              );
                              List<Cart> _cart = []; //Init Empty String

                              LocalStorage.db.getCart().then((value) async {
                                _cart = value;
                                print(_cart);
                                if (_cart.length == 0) {
                                  await isMerchant.setInt('isMerchant', cart.idMerchant);
                                  LocalStorage.db.insert(cart);
                                  Get.snackbar('Product Added to Cart',
                                      'This Product Has been added to Cart');
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
                                          Get.snackbar('Product Added to Cart',
                                              'This Product Has been added to Cart');
                                        },
                                      );
                                      AlertDialog alert = AlertDialog(
                                        title: Text("Already Have Product From Another Merchant"),
                                        content: Text(
                                            "Are you sure to add this item and remove old item in cart ?"),
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
                                      Get.snackbar(
                                          'Product Exist In Cart', 'This Product exist in cart');
                                      break;
                                    } else if (cart.id != _cart[i].id) {
                                      Get.snackbar('Product Added to Cart',
                                          'This Product Has been added to Cart.');
                                      await isMerchant.setInt('isMerchant', cart.idMerchant);
                                      LocalStorage.db.insert(cart);
                                    }
                                  }
                                }
                              });
                            } else {
                              Get.snackbar(
                                  'Product Doest Exist', 'Product has Been Paused or Deleted');
                            }
                          },
                          child: Container(
                            height: 54,
                            width: 84,
                            child: Image.asset('assets/button_shop.png'),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
