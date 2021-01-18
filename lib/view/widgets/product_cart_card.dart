part of 'widgets.dart';

class ProductCardCard extends StatelessWidget {
  const ProductCardCard({
    Key key,
  }) : super(key: key);

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
                image: NetworkImage('https://bit.ly/2KeWtyW'),
              ),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loca Sonokeling',
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
                        },
                        child: Icon(Icons.arrow_drop_down)),
                    Text('1'),
                    InkWell(
                        onTap: () {
                          //note: Increase Qty
                        },
                        child: Icon(Icons.arrow_drop_up)),
                  ]),
                ),
                SizedBox(width: 10),
                Text('X'),
                SizedBox(width: 10),
                SizedBox(
                  width: 85,
                  child: Text(
                    NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                        .format(20000),
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
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Subtotal :', style: redNumberFont.copyWith(fontSize: 12, color: Colors.grey)),
          Text(
            NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(20000),
            style: redNumberFont.copyWith(fontSize: 12),
          ),
        ],
      ),
      Divider(),
    ]);
  }
}