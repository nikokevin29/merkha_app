part of 'pages.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  List<Widget> _randomChildren;
  int countPost;

  @override
  void initState() {
    super.initState();
    // _initFeed();
  }

  List<Widget> _randomHeightWidgets(BuildContext context) {
    _randomChildren = List.generate(1, (index) => buildHeader(context));
    return _randomChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBarProfile(),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  _randomHeightWidgets(context),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              TabBar(
                indicatorColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    icon: Container(
                      width: 18,
                      height: 20,
                      child: Image.asset('assets/post-icon.png'),
                    ),
                    iconMargin: const EdgeInsets.only(bottom: 5.0),
                    text: 'Post',
                  ),
                  Tab(
                      icon: Container(
                        width: 20,
                        height: 20,
                        child: Image.asset('assets/order-icon.png'),
                      ),
                      iconMargin: const EdgeInsets.only(bottom: 5.0),
                      text: 'Order'),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  Post(),
                  OrderPage(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//TODO: App Bar
class AppBarProfile extends StatelessWidget {
  const AppBarProfile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          //Add Posting Button Create Feed
          Get.to(CreatePost());
        },
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      ),
      elevation: 0,
      actions: [
        PopupMenuButton(
          icon: Icon(Icons.more_vert, color: Colors.grey),
          itemBuilder: (context) => [
            PopupMenuItem(
                value: 'updateProfile',
                child: InkWell(
                  onTap: () {
                    Get.to(ProfileUpdate());
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      Text(' Update Profile'),
                    ],
                  ),
                )),
            PopupMenuItem(
              value: 'address',
              child: InkWell(
                onTap: () {
                  Get.to(AddressSettings());
                },
                child: Row(
                  children: [
                    Icon(Icons.home, color: Colors.grey),
                    Text(' Address Settings'),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              value: 'logout',
              child: Logout(),
            ),
          ],
        ),
      ],
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //Sign Out Button
      onTap: () {
        Widget cancelButton = FlatButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        );
        Widget okButton = FlatButton(
          child: Text("OK"),
          onPressed: () async {
            context.read<UserCubit>().signOut();
            UserState state = context.read<UserCubit>().state;
            if (state is UserLoaded) {
              SharedPreferences autologin = await SharedPreferences.getInstance();
              await autologin.clear();
              Get.offAll(SignInOptionPage());
            } else {
              Get.snackbar(
                "Failed",
                (state as UserLoadingFailed).message,
                backgroundColor: HexColor("D9435E"),
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              );
            }
          },
        );
        AlertDialog logoutalert = AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure want to logout ?"),
          actions: [
            cancelButton,
            okButton,
          ],
        );
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return logoutalert;
            });
      },
      child: Row(
        children: [
          Icon(
            Icons.logout,
            color: Colors.grey,
          ),
          Text(' Sign Out'),
        ],
      ),
    );
  }
}

Column buildHeader(BuildContext context) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
              child: Text(
                new DateFormat.MMMMEEEEd().format(new DateTime.now()),
                style: blackTextFont.copyWith(
                  color: accentColor3,
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        //Wallet Button
                        Get.to(WalletPage());
                      },
                      child: SizedBox(
                          height: 22, width: 30, child: Image.asset('assets/wallet-icon.png'))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        //Chat Button
                        Get.to(ChatPage());
                      },
                      child: SizedBox(
                          height: 22, width: 30, child: Image.asset('assets/chat-icon.png'))),
                ),
              ],
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Profile Photo
                Column(
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
                                  image: ((context.watch<UserCubit>().state as UserLoaded)
                                              .user
                                              .urlphoto !=
                                          null)
                                      ? NetworkImage(
                                          (context.watch<UserCubit>().state as UserLoaded)
                                              .user
                                              .urlphoto)
                                      : AssetImage("assets/defaultProfile.png"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (context.watch<UserCubit>().state as UserLoaded).user.first_name ??
                              CircularProgressIndicator(), //First Name
                          style: blackTextFont.copyWith(fontSize: 32),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          (context.watch<UserCubit>().state as UserLoaded).user.last_name ??
                              CircularProgressIndicator(), //Last Name
                          style: blackTextFont.copyWith(fontSize: 32),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Divider(height: 15),
                        //bio
                        Text(
                          (context.watch<UserCubit>().state as UserLoaded).user.bio ?? '',
                          style: blackTextFont,
                        ),
                        Divider(height: 15, color: Colors.white),
                        // Counter Post Followers Following
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text((context.watch<OwnfeedCubit>().state as OwnFeedListLoaded)
                                      .feed
                                      .length
                                      .toString()),
                                  Text(' Posts'),
                                ],
                              ),
                              //await context.read<FollowCubit>().followList();
                              Row(
                                children: [
                                  Text(NumberFormat.compactCurrency(decimalDigits: 0, symbol: '')
                                      .format(
                                          (context.watch<FollowCubit>().state as FollowListLoaded)
                                              .follow
                                              .length)),
                                  Text(' Follwers'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(NumberFormat.compactCurrency(decimalDigits: 0, symbol: '')
                                      .format(
                                          (context.watch<FollowCubit>().state as FollowListLoaded)
                                              .follow
                                              .length)),
                                  Text(' Following'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 15, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
