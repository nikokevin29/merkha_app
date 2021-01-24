part of 'widgets.dart';

class ItemCardWishlist extends StatelessWidget {
  final Product product;
  final Function onTap;
  ItemCardWishlist({this.product, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailProduct(product: product));
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 4 * defaultMargin) / 2,
        height: 215,
        child: Column(
          children: [
            Stack(
              fit: StackFit.passthrough,
              children: [
                Container(
                  //Image Product
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: (product.preview != null)
                            ? NetworkImage(product.preview)
                            : AssetImage('assets/logo-yellow.png'),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(spreadRadius: 3, blurRadius: 15, color: Colors.black12),
                    ],
                  ),
                ),
                Positioned(
                  top: 115,
                  left: 85,
                  child: GestureDetector(
                    child: Container(
                      //Button Shop
                      width: 55,
                      height: 30,
                      padding: EdgeInsets.only(bottom: 5, left: 5),
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/button_shop.png'),
                        ),
                      ),
                    ),
                    onTap: () async {
                      // onTap Shop Button
                      print('tap Button');
                      SharedPreferences isMerchant =
                          await SharedPreferences.getInstance(); //Save isMerchant
                      int checkMerchant = (isMerchant.getInt('isMerchant'));
                      print('Buy Tapped');
                      Cart cart = Cart(
                        id: product.id,
                        productName: product.productName,
                        urlPreview: product.preview,
                        price: product.price,
                        qty: 1,
                        weight: product.weight,
                        idMerchant: product.merchantId,
                        merchantName: product.merchant,
                        merchantLogo: product.merchantLogo,
                        idProvinceM: product.idProvinceM,
                        idCityM: product.idCityM,
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
                                onPressed: () {
                                  LocalStorage.db.deleteAll();
                                  LocalStorage.db.insert(cart);
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
                            } else {
                              Get.snackbar(
                                  'Product Added to Cart', 'This Product Has been added to Cart');
                              await isMerchant.setInt('isMerchant', cart.idMerchant);
                              LocalStorage.db.insert(cart);
                              break;
                            }
                          }
                        }
                      });
                    },
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 120,
                  child: GestureDetector(
                    child: Icon(Icons.cancel, color: Colors.blue),
                    onTap: () async {
                      // onTap Delete
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      context.read<WishlistCubit>().deleteWishlist(product.id.toString());
                      context.read<WishlistCubit>().showWishlist();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //Proudct Name
                    product.productName,
                    style: blackTextFont.copyWith(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    //Price
                    NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                        .format(product.price),
                    style: redNumberFont,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    //Merchant
                    'by ' + product.merchant,
                    style: greyTextFont.copyWith(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
