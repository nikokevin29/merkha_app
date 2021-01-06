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
                child: Image.asset(
                    (widget.bottomNavBarIndex == 1) ? "assets/logo-yellow.png" : "assets/logo-grey.png"),
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
              icon: Icon(Icons.person),
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
