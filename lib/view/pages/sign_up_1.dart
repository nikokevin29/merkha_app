part of 'pages.dart';

class SignUp1 extends StatefulWidget {
  @override
  _SignUp1State createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
  bool isEmailValid = false;
  bool isSignup1 = false;
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
                  "Welcome!",
                  style: blackTextFont.copyWith(fontSize: 40),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Enter your mobile number & email\naddress to register. We’ll send a 4-digit\ncode to this number and a verification\nlink to the email address.",
                  style: blackTextFont.copyWith(color: accentColor3, fontWeight: FontWeight.w100),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: phonenumberController,
                      decoration: InputDecoration(labelText: "Phone Number", prefixText: "+62"),
                    ),
                    TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                        onChanged: (text) {
                          setState(() {
                            isEmailValid = EmailValidator.validate(text);
                          });
                        }),
                  ],
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
                        shape:
                            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        color: accentColor2,
                        child: Text(
                          "Continue",
                          style: blackTextFont.copyWith(
                              fontSize: 16, color: accentColor3, fontWeight: FontWeight.bold),
                        ),
                        onPressed: isEmailValid
                            ? () async {
                                setState(() {
                                  isSignup1 = true;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUp2()),
                                );
                              }
                            : null),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
