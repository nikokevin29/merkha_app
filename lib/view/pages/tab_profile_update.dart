part of 'pages.dart';

class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  List<String> gender = ['Male', 'Female', 'Not Preter Yet'];
  String _selectedGender;
  bool isEmailValid = false;
  File pictureFile;
  String email, username, firstName, lastName, phone, selectedGen, bio; //Setter
  String _email, _username, _firstName, _lastName, _phone, _bio; //Getter
  @override
  Widget build(BuildContext context) {
    email = (context.watch<UserCubit>().state as UserLoaded).user.email ?? '';
    username = (context.watch<UserCubit>().state as UserLoaded).user.username ?? '';
    firstName = (context.watch<UserCubit>().state as UserLoaded).user.first_name ?? '';
    lastName = (context.watch<UserCubit>().state as UserLoaded).user.last_name ?? '';
    phone = (context.watch<UserCubit>().state as UserLoaded).user.phone_number ?? '';
    selectedGen = (context.watch<UserCubit>().state as UserLoaded).user.gender ?? '';
    bio = (context.watch<UserCubit>().state as UserLoaded).user.bio ?? '';
    _selectedGender = (context.watch<UserCubit>().state as UserLoaded).user.gender;
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
      body: SafeArea(
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
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  initialValue: email,
                  decoration: InputDecoration(prefixIcon: Icon(MdiIcons.email), labelText: "Email"),
                  onChanged: (text) {
                    setState(() {
                      _email = text;
                      //isEmailValid = EmailValidator.validate(text.trim());
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  initialValue: username,
                  decoration:
                      InputDecoration(prefixIcon: Icon(MdiIcons.account), labelText: "Username"),
                  onChanged: (text) {
                    setState(() {
                      _username = text;
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  initialValue: firstName,
                  decoration:
                      InputDecoration(prefixIcon: Icon(MdiIcons.account), labelText: "First Name"),
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
                  decoration:
                      InputDecoration(prefixIcon: Icon(MdiIcons.phone), labelText: "Phone Number"),
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
                    hint: Text('Please Choose Your Gender'),
                    value: _selectedGender,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedGender = newValue;
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
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
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
                              if (pictureFile != null) {
                                context.read<UserCubit>().updateProfile(
                                    User(
                                        email: _email,
                                        first_name: _firstName,
                                        last_name: _lastName,
                                        phone_number: _phone,
                                        username: _username,
                                        bio: _bio,
                                        gender: _selectedGender),
                                    pictureFile: pictureFile);
                              }else{
                                context.read<UserCubit>().updateProfile(
                                    User(
                                        email: _email,
                                        first_name: _firstName,
                                        last_name: _lastName,
                                        phone_number: _phone,
                                        username: _username,
                                        bio: _bio,
                                        gender: _selectedGender),
                                  );
                              }
                              Navigator.pop(context);
                              Get.snackbar("Profile Updated", "Your Profile Has Been Updated");
                              Get.back();
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
    );
  }
}
