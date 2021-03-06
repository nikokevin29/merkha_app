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
      if (email != null && password != null) {
        await context.read<UserCubit>().signIn(email, password);
        UserState state = context.read<UserCubit>().state;
        if (state is UserLoaded) {
          //TODO: SHOULD ADD More Cubit Here
          //await context.read<UserInterestCubit>().loadInterest();
          await context.read<FeedrandomCubit>().showFeedRandom(limit: '21');
          await context.read<MerchantRandomOrderCubit>().showMerchantByRandom(limit: '21');
          await context.read<FeedbestsellerCubit>().showFeedByBestSeller(limit: '12');
          context.read<VoucherCubit>().showAllVoucher();
          //context.read<FollowCubit>().followList();
          //await context.read<FeedCubit>().showAllFeed();
          context.read<OwnfeedCubit>().showOwnFeed();
          await context.read<MerchantcategoryCubit>().showAllMerchantCategory();
          OrderServices.triggerOrderExpired(); //Trigger Order if create_at more than 1 day
          Get.offAll(MainPage());
        }
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
