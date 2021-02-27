part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Merkha Login', style: blackTextFont.copyWith()),
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
              //LOGO MERKHA
              Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                alignment: Alignment.centerLeft,
                width: 106,
                height: 72,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/merkha-yellow.png')),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                onChanged: (text) {
                  setState(() {
                    isEmailValid = EmailValidator.validate(text.trim());
                  });
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                onChanged: (text) {
                  setState(() {
                    isPasswordValid = text.length >= 6;
                  });
                },
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Forget Password ? ",
                      style: greyTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(ResetPasswordPage());
                      },
                      child: Text(
                        "Click here",
                        style: purpleTextFont.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: FlatButton(
                      disabledColor: Color(0xFFE4E4E4),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      color: (isEmailValid && isPasswordValid) ? accentColor2 : Colors.blueAccent,
                      child: Text(
                        "Login",
                        style: blackTextFont.copyWith(
                            fontSize: 16, color: accentColor3, fontWeight: FontWeight.w600),
                      ),
                      onPressed: isEmailValid && isPasswordValid
                          ? () async {
                              setState(() {
                                isSigningIn = true;
                              });
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  });
                              await context
                                  .read<UserCubit>()
                                  .signIn(emailController.text, passwordController.text);

                              UserState state = context.read<UserCubit>().state;
                              if (state is UserLoaded) {
                                //TODO: SHOULD ADD More Cubit Here
                                //await context.read<UserInterestCubit>().loadInterest();
                                context.read<VoucherCubit>().showAllVoucher();
                                await context.read<FeedrandomCubit>().showFeedRandom(limit: '21');
                                await context
                                    .read<FeedbestsellerCubit>()
                                    .showFeedByBestSeller(limit: '21');
                                await context
                                    .read<MerchantRandomOrderCubit>()
                                    .showMerchantByRandom(limit: '8');
                                await context.read<FollowCubit>().followList();
                                // await context.read<FeedCubit>().showAllFeed();
                                context.read<OwnfeedCubit>().showOwnFeed();
                                context.read<MerchantcategoryCubit>().showAllMerchantCategory();

                                OrderServices
                                    .triggerOrderExpired(); //Trigger Order if create_at more than 1 day
                                SharedPreferences autologin = await SharedPreferences.getInstance();
                                await autologin.setString('email', emailController.text);
                                await autologin.setString('password', passwordController.text);
                                Navigator.pop(context);
                                Get.offAll(MainPage());
                              } else {
                                Get.snackbar(
                                  "Failed",
                                  "Sign In Failed",
                                  backgroundColor: HexColor("D9435E"),
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  titleText: Text("Sign In Failed", style: blackTextFont),
                                  // messageText: Text(
                                  //   (state as UserLoadingFailed).message,
                                  //   style: blackTextFont,
                                  // ),
                                );
                              }
                            }
                          : null),
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
