part of 'pages.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  var bottomNavBarIndex;

  MainPage({this.bottomNavBarIndex = 0});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  int bottomNavBarIndex = 0;
  TabController controller;
  @override
  void initState() {
    controller = new TabController(length: 5, vsync: this, initialIndex: widget.bottomNavBarIndex);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Bottom Nav bar
      bottomNavigationBar: new Material(
        color: Colors.white30,
        child: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
          controller: controller,
          labelStyle: blackTextFont.copyWith(fontSize: 10),
          onTap: (index) {
            setState(() {
              widget.bottomNavBarIndex = index;
            });
          },
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
              ),
              text: "Home",
            ),
            Tab(
              icon: Container(
                child: Image.asset((widget.bottomNavBarIndex == 1)
                    ? "assets/logo-yellow.png"
                    : "assets/logo-grey.png"),
              ),
              text: "Feed",
            ),
            Tab(
              icon: Icon(Icons.shopping_cart),
              text: "Cart",
            ),
            Tab(
              icon: Icon(Icons.bookmark),
              text: "Wishlist",
            ),
            Tab(
              icon: ((context.watch<UserCubit>().state as UserLoaded).user.urlphoto != null)
                  ? Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                            image: NetworkImage(
                                (context.watch<UserCubit>().state as UserLoaded).user.urlphoto),
                            fit: BoxFit.cover),
                      ),
                    )
                  : Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                            image: AssetImage('assets/defaultProfile.png'), fit: BoxFit.cover),
                      ),
                    ),
              text: "Profile",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          new MainTab(),
          new FeedTab(),
          new CartTab(),
          new WishlishTab(),
          new ProfileTab()
        ],
      ),
    );
  }
}
