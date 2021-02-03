part of 'pages.dart';

class SignUp5 extends StatefulWidget {
  // final User user;
  // // final String password;
  // // final File pictureFile;
  // SignUp5({this.user /*, this.password, this.pictureFile */});
  final List<String> selectedCat;
  SignUp5({this.selectedCat});
  @override
  _SignUp5State createState() => _SignUp5State();
}

class _SignUp5State extends State<SignUp5> {
  File pictureFile;

  String phone_number;
  String first_name;
  String last_name;
  String username;
  String gender;
  String email;
  String password;
  getSignUpData() async {
    print('this is in SignUp 5 and has interest value ' + widget.selectedCat.toString());
    SharedPreferences signup = await SharedPreferences.getInstance();
    setState(() {
      phone_number = signup.getString('phone_number');
      first_name = signup.getString('first_name');
      last_name = signup.getString('last_name');
      username = signup.getString('username');
      gender = signup.getString('gender');
      email = signup.getString('email');
      password = signup.getString('password');
    });
  }

  void initState() {
    super.initState();
    getSignUpData();
  }

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
                  "Verify Your\nData",
                  style: blackTextFont.copyWith(fontSize: 38, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      PickedFile pickedFile = await ImagePicker().getImage(
                        source: ImageSource.gallery,
                        maxWidth: 800,
                        maxHeight: 600,
                      );
                      if (pickedFile != null) {
                        pictureFile = File(pickedFile.path);
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: 110,
                      height: 110,
                      margin: EdgeInsets.only(top: 26),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/photo_border.png'))),
                      child: (pictureFile != null)
                          ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(pictureFile), fit: BoxFit.cover),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage('assets/photo.png'), fit: BoxFit.cover),
                              ),
                            ),
                    ),
                  ),
                ),
                Divider(
                  height: 40,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Center(
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Full Name', style: blackTextFont.copyWith(fontSize: 16)),
                          Text('Gender', style: blackTextFont.copyWith(fontSize: 16)),
                          Text('Username', style: blackTextFont.copyWith(fontSize: 16)),
                          Text('Phone Number', style: blackTextFont.copyWith(fontSize: 16)),
                          Text('Email', style: blackTextFont.copyWith(fontSize: 16)),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ('$first_name $last_name') ?? 'null',
                            style: blackTextFont.copyWith(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(gender ?? 'null', style: blackTextFont.copyWith(fontSize: 16)),
                          Text(
                            username ?? 'null',
                            style: blackTextFont.copyWith(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(phone_number ?? 'null', style: blackTextFont.copyWith(fontSize: 16)),
                          Text(
                            email ?? 'null',
                            style: blackTextFont.copyWith(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 40,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: FlatButton(
                        disabledColor: Color(0xFFE4E4E4),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: accentColor2,
                        child: Text(
                          'Register & Verify',
                          style: blackTextFont.copyWith(
                            fontSize: 16,
                            color: accentColor3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          Get.defaultDialog(
                            barrierDismissible: true,
                            title: '',
                            content: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                          await context.read<UserCubit>().signUp(
                              User(
                                email: email,
                                phone_number: phone_number,
                                first_name: first_name,
                                last_name: last_name,
                                username: username,
                                gender: gender,
                              ),
                              password,
                              pictureFile: pictureFile);

                          UserState state = context.read<UserCubit>().state;
                          if (state is UserLoaded) {
                            await context.read<UserCubit>().sendVerificationEmail();

                            SharedPreferences autologin = await SharedPreferences.getInstance();
                            await autologin.setString('email', email);
                            await autologin.setString('password', password);

                            await context.read<UserCubit>().signIn(email, password);

                            if (widget.selectedCat != null) {
                              for (int i = 0; i < widget.selectedCat.length; i++) {
                                print('Widget ' + widget.selectedCat[i]);
                                await context
                                    .read<UserCubit>()
                                    .uploadUserInterest(widget.selectedCat[i]);
                              }
                            }
                            //TODO: SHOULD ADD More Cubit Here
                            await context.read<UserInterestCubit>().loadInterest();
                            await context.read<ProductCubit>().showProductDiscover(limit: '21');
                            await context
                                .read<BestSellerProductCubit>()
                                .showProductbyBestSeller(limit: '21');
                            await context
                                .read<MerchantRandomOrderCubit>()
                                .showMerchantByRandom(limit: '21');
                            await context.read<VoucherCubit>().showAllVoucher();
                            await context.read<FollowCubit>().followList();
                            await context.read<FeedCubit>().showAllFeed();
                            await context.read<OwnfeedCubit>().showOwnFeed();
                            await context.read<MerchantcategoryCubit>().showAllMerchantCategory();

                            Get.back();
                            Get.offAll(SignUp6());
                            Get.snackbar("Register Complete", "Check You Email");
                          } else {
                            Get.back();
                            Get.snackbar(
                              "",
                              "",
                              backgroundColor: HexColor("D9435E"),
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              titleText: Text("Sign Up Failed", style: blackTextFont),
                              messageText: Text(
                                (state as UserLoadingFailed).message ?? 'Kosong',
                                style: blackTextFont,
                              ),
                            );
                          }
                        }),
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
