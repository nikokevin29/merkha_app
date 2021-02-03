part of 'pages.dart';

class MainTab extends StatefulWidget {
  @override
  _MainTabState createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  @override
  void initState() {
    super.initState();
  }

  final List<String> images = [
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
    'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                Container(
                  //note: Greetings + Fistname User From Userstate
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
                      //Carousel Photo
                      CarouselSlider.builder(
                        itemCount: images.length,
                        options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          enlargeCenterPage: true,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            child: Center(
                                child:
                                    Image.network(images[index], fit: BoxFit.cover, width: 1200)),
                          );
                        },
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
                                        right:
                                            (index == merchantCat.length - 1) ? defaultMargin : 16),
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
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Discover',
                          style: blackTextFont.copyWith(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      //Discover Product (Random)
                      BlocBuilder<ProductCubit, ProductState>(builder: (_, state) {
                        if (state is ProductListLoaded) {
                          List<Product> product = state.product;
                          return Container(
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
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
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
                                      right: (index == merchant.length - 1) ? defaultMargin : 16),
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
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Best Seller',
                          style: blackTextFont.copyWith(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      //note: Best Seller Product
                      BlocBuilder<BestSellerProductCubit, BestSellerProductState>(
                          builder: (_, state) {
                        if (state is BestSellerProductListLoaded) {
                          List<Product> product = state.product;
                          return Container(
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
        ),
      ),
    );
  }
}
