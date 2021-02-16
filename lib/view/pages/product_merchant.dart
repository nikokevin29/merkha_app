part of 'pages.dart';

class ProductMerchant extends StatefulWidget {
  final String idMerch;
  ProductMerchant({this.idMerch});
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
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
