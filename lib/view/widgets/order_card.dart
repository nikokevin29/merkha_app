part of 'widgets.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  OrderCard({this.order});

  @override
  Widget build(BuildContext context) {
    return ExpansionCard(
      title: Column(
        children: [
          Row(
            children: [
              Container(
                height: (MediaQuery.of(context).size.width - (2 * defaultMargin)) * 0.25,
                width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) * 0.25,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                    color: Colors.grey[200],
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://ecs7.tokopedia.net/img/cache/900/product-1/2020/2/11/8134924/8134924_3ee990c6-86b8-48de-9ab0-a29a2890d581_920_920'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ON DELIVERY',
                        style: blackTextFont.copyWith(
                          fontSize: 15,
                          color: HexColor('#B3E2AC'),
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 9),
                    Text('ORD0101202101',
                        style: blackTextFont.copyWith(fontSize: 15)), // ORD-TGL-BLN-THN-ID
                    Text('03 JANUARY 2021', style: blackTextFont.copyWith(fontSize: 15)),
                    SizedBox(height: 9),
                    Text(
                      'Loca SonoKeling sssssssssssssssssssssssss',
                      style: blackTextFont.copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      'To: Jl Bangke No 6969 ssssssssssssssssssss',
                      style: blackTextFont.copyWith(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      'Mamprang Kabupaten ssssssssssssssssssssssss',
                      style: blackTextFont.copyWith(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      'Semarang, Jawa Tengah sssssssssssssssssss',
                      style: blackTextFont.copyWith(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping : ", style: blackTextFont),
                  Text(
                      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                          .format(10000000),
                      style: redNumberFont.copyWith()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total : ", style: blackTextFont),
                  Text(
                    NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                        .format(10000000),
                    style: redNumberFont.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
