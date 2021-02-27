part of 'pages.dart';

class ReviewMerchantPage extends StatefulWidget {
  final String idMerchant;
  ReviewMerchantPage({this.idMerchant});
  @override
  _ReviewMerchantPageState createState() => _ReviewMerchantPageState();
}

class _ReviewMerchantPageState extends State<ReviewMerchantPage> {
  @override
  void initState() {
    super.initState();
    context.read<ReviewMerchantCubit>().showReviewMerchant(merchantId: widget.idMerchant);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BlocBuilder<ReviewMerchantCubit, ReviewMerchantState>(
                builder: (_, states) => (states is ReviewMerchantLoaded)
                    ? ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                            Column(
                              children: states.reviewMerchant
                                  .map((e) => Padding(
                                        padding: EdgeInsets.only(
                                            top: (e == states.reviewMerchant.first) ? 0 : 0,
                                            bottom: (e == states.reviewMerchant.last) ? 15 : 0),
                                        child: ReviewMerchantCard(review: e),
                                      ))
                                  .toList(),
                            ),
                          ])
                    : Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewMerchantCard extends StatelessWidget {
  final ReviewMerchant review;
  const ReviewMerchantCard({this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: (review.urlPhoto != null)
                                    ? NetworkImage(review.urlPhoto)
                                    : AssetImage("assets/defaultProfile.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((review.isHiddenName != '1') ? review.username : '*********',
                          style: blackTextFont.copyWith(fontSize: 12)),
                      Text(
                          DateFormat.yMMMMd()
                              .format(DateFormat("yyyy-MM-dd HH:mm:ss").parse(review.createdAt)),
                          style: blackTextFont.copyWith(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              SmoothStarRating(
                starCount: 5,
                rating: review.stars,
                isReadOnly: true,
                size: MediaQuery.of(context).size.width * 0.06,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.star_half,
                color: Colors.yellowAccent,
                borderColor: Colors.grey[400],
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerLeft,
            child: ReadMoreText(
              review.description ?? '',
              textAlign: TextAlign.justify,
              trimLines: 3,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              trimCollapsedText: ' more',
              trimExpandedText: ' show less',
              moreStyle: blackMonstadtTextFont.copyWith(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
