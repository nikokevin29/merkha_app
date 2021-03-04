part of 'pages.dart';

class UpdateUsernamePage extends StatefulWidget {
  final String username;
  UpdateUsernamePage(this.username);
  @override
  _UpdateUsernamePageState createState() => _UpdateUsernamePageState();
}

class _UpdateUsernamePageState extends State<UpdateUsernamePage> {
  TextEditingController usernameController = TextEditingController();
  String _username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Update Username', style: blackTextFont.copyWith()),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            SizedBox(height: 25),
            TextFormField(
              keyboardType: TextInputType.name,
              decoration:
                  InputDecoration(prefixIcon: Icon(MdiIcons.account), labelText: widget.username),
              onChanged: (text) {
                setState(() {
                  _username = text;
                });
              },
            ),
            FlatButton(
              disabledColor: Color(0xFFE4E4E4),
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              color: accentColor2,
              child: Text(
                "Submit",
                style: blackTextFont.copyWith(
                    fontSize: 16, color: accentColor3, fontWeight: FontWeight.bold),
              ),
              onPressed: _username != null
                  ? () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      //PUT UpdateUserLoaded  UserUpdateLoadingFailed
                      await context.read<UpdateUserCubit>().updateUsername(_username);
                      Get.back();
                      UpdateUserState state = context.read<UpdateUserCubit>().state;
                      if (state is UserUpdateLoadingFailed) {
                        Get.snackbar("Update Failed", "Username has already been taken");
                      } else {
                        await context.read<UserCubit>().updateUsername(
                            (context.read<UserCubit>().state as UserLoaded).user.id.toString());
                        Get.back();
                        Get.back();
                        Get.back();
                        Get.snackbar(
                            "Username Updated", "Your Username will be update after app closed");
                      }
                    }
                  : null,
            ),
          ],
        ),
      )),
    );
  }
}
