part of 'pages.dart';

class DetailMerchant extends StatefulWidget {
  final Feed feed;
  DetailMerchant({this.feed});

  @override
  _DetailMerchantState createState() => _DetailMerchantState();
}

class _DetailMerchantState extends State<DetailMerchant> {
  List<Widget> _randomChildren;

  List<Widget> _randomHeightWidgets(BuildContext context, Feed feed) {
    _randomChildren = List.generate(1, (index) => buildHeaderMerchant(context, feed));
    return _randomChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.feed.merchantName, style: blackTextFont.copyWith()),
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
              SliverList(
                  delegate: SliverChildListDelegate(_randomHeightWidgets(context, widget.feed))),
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
                  HomeMerchant(feed: widget.feed),
                  FeedMerchant(feed: widget.feed),
                  ProductMerchant(idMerch: widget.feed.idMerchant.toString()),
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

class HomeMerchant extends StatefulWidget {
  final Feed feed;
  HomeMerchant({this.feed});
  @override
  _HomeMerchantState createState() => _HomeMerchantState();
}

class _HomeMerchantState extends State<HomeMerchant> {
  @override
  void initState() {
    super.initState();
    context
        .read<BestSellerProductCubit>()
        .showProductbyBestSeller(id: widget.feed.idMerchant.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.feed.merchantName,
                    style: blackTextFont.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  ReadMoreText(
                    widget.feed.merchantDescription,
                    textAlign: TextAlign.justify,
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' more',
                    trimExpandedText: ' show less',
                    moreStyle: blackTextFont.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  InkWell(
                      child: Text(widget.feed.merchantWebsite,
                          style: blackTextFont.copyWith(color: Colors.blueAccent)),
                      onTap: () async {
                        if (await canLaunch('http:' + widget.feed.merchantWebsite)) {
                          await launch(
                            'http:' + widget.feed.merchantWebsite,
                            // forceSafariVC: false,
                            // forceWebView: false,
                          );
                        } else {
                          Get.snackbar('Could Not Launch', 'Cannot Launch this url',
                              snackPosition: SnackPosition.BOTTOM);
                          throw 'Could not launch ' + widget.feed.merchantWebsite;
                        }
                      }),
                ],
              ),
            ),
            Divider(),
            //Best Seller Builder
            Center(
              child:
                  BlocBuilder<BestSellerProductCubit, BestSellerProductState>(builder: (_, state) {
                if (state is BestSellerProductListLoaded && state.product.isNotEmpty) {
                  List<Product> product = state.product;
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                        child: Text(
                          widget.feed.merchantName + '`s' + ' Best Seller',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: blackTextFont.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                            ),
                            itemCount: product.length,
                            itemBuilder: (_, index) => Container(
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    direction: Axis.vertical,
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      ProductCard(product[index], onTap: () {
                                        //Navigate to Details Here
                                      }),
                                    ],
                                  ),
                                )),
                      ),
                    ],
                  );
                } else {
                  return Center(child: Container());
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedMerchant extends StatefulWidget {
  final Feed feed;
  FeedMerchant({this.feed});
  @override
  _FeedMerchantState createState() => _FeedMerchantState();
}

class _FeedMerchantState extends State<FeedMerchant> {
  @override
  void initState() {
    super.initState();
    context
        .read<FeedbymerchantidCubit>()
        .showFeedByMerchantId(id: widget.feed.idMerchant.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FeedbymerchantidCubit, FeedbymerchantidState>(builder: (_, state) {
        if (state is FeedByIdMerchantListLoaded) {
          List<Feed> feed = state.feed;
          return Container(
            width: MediaQuery.of(context).size.width - 2 * defaultMargin,
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemCount: feed.length,
                itemBuilder: (_, index) => Container(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        direction: Axis.vertical,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          FeedBox(feed[index]),
                        ],
                      ),
                    )),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}

class ProductMerchant extends StatefulWidget {
  final Product product;
  final String idMerch;
  ProductMerchant({this.product, this.idMerch});
  @override
  _ProductMerchantState createState() => _ProductMerchantState();
}

class _ProductMerchantState extends State<ProductMerchant> {
  @override
  void initState() {
    super.initState();
    context.read<ProductbymerchantCubit>().showProductByMerchant(id: widget.idMerch);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: BlocBuilder<ProductbymerchantCubit, ProductbymerchantState>(builder: (_, state) {
          if (state is ProductByMerchantListLoaded) {
            List<Product> product = state.product;
            return Container(
              width: MediaQuery.of(context).size.width - 2 * defaultMargin,
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.73,
                  ),
                  itemCount: product.length,
                  itemBuilder: (_, index) => Container(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          direction: Axis.vertical,
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            ItemCard(product: product[index]),
                          ],
                        ),
                      )),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
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

Widget buildHeaderMerchant(BuildContext context, Feed feed) {
  var lastOnlineFormated = DateTime.now()
      .difference(DateFormat("yyyy-MM-dd hh:mm:ss").parse(feed.merchantLastAccess))
      .inHours;
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
                      padding: const EdgeInsets.symmetric(horizontal: defaultMargin - 7),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    Flexible(
                      child: Text(
                        'Search ' + feed.merchantName,
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
                                image: (feed.merchantLogo != null)
                                    ? NetworkImage(feed.merchantLogo)
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
                    feed.merchantName,
                    style: blackTextFont.copyWith(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 15, color: Colors.grey),
                      Text(
                        feed.location,
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
                            Text(lastOnlineFormated.toString() + ' Hours Ago ',
                                style: blackTextFont.copyWith(fontSize: 10))
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
