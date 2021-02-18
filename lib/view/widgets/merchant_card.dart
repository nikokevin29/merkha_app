part of 'widgets.dart';

class MerchantCard extends StatefulWidget {
  final Merchant merchant;
  final Function onTap;
  const MerchantCard({@required this.merchant, this.onTap});

  @override
  _MerchantCardState createState() => _MerchantCardState();
}

class _MerchantCardState extends State<MerchantCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      color: HexColor('#E6E6E6'),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30))),
        height: 190,
        width: (MediaQuery.of(context).size.width - 2 * defaultMargin) / 1.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(DetailMerchant(merchant: widget.merchant));
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: (widget.merchant.merchantLogo != null)
                    ? CachedNetworkImage(
                        height: (MediaQuery.of(context).size.width - 2 * defaultMargin) / 6,
                        width: (MediaQuery.of(context).size.width - 2 * defaultMargin) / 6,
                        imageUrl: widget.merchant.merchantLogo,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(100),
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
                      )
                    : Container(
                        height: (MediaQuery.of(context).size.width - 2 * defaultMargin) / 6,
                        width: (MediaQuery.of(context).size.width - 2 * defaultMargin) / 6,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/defaultProfile.png')),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(100),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.merchant.merchantName,
                  style: blackTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
                Divider(
                  color: Colors.transparent,
                  height: 3,
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      widget.merchant.description,
                      style: blackTextFont.copyWith(fontSize: 11),
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            ),
            FutureBuilder(
                future: FollowingService.checkstatus(id: widget.merchant.merchantId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return FlatButton(
                      height: 25,
                      color: Colors.green[400],
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      child: SizedBox(
                        width: 80,
                        child: Center(
                            child: (snapshot.data == widget.merchant.merchantId)
                                ? Text(
                                    'Unfollow',
                                    style: whiteNumberFont.copyWith(fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    'Follow',
                                    style: whiteNumberFont.copyWith(fontWeight: FontWeight.bold),
                                  )),
                      ),
                      onPressed: () async {
                        if (snapshot.data == widget.merchant.merchantId) {
                          print('unfollow');
                          await context
                              .read<FollowCubit>()
                              .unfollow(id: widget.merchant.merchantId);
                          if (this.mounted) setState(() {});
                        } else {
                          print('follow');
                          await context.read<FollowCubit>().follow(id: widget.merchant.merchantId);
                          if (this.mounted) setState(() {});
                        }
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            // Container(
            //   alignment: Alignment.bottomCenter,
            //   child: (check == '123')
            //       ? SizedBox(height: 15, width: 15, child: CircularProgressIndicator())
            //       : FlatButton(
            //           height: 25,
            //           color: Colors.green[400],
            //           shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            //           child: SizedBox(
            //             width: 80,
            //             child: Center(
            //                 child: (check == widget.merchant.merchantId)
            //                     ? Text(
            //                         'Unfollow',
            //                         style: whiteNumberFont.copyWith(fontWeight: FontWeight.bold),
            //                       )
            //                     : Text(
            //                         'Follow',
            //                         style: whiteNumberFont.copyWith(fontWeight: FontWeight.bold),
            //                       )),
            //           ),
            //           onPressed: () async {
            //             if (check == widget.merchant.merchantId) {

            //             } else {
            //               await context.read<FollowCubit>().follow(id: widget.merchant.merchantId);
            //             }

            //             // print('done');
            //           },
            //         ),
            // )
          ],
        ),
      ),
    );
  }
}
