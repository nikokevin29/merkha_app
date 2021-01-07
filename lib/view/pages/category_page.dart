part of 'pages.dart';

class CategoryPage extends StatefulWidget {
  final UserInterest userInterest;
  CategoryPage({this.userInterest});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.userInterest.category, style: blackTextFont.copyWith()),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<ProductByCategoryCubit, ProductByCategoryState>(builder: (_, state) {
            if (state is ProductByCategoryListLoaded) {
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
    );
  }
}