part of 'widgets.dart';

//NGGAK DIPAKE
class FeedProductSearchCard extends StatelessWidget {
  final Product product;
  FeedProductSearchCard({this.product});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //
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
