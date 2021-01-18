part of 'pages.dart';

typedef void Callback(int id, String name);

class SearchProductFeed extends StatelessWidget {
  final Product product;
  final Callback onSonChanged;
  SearchProductFeed({this.product, this.onSonChanged});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Search Product Posting', style: blackTextFont),
        leading: BackButton(
          color: Colors.grey,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 5),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.teal)),
                    suffixIcon: InkWell(
                        child: Icon(Icons.search),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode()); //Close Keyboard
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              });
                          await context
                              .read<SearchProductCubit>()
                              .searchFilterProduct(keyword: searchController.text);
                          Navigator.pop(context);
                        }),
                  ),
                  autocorrect: false,
                  controller: searchController,
                ),
                Divider(),
                BlocBuilder<SearchProductCubit, SearchProductState>(builder: (_, state) {
                  if (state is SearchProductLoaded) {
                    List<Product> product = state.product;
                    return Container(
                      width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                      child: (product.length != 0)
                          ? GridView.builder(
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
                                direction: Axis.horizontal,
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      onSonChanged(product[index].id, product[index].productName);
                                      Get.back();
                                    },
                                    child: Container(
                                      width:
                                          (MediaQuery.of(context).size.width - 4 * defaultMargin) /
                                              2,
                                      height: 215,
                                      child: Column(
                                        children: [
                                          Stack(
                                            fit: StackFit.passthrough,
                                            children: [
                                              Container(
                                                //Image Product
                                                height: 150,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  image: DecorationImage(
                                                      image: (product[index].preview != null)
                                                          ? NetworkImage(product[index].preview)
                                                          : AssetImage('assets/logo-yellow.png'),
                                                      fit: BoxFit.cover),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        spreadRadius: 3,
                                                        blurRadius: 15,
                                                        color: Colors.black12),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.all(6),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  //Proudct Name
                                                  product[index].productName,
                                                  style: blackTextFont.copyWith(
                                                      fontWeight: FontWeight.w600),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  //Price
                                                  NumberFormat.currency(
                                                          locale: 'id',
                                                          symbol: 'Rp ',
                                                          decimalDigits: 0)
                                                      .format(product[index].price),
                                                  style: redNumberFont,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  //Merchant
                                                  'by ' + product[index].merchant,
                                                  style: greyTextFont.copyWith(fontSize: 12),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     print('tap');
                                  //   },
                                  //   child: FeedProductSearchCard(
                                  //     product: product[index],
                                  //   ),
                                  // )
                                ],
                              )),
                            )
                          : Center(
                              child: Text(
                                'Not Found',
                                style: blackTextFont.copyWith(fontSize: 16, color: Colors.red),
                              ),
                            ),
                    );
                  } else {
                    return Container();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
