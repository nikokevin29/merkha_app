part of 'pages.dart';

class DetailMerchant extends StatefulWidget {
  final Feed feed;
  final Merchant merchant;
  DetailMerchant({this.feed, this.merchant});

  @override
  _DetailMerchantState createState() => _DetailMerchantState();
}

class _DetailMerchantState extends State<DetailMerchant> {
  String merchantName;
  String idMerchant;
  String merchantLogo;
  String merchantDescription;
  String merchantWebsite;
  String merchantLastAccess;
  String merchantLocation;
  @override
  void initState() {
    super.initState();
    if (widget.feed == null) {
      merchantName = widget.merchant.merchantName;
      idMerchant = widget.merchant.merchantId;
      merchantLogo = widget.merchant.merchantLogo;
      merchantDescription = widget.merchant.description;
      merchantWebsite = widget.merchant.website;
      merchantLastAccess = widget.merchant.lastAccess;
      merchantLocation = widget.merchant.province;
    } else {
      merchantName = widget.feed.merchantName;
      idMerchant = widget.feed.idMerchant.toString();
      merchantLogo = widget.feed.merchantLogo;
      merchantDescription = widget.feed.merchantDescription;
      merchantWebsite = widget.feed.merchantWebsite;
      merchantLastAccess = widget.feed.merchantLastAccess;
      merchantLocation = widget.feed.location;
    }
    context.read<OperationalHoursCubit>().showOperational(idMerchant);
  }

  List<Widget> _randomChildren;

  List<Widget> _randomHeightWidgets(
    BuildContext context,
    String merchantName,
    String idMerchant,
    String merchantLogo,
    String merchantDescription,
    String merchantWebsite,
    String merchantLastAccess,
    String merchantLocation,
  ) {
    _randomChildren = List.generate(
        1,
        (index) => buildHeaderMerchant(
              context,
              merchantName,
              idMerchant,
              merchantLogo,
              merchantDescription,
              merchantWebsite,
              merchantLastAccess,
              merchantLocation,
            ));
    return _randomChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(merchantName, style: blackTextFont.copyWith(fontSize: 14)),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          FutureBuilder(
              future: FollowingService.checkstatus(id: idMerchant),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FlatButton(
                    onPressed: () async {
                      if (snapshot.data == idMerchant) {
                        print('unfollow');
                        await context.read<FollowCubit>().unfollow(id: idMerchant);
                        if (mounted) setState(() {});
                      } else {
                        print('follow');
                        await context.read<FollowCubit>().follow(id: idMerchant);
                        if (mounted) setState(() {});
                      }
                    },
                    child: Text(
                      (snapshot.data == idMerchant) ? 'Unfollow' : 'Follow +',
                      style: blackTextFont.copyWith(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  return Center(
                      child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator()));
                }
              }),
          Flexible(
            child: PopupMenuButton(
              icon: Icon(Icons.more_vert, color: Colors.grey),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        onClickOperationalHours();
                      },
                      child: ListTile(
                        leading: Icon(Icons.schedule, color: Colors.black),
                        title:
                            Text('Operational Hours', style: blackTextFont.copyWith(fontSize: 14)),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Icon(Icons.schedule, color: Colors.black),
                    //     SizedBox(width: 5),
                    //     Text('Operational Hours', style: blackTextFont.copyWith(fontSize: 14)),
                    //   ],
                    // ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                  delegate: SliverChildListDelegate(_randomHeightWidgets(
                context,
                merchantName,
                idMerchant,
                merchantLogo,
                merchantDescription,
                merchantWebsite,
                merchantLastAccess,
                merchantLocation,
              ))),
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
                  HomeMerchant(
                    feed: widget.feed,
                    idMerchant: idMerchant,
                    merchantName: merchantName,
                    merchantWebsite: merchantWebsite,
                    description: merchantDescription,
                  ), //used id_merchant, merchant_name, website, description
                  FeedMerchant(feed: widget.feed, idMerchant: idMerchant),
                  ProductMerchant(idMerch: idMerchant),
                  ReviewMerchantPage(idMerchant: idMerchant),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onClickOperationalHours() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: defaultMargin, right: defaultMargin),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.back();
                      },
                      child: Icon(Icons.close, color: Colors.black)),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.84,
                  width: MediaQuery.of(context).size.width,
                  child: BlocBuilder<OperationalHoursCubit, OperationalHoursState>(
                    builder: (_, state) => (state is OperationalHoursListLoaded)
                        ? ListView(children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: defaultMargin),
                              child: Text('Operational Hours',
                                  style: blackTextFont.copyWith(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: state.operational
                                  .map((e) => Padding(
                                        padding: EdgeInsets.only(
                                            top: (e == state.operational.first) ? 15 : 0,
                                            bottom: (e == state.operational.last) ? 15 : 0),
                                        child: Flexible(
                                            child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(e.days,
                                                style: blackTextFont.copyWith(fontSize: 15)),
                                            Row(
                                              children: [
                                                Text(e.startTime,
                                                    style: blackTextFont.copyWith(fontSize: 15)),
                                                Text(' - '),
                                                Text(e.endTime,
                                                    style: blackTextFont.copyWith(fontSize: 15)),
                                                Divider(),
                                              ],
                                            ),
                                          ],
                                        )),
                                      ))
                                  .toList(),
                            ),
                          ])
                        : Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class HomeMerchant extends StatefulWidget {
  final Feed feed;
  final String idMerchant;
  final String merchantName;
  final String merchantWebsite;
  final String description;
  HomeMerchant({
    this.feed,
    this.idMerchant,
    this.merchantName,
    this.merchantWebsite,
    this.description,
  });
  @override
  _HomeMerchantState createState() => _HomeMerchantState();
}

class _HomeMerchantState extends State<HomeMerchant> {
  var appContent;
  @override
  void initState() {
    super.initState();
    appContentAPI(widget.idMerchant.toString());
    context
        .read<BestSellerProductCubit>()
        .showProductbyBestSeller(id: widget.idMerchant.toString());
  }

  Future<dynamic> appContentAPI(String idMerchant) async {
    String url = baseURL + 'app_content/merchant/' + idMerchant;
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      return response.statusCode.toString();
    }
    var data = await jsonDecode(response.body);
    if (this.mounted) {
      setState(() {
        appContent = List<String>.from(data);
      });
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: defaultMargin),
              child: (appContent != null)
                  ? CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        //autoPlayInterval: Duration(milliseconds: 10000),
                        height: MediaQuery.of(context).size.width * 0.5,
                      ),
                      items: appContent.map<Widget>((i) {
                        print(i);
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(i),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                //child: Text(i ?? 'Image not Found'), //Debug Show Link image
                              ),
                            );
                          },
                        );
                      }).toList(),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width - (2 * defaultMargin),
                      height: MediaQuery.of(context).size.width * 0.5,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[200],
                        highlightColor: Colors.white,
                        child: Container(
                          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
                          height: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.merchantName ?? '',
                    style: blackTextFont.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  ReadMoreText(
                    widget.description ?? '',
                    textAlign: TextAlign.justify,
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' more',
                    trimExpandedText: ' show less',
                    moreStyle: blackTextFont.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  (widget.merchantWebsite != null)
                      ? InkWell(
                          child: Text(widget.merchantWebsite,
                              style: blackTextFont.copyWith(color: Colors.blueAccent)),
                          onTap: () async {
                            if (await canLaunch('http:' + widget.merchantWebsite)) {
                              await launch(
                                'http:' + widget.merchantWebsite,
                                // forceSafariVC: false,
                                // forceWebView: false,
                              );
                            } else {
                              Get.snackbar('Could Not Launch', 'Cannot Launch this url',
                                  snackPosition: SnackPosition.BOTTOM);
                              throw 'Could not launch ' + widget.merchantWebsite;
                            }
                          })
                      : Container(),
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
                          widget.merchantName + '`s' + ' Best Seller',
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

Widget buildHeaderMerchant(BuildContext context, merchantName, idMerchant, merchantLogo,
    merchantDescription, merchantWebsite, merchantLastAccess, merchantLocation) {
  var lastOnlineFormated = DateTime.now()
      .difference(DateFormat("yyyy-MM-dd hh:mm:ss").parse(merchantLastAccess))
      .inHours;
  return Container(
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(SearchProductMerchant(idMerchant: idMerchant, merchantName: merchantName));
                },
                child: Container(
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
                          'Search ' + merchantName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: greyTextFont.copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
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
                  child: InkWell(
                      onTap: () {
                        FirebaseFirestore.instance
                            .collection('rooms')
                            .doc(idMerchant +
                                '-' +
                                (context.read<UserCubit>().state as UserLoaded)
                                    .user
                                    .id
                                    .toString()) //idMerchant-idUser
                            .set({
                          'id_merchant': idMerchant, //Id Merchant
                          'id_user': (context.read<UserCubit>().state as UserLoaded)
                              .user
                              .id
                              .toString(), //Id Merchant
                          'url_photo': merchantLogo,
                          'merchant_name': merchantName,
                          'created_at': DateTime.now(),
                        });
                        Get.to(DetailChat(
                            peerId: idMerchant, peerAvatar: merchantLogo, peerName: merchantName));
                      },
                      child: Icon(Icons.chat, color: HexColor('#373E4C'))),
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
                                image: (merchantLogo != null)
                                    ? NetworkImage(merchantLogo)
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
                    merchantName,
                    style: blackTextFont.copyWith(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 15, color: Colors.grey),
                      Text(
                        merchantLocation,
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
                            //
                            FutureBuilder(
                                future: FollowingService.countFollowersMerchant(
                                    idMerchant: idMerchant.toString()),
                                builder: (BuildContext context, snapshot) {
                                  if (snapshot.hasData) {
                                    int data = snapshot.data;
                                    return Text(
                                      NumberFormat.compactCurrency(decimalDigits: 0, symbol: '')
                                          .format(data),
                                      style: whiteNumberFont.copyWith(
                                          fontSize: 11, color: Colors.black),
                                    );
                                  } else {
                                    Text('0',
                                        style: whiteNumberFont.copyWith(
                                            fontSize: 10, color: Colors.black));
                                  }
                                  return SizedBox(
                                      width: 10, height: 10, child: CircularProgressIndicator());
                                }),
                            Text(' Followers ', style: blackTextFont.copyWith(fontSize: 11))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 15),
                            Text(lastOnlineFormated.toString() + ' Hours Ago ',
                                style: blackTextFont.copyWith(fontSize: 11))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, size: 15),
                            FutureBuilder(
                                future: ReviewServices.avgReviewMerchant(idMerchant: idMerchant),
                                builder: (BuildContext context, snapshot) {
                                  if (snapshot.hasData) {
                                    print(snapshot.data);
                                    return Text(
                                      NumberFormat.compactCurrency(decimalDigits: 2, symbol: '')
                                          .format(snapshot.data),
                                      style:
                                          blackTextFont.copyWith(fontSize: 11, color: Colors.black),
                                    );
                                  } else {
                                    Text('0',
                                        style: whiteNumberFont.copyWith(
                                            fontSize: 11, color: Colors.black));
                                  }
                                  return SizedBox(
                                      width: 10, height: 10, child: CircularProgressIndicator());
                                }),
                            Text(' Ratings', style: blackTextFont.copyWith(fontSize: 11)),
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
