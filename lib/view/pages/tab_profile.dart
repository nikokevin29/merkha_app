part of 'pages.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            //action here
          },
          child: Icon(
            Icons.add,
            color: Colors.grey,
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                context.read<UserCubit>().signOut();
                UserState state = context.read<UserCubit>().state;
                if (state is UserLoaded) {
                  Get.off(SignInOptionPage());
                } else {
                  Get.snackbar(
                    "Failed",
                    (state as UserLoadingFailed).message,
                    backgroundColor: HexColor("D9435E"),
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  );
                }
              },
              child: Icon(
                Icons.logout,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                //action here
              },
              child: Icon(
                Icons.account_balance_wallet,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                //action here
              },
              child: Icon(
                Icons.chat,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                //action here
              },
              child: Icon(
                Icons.more_horiz,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
            child: Text(
              DateTime.now().toString().substring(0, 10),
              style: blackTextFont.copyWith(
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
