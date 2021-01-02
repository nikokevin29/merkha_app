part of 'pages.dart';

class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  List<String> gender = ['Male', 'Female', 'Not Preter Yet'];
  String _selectedGender;
  bool isEmailValid = false;
  File pictureFile;
  bool isfirst = false;
  bool islast = false;
  bool isuser = false;
  bool ispass = false;
  bool isphone = false;
  @override
  Widget build(BuildContext context) {
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
                                    image: NetworkImage(
                                      ((context.watch<UserCubit>().state as UserLoaded)
                                                  .user
                                                  .urlphoto !=
                                              null)
                                          ? (context.watch<UserCubit>().state as UserLoaded)
                                              .user
                                              .urlphoto
                                          : AssetImage("assets/defaultProfile.png"),
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(prefixIcon: Icon(MdiIcons.email), labelText: "Email"),
                  onChanged: (text) {
                    setState(() {
                      isEmailValid = EmailValidator.validate(text.trim());
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: usernameController,
                  decoration:
                      InputDecoration(prefixIcon: Icon(MdiIcons.account), labelText: "Username"),
                  onChanged: (text) {
                    setState(() {
                      text != '' ? isuser = true : isuser = false;
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: firstNameController,
                  decoration:
                      InputDecoration(prefixIcon: Icon(MdiIcons.account), labelText: "First Name"),
                  onChanged: (text) {
                    setState(() {
                      text != '' ? isfirst = true : isfirst = false;
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: lastNameController,
                  decoration:
                      InputDecoration(prefixIcon: Icon(MdiIcons.account), labelText: "Last Name"),
                  onChanged: (text) {
                    setState(() {
                      text != '' ? islast = true : islast = false;
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration:
                      InputDecoration(prefixIcon: Icon(MdiIcons.phone), labelText: "Phone Number"),
                  onChanged: (text) {
                    setState(() {
                      text != '' ? isphone = true : isphone = false;
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
                      onPressed: isEmailValid && isfirst && islast && isuser && isphone
                          ? () async {
                              setState(() {});
                              //Execution Here
                            }
                          : null),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
