part of 'pages.dart';

class CategoryPage extends StatefulWidget {
  final MerchantCategory merchantCategory;
  CategoryPage({this.merchantCategory});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var appContentCategory;
  @override
  void initState() {
    super.initState();
    // appContentAPI(widget.merchantCategory.id.toString());
  }

  // Future<dynamic> appContentAPI(String idMerchant) async {
  //   String url = baseURL + 'app_content/merchant_category/' + idMerchant;
  //   var response = await http.get(url, headers: {
  //     "Content-Type": "application/json",
  //     'Authorization': 'Bearer ' + User.token,
  //   });
  //   if (response.statusCode != 200) {
  //     print('StatusCode : ${response.statusCode}');
  //     return response.statusCode.toString();
  //   }
  //   var data = await jsonDecode(response.body);
  //   if (this.mounted) {
  //     setState(() {
  //       appContent = List<String>.from(data);
  //     });
  //   }
  //   return data;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.merchantCategory.categoryName, style: blackTextFont.copyWith()),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //note: Carousel Merchant by Merchant Category
            SizedBox(
              height: 200,
              child: FutureBuilder(
                  future: AppContentServices.showMerchantCategoryAppContentFormat(
                      idMerchant: widget.merchantCategory.id.toString()),
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
                                            merchantId: content.idMerchant.toString());
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
            SizedBox(height: 15),
            //note: Bloc Builder Product
            BlocBuilder<ProductbymerchatcatCubit, ProductbymerchatcatState>(builder: (_, state) {
              if (state is ProductByMerchantCatIdListLoaded) {
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
                                  //Navigate to Details Product Here
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
    );
  }
}
