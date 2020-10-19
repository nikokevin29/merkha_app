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
    );
  }
}
