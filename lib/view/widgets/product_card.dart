part of 'widgets.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function onTap;

  ProductCard(this.product, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailProduct(product: product));
      },
      child: Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        child: CachedNetworkImage(
          height: (MediaQuery.of(context).size.width - 2 * defaultMargin) / 3,
          width: (MediaQuery.of(context).size.width - 2 * defaultMargin) / 3,
          imageUrl: product.preview,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
