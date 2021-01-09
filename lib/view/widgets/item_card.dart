part of 'widgets.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function onTap;
  ItemCard({this.product, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('tap card');
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
                    onTap: () {
                      // onTap Shop Button
                      print('tap Button');
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
