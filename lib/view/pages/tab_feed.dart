part of 'pages.dart';

class FeedTab extends StatefulWidget {
  @override
  _FeedTabState createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> {
  @override
  void initState() {
    super.initState();
    context.read<FeedCubit>().showAllFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Container(
            height: 35,
            width: 50,
            child: Image.asset("assets/merkha-yellow.png"),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<FeedCubit, FeedState>(
                builder: (_, state) => (state is FeedListLoaded)
                    ? ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Column(
                            children: state.feed
                                .map((e) => Padding(
                                      padding: EdgeInsets.only(
                                          top: (e == state.feed.first) ? defaultMargin : 0,
                                          bottom: (e == state.feed.last) ? defaultMargin : 0),
                                      child: FeedCard(feed: e),
                                    ))
                                .toList(),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
              ),
            ],
          ),
        ));
  }
}
