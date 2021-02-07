part of 'pages.dart';

class FeedMerchant extends StatefulWidget {
  final Feed feed;
  final Merchant merchant;
  final String idMerchant;
  FeedMerchant({this.feed, this.merchant, this.idMerchant});
  @override
  _FeedMerchantState createState() => _FeedMerchantState();
}

class _FeedMerchantState extends State<FeedMerchant> {
  String tempValidation;
  @override
  void initState() {
    super.initState();
    // tempValidation = widget.feed.idMerchant.toString();
    // if (widget.feed.idMerchant == null) {
    //   tempValidation = widget.merchant.merchantId;
    // }
    context.read<FeedbymerchantidCubit>().showFeedByMerchantId(id: widget.idMerchant);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FeedbymerchantidCubit, FeedbymerchantidState>(builder: (_, state) {
        if (state is FeedByIdMerchantListLoaded) {
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
    );
  }
}
