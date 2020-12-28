part of 'pages.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String password;
  String email;
  @override
  void initState() {
    super.initState();
    sharedPreferences();
    Future.delayed(Duration(seconds: 1), () async {
      print(email);
      print(password);
      if (email != null && password != null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            });
        await context.read<UserCubit>().signIn(email, password);
        Navigator.pop(context);
        Get.offAll(MainPage());
      } else {
        Get.offAll(SignInOptionPage());
      }
    });
  }

  void sharedPreferences() async {
    SharedPreferences autologin = await SharedPreferences.getInstance();
    email = autologin.getString('email');
    password = autologin.getString('password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 100,
                  alignment: Alignment.center,
                  child: Image.asset('assets/merkha-yellow.png'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
