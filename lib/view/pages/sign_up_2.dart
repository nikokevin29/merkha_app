part of 'pages.dart';

class SignUp2 extends StatefulWidget {
  @override
  _SignUp2State createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  bool _passwordVisible = false;
  bool isSignup2 = false;
  bool isfirst = false;
  bool islast = false;
  bool isuser = false;
  bool ispass = false;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  // void initState() {
  //   _passwordVisible = false;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
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
                  "Create your\npersonal info",
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextField(
                      keyboardType: TextInputType.name,
                      controller: firstnameController,
                      decoration: InputDecoration(labelText: "First Name"),
                      onChanged: (value) {
                        setState(() {
                          value != '' ? isfirst = true : isfirst = false;
                        });
                      },
                    ),
                    TextField(
                      keyboardType: TextInputType.name,
                      controller: lastnameController,
                      decoration: InputDecoration(labelText: "Last Name"),
                      onChanged: (value) {
                        setState(() {
                          value != '' ? islast = true : islast = false;
                        });
                      },
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      controller: usernameController,
                      decoration: InputDecoration(labelText: "Username", prefixText: "@"),
                      onChanged: (value) {
                        setState(() {
                          value != '' ? isuser = true : isuser = false;
                        });
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          (value != '' && value.length >= 6) ? ispass = true : ispass = false;
                        });
                      },
                    ),
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
                        onPressed: (isfirst == true &&
                                islast == true &&
                                isuser == true &&
                                ispass == true)
                            ? () async {
                                setState(() {
                                  isSignup2 = true;
                                });

                                SharedPreferences signup = await SharedPreferences.getInstance();
                                signup.setString('first_name', firstnameController.text);
                                signup.setString('last_name', lastnameController.text);
                                signup.setString('username', usernameController.text);
                                signup.setString('password', passwordController.text);
                                Get.to(SignUp3());
                              }
                            : null),
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
