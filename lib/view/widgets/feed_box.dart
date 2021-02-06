part of 'widgets.dart';

class FeedBox extends StatelessWidget {
  final Feed feed;

  FeedBox(this.feed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailsOwnFeed(feed: feed));
      },
      child: Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        child: CachedNetworkImage(
          height: (MediaQuery.of(context).size.width - 2 * defaultMargin) / 3,
          width: (MediaQuery.of(context).size.width - 2 * defaultMargin) / 3,
          imageUrl: feed.urlImage,
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
