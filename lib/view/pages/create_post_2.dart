part of 'pages.dart';

class CreatePost2 extends StatefulWidget {
  final File imageFile;
  CreatePost2({this.imageFile});

  @override
  _CreatePost2State createState() => _CreatePost2State();
}

class _CreatePost2State extends State<CreatePost2> {
  TextEditingController captionController = TextEditingController();
  String location;
  Product product;
  String pName;
  int pId;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return Future.error('Location permissions are denied (actual value: $permission).');
      }
    }
    Position position = await Geolocator.getLastKnownPosition();
    print(position.latitude);
    print(position.longitude);
    final coor = new geocode.Coordinates(position.latitude, position.longitude);
    var address = await geocode.Geocoder.local.findAddressesFromCoordinates(coor);
    print(address.first.addressLine);
    setState(() {
      location = address.first.addressLine;
    });
    return await Geolocator.getCurrentPosition();
  }

  void update(int newId, String newString) {
    setState(() {
      pId = newId;
      pName = newString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        title: Center(child: Text('New Post', style: blackMonstadtTextFont.copyWith(fontSize: 15))),
        actions: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Post',
                  style: blackMonstadtTextFont.copyWith(fontSize: 15, color: Colors.white)))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: defaultMargin),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                        image: FileImage(widget.imageFile),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: Colors.white70,
                          primaryColorDark: Colors.grey,
                        ),
                        child: TextField(
                          controller: captionController,
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.transparent),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(15.0),
                              ),
                            ),
                            hintText: 'Write a caption...',
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(pName ?? '...'),
                  //Text(pId.toString() ?? ''),
                  FlatButton(
                    minWidth: 100,
                    height: 30,
                    disabledColor: Color(0xFFE4E4E4),
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    color: accentColor2,
                    onPressed: () {
                      //TODO: Add Product
                      Get.to(SearchProductFeed(onSonChanged: (int newId, String newString) {
                        update(newId, newString);
                      }));
                    },
                    child: Text('Tag Product'),
                  ),
                ],
              ),
              Divider(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(location ?? '', overflow: TextOverflow.clip)),
                  FlatButton(
                    minWidth: 100,
                    height: 30,
                    disabledColor: Color(0xFFE4E4E4),
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    color: accentColor2,
                    onPressed: () {
                      //TODO: Add Location
                      _determinePosition();
                    },
                    child: Text('Location'),
                  ),
                ],
              ),
              Divider(height: 15),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              alignment: Alignment.bottomRight,
              child: FlatButton(
                disabledColor: Color(0xFFE4E4E4),
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                color: accentColor2,
                onPressed: () async {
                  print(pId.toString());
                  print(captionController.text);
                  if (captionController.text == '') {
                    Get.snackbar('Empty Field', 'Caption required');
                  }
                  // note: if Product Required
                  // else if (pId == null) {
                  //   Get.snackbar('Empty Field', 'Product required');
                  // }
                  else {
                    print('Passed validation');
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                    await context.read<FeedCubit>().createFeed(
                          urlPhoto: widget.imageFile,
                          location: location,
                          idProduct: pId.toString(),
                          caption: captionController.text,
                        );
                    await context.read<OwnfeedCubit>().showOwnFeed(); //Get all Feed
                    Get.offAll(MainPage(bottomNavBarIndex: 4));
                    Get.snackbar('Success posting Feed', 'your feed has been posted');
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Share', style: blackTextFont.copyWith(fontSize: 22)),
                    SizedBox(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
