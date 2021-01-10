part of 'pages.dart';

class WishlishTab extends StatefulWidget {
  @override
  _WishlishTabState createState() => _WishlishTabState();
}

class _WishlishTabState extends State<WishlishTab> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistCubit>().showWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "My Wishlist",
            style: blackTextFont.copyWith(fontSize: 24),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () async {
                    await context.read<WishlistCubit>().showWishlist();
                  },
                  child: Icon(Icons.refresh, color: Colors.black)),
            ),
          ]),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              BlocBuilder<WishlistCubit, WishlistState>(builder: (_, state) {
                if (state is WishlistLoaded) {
                  List<Product> wishlist = state.wishlist;
                  return Container(
                    width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                    child: (wishlist.length != 0)
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.73,
                            ),
                            itemCount: wishlist.length,
                            itemBuilder: (_, index) => Container(
                                child: Wrap(
                              alignment: WrapAlignment.center,
                              direction: Axis.horizontal,
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                ItemCardWishlist(product: wishlist[index]),
                              ],
                            )),
                          )
                        : Center(
                            child: Column(
                              children: [
                                SizedBox(height: 50),
                                Text(
                                  'Wishlist Empty',
                                  style: blackTextFont.copyWith(fontSize: 16, color: Colors.red),
                                ),
                                SizedBox(height: 50),
                                FlatButton(
                                    color: accentColor2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(30.0)),
                                    onPressed: () {
                                      Get.off(MainPage(bottomNavBarIndex: 0));
                                    },
                                    child: Text('Go To Home'))
                              ],
                            ),
                          ),
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      )),
    );
  }
}
