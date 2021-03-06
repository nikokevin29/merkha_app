part of 'pages.dart';

class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  List<String> gender = ['Male', 'Female', 'Not Preter Yet'];
  //String _selectedGender;
  bool isEmailValid = false;
  File pictureFile;
  String email, username, firstName, lastName, phone, selectedGen, bio; //Setter
  String _email, _username, _firstName, _lastName, _phone, _selectedGender, _bio; //Getter

  @override
  Widget build(BuildContext context) {
    email = (context.watch<UserCubit>().state as UserLoaded).user.email ?? '';
    username = (context.watch<UserCubit>().state as UserLoaded).user.username ?? '';
    firstName = (context.watch<UserCubit>().state as UserLoaded).user.first_name ?? '';
    lastName = (context.watch<UserCubit>().state as UserLoaded).user.last_name ?? '';
    phone = (context.watch<UserCubit>().state as UserLoaded).user.phone_number ?? '';
    selectedGen = (context.watch<UserCubit>().state as UserLoaded).user.gender ?? '';
    bio = (context.watch<UserCubit>().state as UserLoaded).user.bio ?? '';
    selectedGen = (context.watch<UserCubit>().state as UserLoaded).user.gender;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Update Profile', style: blackTextFont.copyWith()),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context); //Close PopMenu Button in Profile Tab
            Get.back();
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.back();
          Get.back();
          return false;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                children: [
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
                                    image: ((context.watch<UserCubit>().state as UserLoaded)
                                                .user
                                                .urlphoto !=
                                            null)
                                        ? NetworkImage(
                                            (context.watch<UserCubit>().state as UserLoaded)
                                                .user
                                                .urlphoto)
                                        : AssetImage("assets/defaultProfile.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                              ((context.watch<UserCubit>().state as UserLoaded)
                                          .user
                                          .email_verified_at !=
                                      null)
                                  ? Icons.verified
                                  : Icons.cancel,
                              color: ((context.watch<UserCubit>().state as UserLoaded)
                                          .user
                                          .email_verified_at !=
                                      null)
                                  ? Colors.green
                                  : Colors.red),
                          Text(
                            ((context.watch<UserCubit>().state as UserLoaded)
                                        .user
                                        .email_verified_at !=
                                    null)
                                ? 'Email Verified'
                                : 'Not Verified',
                            style: blackTextFont.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      Container(
                        child: ((context.watch<UserCubit>().state as UserLoaded)
                                    .user
                                    .email_verified_at ==
                                null)
                            ? ArgonTimerButton(
                                initialTimer: 0,
                                height: 25,
                                width: MediaQuery.of(context).size.width * 0.2,
                                minWidth: MediaQuery.of(context).size.width * 0.2,
                                borderRadius: 15.0,
                                color: accentColor2,
                                child: Text(
                                  ((context.watch<UserCubit>().state as UserLoaded)
                                              .user
                                              .email_verified_at ==
                                          null)
                                      ? 'Verify Now'
                                      : '',
                                  style: blackTextFont.copyWith(
                                    fontSize: 14,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                loader: (timeLeft) {
                                  return Text(
                                    "$timeLeft",
                                    style: blackTextFont.copyWith(
                                      fontSize: 14,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                },
                                onTap: (startTimer, btnState) async {
                                  if (btnState == ButtonState.Idle) {
                                    startTimer(60);
                                    await context.read<UserCubit>().sendVerificationEmail();
                                  }
                                },
                              )
                            : Container(),
                      ),
                    ],
                  ),
                  TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.emailAddress,
                    initialValue: email,
                    decoration: InputDecoration(
                        prefixIcon: Icon(MdiIcons.email), labelText: "Email cannot be changed"),
                    onChanged: (text) {
                      setState(() {
                        _email = text;
                        //isEmailValid = EmailValidator.validate(text.trim());
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(UpdateUsernamePage(username));
                    },
                    child: TextFormField(
                      enabled: false,
                      keyboardType: TextInputType.name,
                      initialValue: (context.watch<UserCubit>().state as UserLoaded).user.username,
                      decoration: InputDecoration(
                          prefixIcon: Icon(MdiIcons.account), labelText: "Username"),
                      // onChanged: (text) {
                      //   setState(() {
                      //     _username = text;
                      //   });
                      // },
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    initialValue: firstName,
                    decoration: InputDecoration(
                        prefixIcon: Icon(MdiIcons.account), labelText: "First Name"),
                    onChanged: (text) {
                      setState(() {
                        _firstName = text;
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    initialValue: lastName,
                    decoration:
                        InputDecoration(prefixIcon: Icon(MdiIcons.account), labelText: "Last Name"),
                    onChanged: (text) {
                      setState(() {
                        _lastName = text;
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    initialValue: phone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(MdiIcons.phone), labelText: "Phone Number"),
                    onChanged: (text) {
                      setState(() {
                        _phone = text;
                      });
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    alignment: Alignment.centerLeft,
                    child: DropdownButton(
                      icon: Icon(MdiIcons.genderMaleFemaleVariant),
                      hint: Text(selectedGen, style: blackTextFont),
                      value: _selectedGender,
                      isExpanded: true,
                      onChanged: (text) {
                        setState(() {
                          _selectedGender = text;
                          print(_selectedGender);
                        });
                      },
                      items: gender.map((gen) {
                        return DropdownMenuItem(child: Text(gen), value: gen);
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 9),
                  TextFormField(
                    decoration: InputDecoration(prefixIcon: Icon(MdiIcons.bio)),
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    initialValue: bio,
                    onChanged: (text) {
                      setState(() {
                        _bio = text;
                      });
                    },
                  ),
                  Divider(
                    height: 15,
                  ),
                  SizedBox(
                    // Button Submit Edit
                    width: 150,
                    height: 50,
                    child: FlatButton(
                        disabledColor: Color(0xFFE4E4E4),
                        shape:
                            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        color: accentColor2,
                        child: Text(
                          "Submit",
                          style: blackTextFont.copyWith(
                              fontSize: 16, color: accentColor3, fontWeight: FontWeight.bold),
                        ),
                        onPressed: email != null &&
                                firstName != null &&
                                lastName != null &&
                                bio != null &&
                                phone != null
                            ? () async {
                                setState(() {});
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    });
                                if (_email == null) {
                                  _email = email;
                                }
                                if (_firstName == null) {
                                  _firstName = firstName;
                                }
                                if (_lastName == null) {
                                  _lastName = lastName;
                                }
                                if (_phone == null) {
                                  _phone = phone;
                                }
                                if (_username == null) {
                                  _username = username;
                                }
                                if (_bio == null) {
                                  _bio = bio;
                                }
                                if (_selectedGender == null) {
                                  _selectedGender = selectedGen;
                                }
                                if (pictureFile != null) {
                                  await context.read<UserCubit>().updateProfile(
                                      User(
                                          email: _email,
                                          first_name: _firstName,
                                          last_name: _lastName,
                                          phone_number: _phone,
                                          bio: _bio,
                                          gender: _selectedGender),
                                      pictureFile: pictureFile);
                                } else {
                                  await context.read<UserCubit>().updateProfile(
                                        User(
                                            email: _email,
                                            first_name: _firstName,
                                            last_name: _lastName,
                                            phone_number: _phone,
                                            bio: _bio,
                                            gender: _selectedGender),
                                      );
                                }
                                Navigator.pop(context);
                                UserState state = context.read<UserCubit>().state;
                                if (state is UserLoaded) {
                                  Navigator.pop(context);
                                  Get.back();
                                  Get.snackbar("Profile Updated", "Your Profile Has Been Updated");
                                } else {
                                  Get.snackbar(
                                    "",
                                    "",
                                    backgroundColor: HexColor("D9435E"),
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                    titleText: Text("Update Profile Failed", style: blackTextFont),
                                    messageText: Text(
                                      'Something Wrong', //state.message ?? '',
                                      style: blackTextFont,
                                    ),
                                  );
                                }
                              }
                            : null),
                  ),
                  Divider(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
