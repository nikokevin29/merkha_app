part of 'widgets.dart';

class MerchantSearchCard extends StatelessWidget {
  final Merchant merchant;
  final Function onTap;
  MerchantSearchCard({this.merchant, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('tap merchant');
      },
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30))),
          height: 120,
          width: (MediaQuery.of(context).size.width - 2 * defaultMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: CachedNetworkImage(
                  height: 40,
                  width: 40,
                  imageUrl: merchant.merchantLogo,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(merchant.merchantName,
                        style: blackTextFont.copyWith(fontWeight: FontWeight.w600, fontSize: 12)),
                    Text(merchant.province, style: greyTextFont.copyWith(fontSize: 10)),
                    Divider(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - (7 * defaultMargin),
                      child: Text(merchant.description,
                          style: blackTextFont.copyWith(fontSize: 12),
                          maxLines: 3,
                          overflow: TextOverflow.clip),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
