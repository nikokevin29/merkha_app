part of 'pages.dart';

class DetailUser extends StatefulWidget {
  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Username user', style: blackTextFont.copyWith()),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Center(child: Text('user page')),
      )),
    );
  }
}
