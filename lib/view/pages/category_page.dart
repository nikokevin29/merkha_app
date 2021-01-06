part of 'pages.dart';

class CategoryPage extends StatefulWidget {
  final UserInterest userInterest;
  CategoryPage({this.userInterest});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.userInterest.category, style: blackTextFont.copyWith()),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Center(child: Text('ID Category ' + widget.userInterest.idCategory)),
    );
  }
}
