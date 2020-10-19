part of 'pages.dart';

class FeedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Container(
          height: 35,
          width: 50,
          child: Image.asset("assets/merkha-yellow.png"),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
