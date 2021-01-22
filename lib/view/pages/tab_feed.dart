part of 'pages.dart';

class FeedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Container(
            height: 35,
            width: 50,
            child: Image.asset("assets/merkha-yellow.png"),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //
              Card(
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
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://cf.shopee.co.id/file/212900d04161ecd95384307754aa7462'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Woodka',
                                      style: blackMonstadtTextFont.copyWith(fontSize: 13)),
                                  Text(
                                    'Jl. karang jengkol RT.32/ RW.15',
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
                              image: NetworkImage(
                                  'https://media.karousell.com/media/photos/products/2017/07/16/jam_tangan_woodka_mini_orla__strap_beige_blue_tenun_1500203492_706ec80d.jpg'),
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
                        child: Text('Woodka ',
                            style:
                                blackTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                  'caption hereaw dawdawda wdawda wdawdada dadawd adada awdad adaawd adadaaw dadada adada adada daadawdaw awd awdawd awdawdawd ',
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
                                    'Jam Tangan Kayu Woodka (Mini Orla) + Strap Beige Blue Tenun',
                                    style: blackTextFont.copyWith(fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                    NumberFormat.currency(
                                            locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                        .format(500000),
                                    style: redNumberFont.copyWith(fontSize: 12)),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                print('tap buy');
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
              ),
            ],
          ),
        ));
  }
}
