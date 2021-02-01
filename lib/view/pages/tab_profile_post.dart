part of 'pages.dart';

class Post extends StatefulWidget {
  const Post({
    Key key,
  }) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnfeedCubit, OwnfeedState>(builder: (_, state) {
      if (state is OwnFeedListLoaded) {
        List<Feed> feed = state.feed;
        return Container(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: GridView.builder(
              shrinkWrap: true,
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
                        FeedOwnCard(feed[index]),
                      ],
                    ),
                  )),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}
