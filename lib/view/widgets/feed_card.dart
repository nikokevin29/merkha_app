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
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: (feed.merchantLogo != null)
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(feed.merchantLogo),
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
                        Text(feed.merchantName,
                            style: blackMonstadtTextFont.copyWith(fontSize: 13)),
                        Text(
                          feed.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: blackMonstadtTextFont.copyWith(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.more_horiz,
                  color: HexColor('#2A2A2A'),
                ),
              ],
            ),
            SizedBox(height: 9),
            Container(
              width: MediaQuery.of(context).size.width - (3 * defaultMargin),
              height: MediaQuery.of(context).size.width - (3 * defaultMargin),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(feed.urlImage),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Wrap(spacing: 15, children: [
                    Icon(Icons.send, color: HexColor('#707070')),
                    Icon(Icons.chat_bubble_outline, color: HexColor('#707070')),
                    Icon(Icons.favorite_border, color: HexColor('#707070')),
                  ]),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.centerLeft,
              child: Text(feed.merchantName,
                  style: blackTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(feed.caption,
                        style: blackTextFont.copyWith(fontSize: 12),
                        textAlign: TextAlign.justify,
                        maxLines: 10),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  color: HexColor('#F2F2F2'), borderRadius: BorderRadius.all(Radius.circular(22))),
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
                          feed.productName,
                          style: blackTextFont.copyWith(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                              .format(feed.productPrice),
                          style: redNumberFont.copyWith(fontSize: 12)),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      print(feed.idProduct.toString());
                      ApiReturnValue<Product> result =
                          await ProductServices.getProductById(id: feed.idProduct.toString());
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
                          Get.snackbar(
                              'Product Added to Cart', 'This Product Has been added to Cart');
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
                    child: Container(
                      height: 54,
                      width: 84,
                      child: Image.asset('assets/button_shop.png'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
