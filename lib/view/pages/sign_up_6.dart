part of 'pages.dart';

class SignUp6 extends StatefulWidget {
  @override
  _SignUp6State createState() => _SignUp6State();
}

class _SignUp6State extends State<SignUp6> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                  "Check Your Email",
                  style: blackTextFont.copyWith(fontSize: 38, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/email_verify.png"), fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: ArgonTimerButton(
                    initialTimer: 60, // Optional
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.45,
                    minWidth: MediaQuery.of(context).size.width * 0.45,
                    color: accentColor2,
                    borderRadius: 30.0,
                    child: Text(
                      "Resend Email",
                      style:
                          TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    loader: (timeLeft) {
                      return Text(
                        "Resend in $timeLeft",
                        style: blackTextFont.copyWith(
                            fontSize: 18, color: accentColor3, fontWeight: FontWeight.w600),
                      );
                    },
                    onTap: (startTimer, btnState) async {
                      if (btnState == ButtonState.Idle) {
                        startTimer(60);
                        await context.read<UserCubit>().sendVerificationEmail();
                      }
                    },
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: FlatButton(
                      color: accentColor2,
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      child: Text(
                        "Go To Home",
                        style: blackTextFont.copyWith(
                            fontSize: 18, color: accentColor3, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () async {
                        Get.defaultDialog(
                          backgroundColor: Colors.transparent,
                          barrierDismissible: true,
                          content: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                        SharedPreferences autologin = await SharedPreferences.getInstance();
                        String email = autologin.getString('email');
                        String password = autologin.getString('password');
                        await context.read<UserCubit>().signIn(email, password);
                        Get.back();
                        Get.offAll(MainPage());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
