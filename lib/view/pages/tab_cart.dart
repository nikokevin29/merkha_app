part of 'pages.dart';

class CartTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "My Cart",
          style: blackTextFont.copyWith(fontSize: 24),
        ),
      ),
    );
  }
}
