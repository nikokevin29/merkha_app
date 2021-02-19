part of 'pages.dart';

class DetailUser extends StatefulWidget {
  final String idUser;
  DetailUser({this.idUser});
  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  User user;
  @override
  void initState() {
    super.initState();
    UserServices.showUserById(id: widget.idUser).then((value) {
      user = value.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(user.username, style: blackTextFont.copyWith()),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2)),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: (user.urlphoto != null)
                                        ? NetworkImage(user.urlphoto)
                                        : AssetImage("assets/defaultProfile.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 9),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //first_name
                            Text(
                              user.first_name ?? CircularProgressIndicator(), //First Name
                              style: blackTextFont.copyWith(fontSize: 32),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            //last_name
                            Text(
                              user.last_name ?? CircularProgressIndicator(), //Last Name
                              style: blackTextFont.copyWith(fontSize: 32),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Divider(height: 15),
                            //note: bio
                            Text(
                              user.bio ?? '',
                              style: blackTextFont,
                            ),
                            Divider(),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                              Text('9' + ' Posts', style: blackTextFont.copyWith()),
                              FutureBuilder(
                                  future: FollowingService.countFollowersUserOther(
                                      id: user.id.toString()),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasData) {
                                      int data = snapshot.data;
                                      return Text(
                                        NumberFormat.compactCurrency(decimalDigits: 0, symbol: '')
                                                .format(data) +
                                            ' Follow',
                                        style: blackTextFont.copyWith(
                                            fontSize: 14, color: Colors.black),
                                      );
                                    } else {
                                      Text('0',
                                          style: whiteNumberFont.copyWith(
                                              fontSize: 10, color: Colors.black));
                                    }
                                    return SizedBox(
                                        width: 10, height: 10, child: CircularProgressIndicator());
                                  }),
                              Text('9' + ' Following', style: blackTextFont.copyWith()),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
