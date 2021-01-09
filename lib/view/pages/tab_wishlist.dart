part of 'pages.dart';

class WishlishTab extends StatelessWidget {
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
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  spacing: 20,
                  runSpacing: 15,
                  children: [
                    // ItemCard(),
                    // ItemCard(),
                    // ItemCard(),
                    // ItemCard(),
                    // ItemCard(),
                    // ItemCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
