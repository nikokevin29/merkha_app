part of 'pages.dart';

class FeedTab extends StatefulWidget {
  @override
  _FeedTabState createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> {
  ScrollController controller = ScrollController();
  //final _scrollThreshold = 200.0;
  FeedCubit cubit;
  FeedBloc _feedBloc;

  void onScroll() {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;
    if (currentScroll == maxScroll) {
      print('reachMaxScroll');
      _feedBloc.add(FeedFetched());
    }
  }

  @override
  void initState() {
    super.initState();
    // context.read<FeedCubit>().showAllFeed();
    // cubit = BlocProvider.of<FeedCubit>(context);
    _feedBloc = BlocProvider.of<FeedBloc>(context);
    controller.addListener(onScroll);
    //_feedBloc = BlocProvider.of<FeedBloc>(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
            child:
                Image.asset("assets/merkha-yellow.png"), //Image.asset("assets/merkha-yellow.png"),
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<FeedBloc, FeedStates>(
          builder: (context, state) {
            if (state is FeedInitials) {
              print('Feed Initial Started');
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FeedFailure) {
              return Center(
                child: Text('Failed Load Feed'),
              );
            }
            if (state is FeedSuccess) {
              if (state.feed.isEmpty) {
                return Center(
                  child: Text('No Feed'),
                );
              }
              return ListView.builder(
                controller: controller,
                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                itemCount: (state.hasReachedMax) ? state.feed.length : state.feed.length + 1,
                itemBuilder: (context, index) => (index >= state.feed.length)
                    ? Padding(
                        padding: const EdgeInsets.all(30),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : FeedCard(feed: state.feed[index]),
              );
            } else {
              return Center(
                child: Text('Something gone wrong'),
              );
            }
          },
        )
        // BlocBuilder<FeedCubit, FeedState>(builder: (_, state) {
        //   if (state is FeedInitial || state is FeedFailed) {
        //     return Padding(
        //       padding: const EdgeInsets.all(50.0),
        //       child: Center(child: CircularProgressIndicator()),
        //     );
        //   } else {
        //     FeedListLoaded feedListLoaded = state as FeedListLoaded;
        //     return ListView.builder(
        //         controller: controller,
        //         shrinkWrap: true,
        //         itemCount: (feedListLoaded.hasReachedMax)
        //             ? feedListLoaded.feed.length
        //             : feedListLoaded.feed.length + 1,
        //         itemBuilder: (context, index) => (index < feedListLoaded.feed.length)
        //             ? FeedCard(feed: feedListLoaded.feed[index])
        //             : Padding(
        //                 padding: const EdgeInsets.all(50.0),
        //                 child: Center(child: CircularProgressIndicator()),
        //               ));
        //   }
        // }),
        );
  }
}

//         //old style #1
//         // children: [
//         //   // Column(
//         //   //   children: feedListLoaded.feed
//         //   //       .map((e) => Padding(
//         //   //             padding: EdgeInsets.only(
//         //   //                 top: (e == feedListLoaded.feed.first) ? defaultMargin : 0,
//         //   //                 bottom: (e == feedListLoaded.feed.last) ? defaultMargin : 0),
//         //   //             child: FeedCard(feed: e),
//         //   //           ))
//         //   //       .toList(),
//         //   // ),
//         // ],
//         );
//   }
// }),

// BlocBuilder<FeedBloc, FeedStates>(
//   builder: (context, state) {
//     if (state is FeedInitials) {
//       print('Feed Initial');
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     if (state is FeedFailure) {
//       return Center(
//         child: Text('Failed Load Post'),
//       );
//     }
//     if (state is FeedSuccess) {
//       if (state.feed.isEmpty) {
//         return Center(
//           child: Text('No Feed'),
//         );
//       }
//       return ListView.builder(
//         controller: controller,
//         shrinkWrap: true,
//         //physics: NeverScrollableScrollPhysics(),
//         itemCount: (state.hasReachedMax) ? state.feed.length : state.feed.length + 1,
//         itemBuilder: (context, index) => (index < state.feed.length)
//             ? FeedCard(feed: state.feed[index])
//             : Padding(
//                 padding: const EdgeInsets.all(50.0),
//                 child: Center(child: CircularProgressIndicator()),
//               ),
//       );
//     } else {
//       return Center(
//         child: Text('Something gone wrong'),
//       );
//     }
//   },
// )
