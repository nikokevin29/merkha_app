part of 'widgets.dart';

class ItemCard extends StatelessWidget {
  // final Product product;

  // ItemCard(this.product);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('tap card');
      },
      child: Container(
        width: 145,
        height: 260,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(spreadRadius: 3, blurRadius: 15, color: Colors.black12),
          ],
        ),
        child: Column(
          children: [
            Stack(
              fit: StackFit.loose,
              children: [
                Container(
                  //Image Product
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                    image: DecorationImage(
                        image: NetworkImage('https://bit.ly/3b2rIIC'), fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 145,
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
                    'Product Name',
                    style: blackTextFont,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    //Price
                    'Rp.100.000',
                    style: redNumberFont,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    //Merchant
                    'by xBanana',
                    style: blackTextFont,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
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
