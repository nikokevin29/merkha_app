part of 'pages.dart';

class SearchProductFeed extends StatefulWidget {
  final Product product;
  SearchProductFeed({this.product});
  @override
  _SearchProductFeedState createState() => _SearchProductFeedState();
}

class _SearchProductFeedState extends State<SearchProductFeed> {
  TextEditingController searchController = TextEditingController();
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
                                  FeedProductSearchCard(
                                      product: product[index],
                                      onTap: () {
                                        print('tap');
                                      })
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
