part of 'pages.dart';

class DetailsOwnFeed extends StatelessWidget {
  final Feed feed;
  DetailsOwnFeed({this.feed});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Details Feed', style: blackTextFont.copyWith()),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FeedCard(feed: feed),
          ],
        ),
      ),
    );
  }
}
