part of 'widgets.dart';

class ReviewProductCard extends StatelessWidget {
  final ReviewProduct review;
  const ReviewProductCard({this.review});

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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - (4 * defaultMargin),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    review.description ?? '',
                    style: blackTextFont.copyWith(),
                    textAlign: TextAlign.justify,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   alignment: Alignment.centerLeft,
          //   child: ReadMoreText(
          //     review.description ?? '',
          //     textAlign: TextAlign.justify,
          //     trimLines: 3,
          //     colorClickableText: Colors.pink,
          //     trimMode: TrimMode.Line,
          //     trimCollapsedText: ' more',
          //     trimExpandedText: ' show less',
          //     moreStyle: blackMonstadtTextFont.copyWith(
          //       fontSize: 12,
          //     ),
          //   ),
          // ),
        ],
      ),
    ));
  }
}
