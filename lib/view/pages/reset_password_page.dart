part of 'pages.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController emailResetController = TextEditingController();
  bool isEmailValid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Reset Password', style: blackTextFont.copyWith()),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 110,
              ),
              TextField(
                controller: emailResetController,
                decoration: InputDecoration(labelText: "Enter Your Email Here"),
                onChanged: (text) {
                  setState(() {
                    isEmailValid = EmailValidator.validate(text.trim());
                  });
                },
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: FlatButton(
                      disabledColor: Color(0xFFE4E4E4),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      color: (isEmailValid) ? accentColor2 : Colors.blueAccent,
                      child: Text(
                        "Reset",
                        style: blackTextFont.copyWith(
                            fontSize: 16, color: accentColor3, fontWeight: FontWeight.w600),
                      ),
                      onPressed: isEmailValid
                          ? () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  });

                              await context
                                  .read<UserCubit>()
                                  .resetPassword(emailResetController.text);
                              Navigator.pop(context);
                              Get.snackbar("Check Your Email",
                                  "Reset Password Form Has been Sent to Your Email\nif Your Email Valid");
                            }
                          : null),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
