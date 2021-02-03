part of 'pages.dart';

class DetailMerchant extends StatefulWidget {
  DetailMerchant({Key key}) : super(key: key);

  @override
  _DetailMerchantState createState() => _DetailMerchantState();
}

class _DetailMerchantState extends State<DetailMerchant> {
  List<Widget> _randomChildren;

  List<Widget> _randomHeightWidgets(BuildContext context) {
    _randomChildren = List.generate(1, (index) => buildHeaderMerchant(context));
    return _randomChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Merchant Name', style: blackTextFont.copyWith()),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          FlatButton(
            onPressed: () {
              print('tap Follow');
            },
            child: Text(
              'Follow +',
              style: blackTextFont.copyWith(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  print('tap more horiz');
                },
                child: Icon(Icons.more_horiz, color: Colors.black)),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(delegate: SliverChildListDelegate(_randomHeightWidgets(context))),
            ];
          },
          body: Column(
            children: [
              TabBar(
                indicatorColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                    iconMargin: const EdgeInsets.only(bottom: 5.0),
                    text: 'Home',
                  ),
                  Tab(
                    icon: Icon(Icons.widgets),
                    iconMargin: const EdgeInsets.only(bottom: 5.0),
                    text: 'Feeds',
                  ),
                  Tab(
                    icon: Icon(Icons.inventory),
                    iconMargin: const EdgeInsets.only(bottom: 5.0),
                    text: 'Product',
                  ),
                  Tab(
                    icon: Icon(Icons.rate_review),
                    iconMargin: const EdgeInsets.only(bottom: 5.0),
                    text: 'Review',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  HomeMerchant(),
                  FeedMerchant(),
                  ProductMerchant(),
                  ReviewMerchant(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeMerchant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Home'),
    );
  }
}

class FeedMerchant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Feed'),
    );
  }
}

class ProductMerchant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Product'),
    );
  }
}

class ReviewMerchant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Review'),
    );
  }
}

Widget buildHeaderMerchant(BuildContext context) {
  return Container(
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) * 0.75,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    Flexible(
                      child: Text(
                        'Search' + ' Woodka',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: greyTextFont.copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                minWidth: (MediaQuery.of(context).size.width - (2 * defaultMargin)) * 0.1,
                onPressed: () {
                  //
                },
                child: SizedBox(
                  height: 35,
                  width: (MediaQuery.of(context).size.width - (2 * defaultMargin)) * 0.1,
                  child: Icon(Icons.chat, color: HexColor('#373E4C')),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                    child: Stack(
                      children: [
                        //TODO: Nanti Ganti Jadi Logo Merchant
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: ((context.watch<UserCubit>().state as UserLoaded)
                                            .user
                                            .urlphoto !=
                                        null)
                                    ? NetworkImage((context.watch<UserCubit>().state as UserLoaded)
                                        .user
                                        .urlphoto)
                                    : AssetImage("assets/defaultProfile.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Merchant Name',
                    style: blackTextFont.copyWith(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 15, color: Colors.grey),
                      Text(
                        'Merchant Address, Indonesia',
                        style: blackTextFont.copyWith(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                                NumberFormat.compactCurrency(decimalDigits: 0, symbol: '')
                                    .format(999),
                                style: whiteNumberFont.copyWith(fontSize: 10, color: Colors.black)),
                            Text(' Follwers ', style: blackTextFont.copyWith(fontSize: 10))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 15),
                            Text('1 Hours Ago ', style: blackTextFont.copyWith(fontSize: 10))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, size: 15),
                            Text('4.5 Ratings', style: blackTextFont.copyWith(fontSize: 10))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}
