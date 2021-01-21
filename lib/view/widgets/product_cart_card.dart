part of 'widgets.dart';

class ProductCardCard extends StatefulWidget {
  final Cart cart;
  const ProductCardCard({this.cart});

  @override
  _ProductCardCardState createState() => _ProductCardCardState();
}

class _ProductCardCardState extends State<ProductCardCard> {
  Cart cart;
  @override
  void initState() {
    super.initState();
    cart = widget.cart; //Setter
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //Product Cart Builder Here
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
                image: NetworkImage(cart.urlPreview),
              ),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //note: Product Name
              Text(
                cart.productName,
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
                          if (cart.qty == 1) {
                            print('min qty 1');
                          } else {
                            LocalStorage.db.updateQty(Cart(qty: cart.qty = cart.qty - 1));
                            print(cart.qty.toString());
                          }
                          setState(() {});
                        },
                        child: Icon(Icons.arrow_drop_down)),
                    Text(cart.qty.toString()),
                    InkWell(
                        onTap: () {
                          //note: Increase Qty
                          LocalStorage.db.updateQty(Cart(qty: cart.qty = cart.qty + 1));
                          print(cart.qty.toString());
                          setState(() {});
                        },
                        child: Icon(Icons.arrow_drop_up)),
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
                        .format(cart.price),
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
  }
}
