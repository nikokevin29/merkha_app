part of 'pages.dart';

class SignInOptionPage extends StatefulWidget {
  @override
  _SignInOptionPageState createState() => _SignInOptionPageState();
}

class _SignInOptionPageState extends State<SignInOptionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  alignment: Alignment.centerLeft,
                  width: 106,
                  height: 72,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/merkha-yellow.png')),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "#HartaKarun\nIndonesia",
                    style: blackTextFont.copyWith(fontSize: 40),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 185,
                    height: 60,
                    child: FlatButton(
                      color: accentColor2,
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      child: Text(
                        "Sign Up",
                        style: blackTextFont.copyWith(
                            fontSize: 24, color: accentColor3, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Get.to(SignUp1());
                      },
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    width: 185,
                    height: 60,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      child: Text(
                        "Log In",
                        style: blackTextFont.copyWith(
                            fontSize: 24, color: accentColor3, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () async {
                        //print((email != null) ? 'User Preference ON' : 'User Preference OFF');
                        Get.to(SignInPage());
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                    text: "I have read, understood and accepted the ",
                    style: blackTextFont.copyWith(
                      fontSize: 10,
                      color: HexColor('#BFBFBF'),
                    ),
                    children: [
                      TextSpan(
                        text: 'Terms of Service ',
                        style: blackTextFont.copyWith(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: HexColor('#4AB2FF'),
                        ),
                      ),
                      TextSpan(
                        text: '\nand the ',
                        style: blackTextFont.copyWith(
                          fontSize: 10,
                          color: HexColor('#BFBFBF'),
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: blackTextFont.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: HexColor('#4AB2FF'),
                        ),
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
