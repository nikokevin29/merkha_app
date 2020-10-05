part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 5, vsync: this);
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
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.search,
              ),
            ),
            Tab(
              icon: Icon(Icons.flash_on),
            ),
            Tab(
              icon: Icon(Icons.shopping_cart),
            ),
            Tab(
              icon: Icon(Icons.favorite),
            ),
            Tab(
              icon: Icon(Icons.person),
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
