part of 'pages.dart';

class MainTab extends StatefulWidget {
  @override
  _MainTabState createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  var backgroundImage;
  @override
  void initState() {
    super.initState();
    backgroundBannerAPI();
  }

  Future<dynamic> backgroundBannerAPI() async {
    String url = baseURL + 'banner';
    var response = await http.get(url);
    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      return response.statusCode.toString();
    }
    //var data = jsonDecode(response.body);
    backgroundImage = response.body;
    return backgroundImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              FutureBuilder(
                  future: backgroundBannerAPI(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
                              image: NetworkImage(backgroundImage)),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
              Container(
                child: Column(
                  children: [
                    Container(
                      //note: Greetings + Fistname User From Userstate
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                          YonoGreetings.showGreetings() +
                              " " +
                              (context.watch<UserCubit>().state as UserLoaded)
                                  .user
                                  .first_name, //First Name
                          style: blackTextFont.copyWith(fontSize: 24, fontWeight: FontWeight.w400),
                          maxLines: 1,
                          overflow: TextOverflow.clip),
                    ),
                    //here
                    Container(
                      child: Column(
                        children: [
                          //note : Search Box
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(SearchPage());
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - (2 * defaultMargin),
                              height: 50,
                              alignment: Alignment.centerLeft,
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
                                  Text(
                                    'What are you looking for ?',
                                    style: greyTextFont.copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: 200,
                            child: FutureBuilder(
                                future: AppContentServices.showMainAppContentFormat(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    return CarouselSlider(
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        autoPlayInterval: Duration(seconds: 4),
                                        height: MediaQuery.of(context).size.width * 0.5,
                                      ),
                                      items: snapshot.data.map<Widget>((i) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            AppContent content = i;
                                            return GestureDetector(
                                              onTap: () async {
                                                if (content.idMerchant != null) {
                                                  ApiReturnValue<Merchant> result =
                                                      await MerchantService.showByMerchantId(
                                                          merchantId:
                                                              content.idMerchant.toString());
                                                  Get.to(DetailMerchant(merchant: result.value));
                                                  print(content.idMerchant);
                                                } else {
                                                  print('No Route Banner');
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 5),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    image: DecorationImage(
                                                      image: NetworkImage(content.urlImage),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  //child: Text(i ?? 'Image not Found'), //Debug Show Link image
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    );
                                  } else {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                }),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          // TODO: User Interest Categories (ganti pake merchant_category join ke merchant join ke product)
                          // SizedBox(
                          //   height: 100,
                          //   child:
                          //       BlocBuilder<UserInterestCubit, UserInterestState>(builder: (_, state) {
                          //     if (state is UserInterestLoaded) {
                          //       List<UserInterest> interest = state.userInterest;
                          //       return ListView.builder(
                          //           itemBuilder: (_, index) => Container(
                          //               margin: EdgeInsets.only(
                          //                   left: (index == 0) ? defaultMargin : 0,
                          //                   right: (index == interest.length - 1) ? defaultMargin : 16),
                          //               child: Wrap(children: [
                          //                 InterestCard(
                          //                   interest[index],
                          //                   onTap: () async {
                          //                     await context
                          //                         .read<ProductByCategoryCubit>()
                          //                         .showProductByCategory(
                          //                             categoryId: interest[index].idCategory);

                          //                     Get.to(CategoryPage(
                          //                       userInterest: interest[index],
                          //                     ));
                          //                   },
                          //                 ),
                          //               ])),
                          //           itemCount: interest.length,
                          //           scrollDirection: Axis.horizontal);
                          //     } else {
                          //       return Center(child: CircularProgressIndicator());
                          //     }
                          //   }),
                          // ),
                          SizedBox(
                            height: 100,
                            child: BlocBuilder<MerchantcategoryCubit, MerchantcategoryState>(
                                builder: (_, state) {
                              if (state is MerchantCategoryListLoaded) {
                                List<MerchantCategory> merchantCat = state.merchantCategory;
                                return ListView.builder(
                                    itemBuilder: (_, index) => Container(
                                        margin: EdgeInsets.only(
                                            left: (index == 0) ? defaultMargin : 0,
                                            right: (index == merchantCat.length - 1)
                                                ? defaultMargin
                                                : 16),
                                        child: Wrap(children: [
                                          MerchantCategoryCard(
                                            merchantCat[index],
                                            onTap: () async {
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return Center(
                                                      child: CircularProgressIndicator(),
                                                    );
                                                  });
                                              await context
                                                  .read<ProductbymerchatcatCubit>()
                                                  .showMerchantCategorybyId(
                                                      id: merchantCat[index].id.toString());
                                              Get.back();
                                              //buat loading disini
                                              Get.to(CategoryPage(
                                                merchantCategory: merchantCat[index],
                                              ));
                                            },
                                          ),
                                        ])),
                                    itemCount: merchantCat.length,
                                    scrollDirection: Axis.horizontal);
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            }),
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 16),
                            alignment: Alignment.centerLeft,
                            child: Text('Trending', style: blackTextFont.copyWith(fontSize: 25)),
                          ),
                          //note: Trending Feed
                          BlocBuilder<FeedbestsellerCubit, FeedbestsellerState>(
                              builder: (_, state) {
                            if (state is FeedByBestSellerListLoaded) {
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 16),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Who to Follow',
                              style: blackTextFont.copyWith(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          // note: Merhcant Follow
                          SizedBox(
                            height: 200,
                            child: BlocBuilder<MerchantRandomOrderCubit, MerchantRandomOrderState>(
                                builder: (_, state) {
                              if (state is MerchantByRandomListLoaded) {
                                List<Merchant> merchant = state.merchant;

                                return ListView.builder(
                                  itemCount: merchant.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: (index == 0) ? defaultMargin : 0,
                                          right:
                                              (index == merchant.length - 1) ? defaultMargin : 16),
                                      child: Wrap(children: [
                                        MerchantCard(
                                          merchant: merchant[index],
                                          onTap: () {
                                            print('Merchant Card Tapped');
                                            //
                                          },
                                        ),
                                      ]),
                                    );
                                  },
                                );
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            }),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 16),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Discover',
                              style: blackTextFont.copyWith(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          //Discover Feed Limit 21 (Random)
                          BlocBuilder<FeedrandomCubit, FeedrandomState>(builder: (_, state) {
                            if (state is FeedRandomListLoaded) {
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
