part of 'pages.dart';

class SignUp3 extends StatefulWidget {
  @override
  _SignUp3State createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Choose your\nGender",
                style: blackTextFont.copyWith(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "If you choose to provide this information\nto us, we may use it to personalize\na relevant reference for you.",
                style: blackTextFont.copyWith(color: accentColor3, fontWeight: FontWeight.w100),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    print("Female Tapped");
                  },
                  child: Container(
                    width: 244,
                    height: 61,
                    alignment: Alignment.center,
                    child: Text(
                      "Female",
                      style: blackTextFont.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    print("Male Tapped");
                  },
                  child: Container(
                    width: 244,
                    height: 61,
                    alignment: Alignment.center,
                    child: Text(
                      "Male",
                      style: blackTextFont.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    print("Not Prefer Say Tapped");
                  },
                  child: Container(
                    width: 244,
                    height: 61,
                    alignment: Alignment.center,
                    child: Text(
                      "Prefer not to say",
                      style: blackTextFont.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
