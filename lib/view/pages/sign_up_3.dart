part of 'pages.dart';

class SignUp3 extends StatefulWidget {
  final List<String> genderlist = ["Female", "Male", "Prefer not to say"];
  @override
  _SignUp3State createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  bool isSignup3 = false;
  List<String> selectedGender = [];
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
              Wrap(
                spacing: 50,
                runSpacing: 20,
                children: genderWidgets(context),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: FlatButton(
                      disabledColor: Color(0xFFE4E4E4),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      color: accentColor2,
                      child: Text(
                        (selectedGender.length == 0) ? "Next" : selectedGender.join(','),
                        style: blackTextFont.copyWith(
                            fontSize: 16, color: accentColor3, fontWeight: FontWeight.bold),
                      ),
                      onPressed: (selectedGender.length != 0)
                          ? () async {
                              setState(() {
                                isSignup3 = true;
                              });
                              // Navigator.push(
                              //   context,
                              //   //MaterialPageRoute(builder: (context) => SignUp3()),
                              // );
                            }
                          : null),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  List<Widget> genderWidgets(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;
    return widget.genderlist
        .map(
          (e) => SelectableBox(
            e,
            width: width,
            isSelected: selectedGender.contains(e),
            onTap: () {
              onSelectGender(e);
            },
          ),
        )
        .toList();
  }

  void onSelectGender(String gender) {
    if (selectedGender.contains(gender)) {
      setState(() {
        selectedGender.remove(gender);
      });
    } else {
      if (selectedGender.length < 1) {
        setState(() {
          selectedGender.add(gender);
        });
      }
    }
  }
}
