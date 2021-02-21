part of 'pages.dart';

class DetailUser extends StatefulWidget {
  final String idUser;
  final User user;
  DetailUser({this.idUser, this.user});
  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  User user;
  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(user.username ?? '', style: blackTextFont.copyWith()),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          FutureBuilder(
              future: FollowingService.checkstatusUser(id: user.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FlatButton(
                    onPressed: () async {
                      if (snapshot.data == user.id.toString()) {
                        print('unfollow');
                        await FollowingService.unfollowUser(id: user.id.toString());
                        if (mounted) setState(() {});
                      } else {
                        print('follow');
                        await FollowingService.followUser(id: user.id.toString());
                        if (mounted) setState(() {});
                      }
                    },
                    child: Text(
                      (snapshot.data == user.id.toString()) ? 'Unfollow' : 'Follow +',
                      style: blackTextFont.copyWith(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
                  );
                }
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2)),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: (user.urlphoto != null)
                                        ? NetworkImage(user.urlphoto)
                                        : AssetImage("assets/defaultProfile.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 9),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //first_name
                            Text(
                              user.first_name ?? CircularProgressIndicator(), //First Name
                              style: blackTextFont.copyWith(fontSize: 32),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            //last_name
                            Text(
                              user.last_name ?? CircularProgressIndicator(), //Last Name
                              style: blackTextFont.copyWith(fontSize: 32),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Divider(height: 15),
                            //note: bio
                            Text(
                              user.bio ?? '',
                              style: blackTextFont,
                            ),
                            Divider(),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                              Text(
                                  (context.watch<FeedbyuseridCubit>().state
                                              as FeedByUserIdListLoaded)
                                          .feed
                                          .length
                                          .toString() +
                                      ' Posts',
                                  style: blackTextFont.copyWith()),
                              FutureBuilder(
                                  future: FollowingService.countFollowingUserOther(
                                      id: user.id.toString()),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasData) {
                                      int data = snapshot.data;
                                      return Text(
                                        NumberFormat.compactCurrency(decimalDigits: 0, symbol: '')
                                                .format(data) +
                                            ' Following',
                                        style: blackTextFont.copyWith(
                                            fontSize: 14, color: Colors.black),
                                      );
                                    } else {
                                      Text('0',
                                          style: whiteNumberFont.copyWith(
                                              fontSize: 10, color: Colors.black));
                                    }
                                    return SizedBox(
                                        width: 10, height: 10, child: CircularProgressIndicator());
                                  }),
                              FutureBuilder(
                                  future:
                                      FollowingService.countFollowersUser(id: user.id.toString()),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasData) {
                                      int data = snapshot.data;
                                      return Text(
                                        NumberFormat.compactCurrency(decimalDigits: 0, symbol: '')
                                                .format(data) +
                                            ' Followers',
                                        style: blackTextFont.copyWith(
                                            fontSize: 14, color: Colors.black),
                                      );
                                    } else {
                                      Text('0',
                                          style: whiteNumberFont.copyWith(
                                              fontSize: 10, color: Colors.black));
                                    }
                                    return SizedBox(
                                        width: 10, height: 10, child: CircularProgressIndicator());
                                  }),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: BlocBuilder<FeedbyuseridCubit, FeedbyuseridState>(builder: (_, state) {
                      if (state is FeedByUserIdListLoaded) {
                        List<Feed> feed = state.feed;
                        return Container(
                          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
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
                                  FeedOwnCard(feed[index]),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
