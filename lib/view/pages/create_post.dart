part of 'pages.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  File _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    PickedFile pickedFile = await _picker.getImage(source: source, maxWidth: 1000, maxHeight: 1000);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path, aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (cropped != null) {
      setState(() {
        _imageFile = cropped ?? _imageFile;
      });
    }
  }

  //Clear Image
  void clear() {
    setState(() => _imageFile = null);
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
          title: Center(
            child: Text(
              'Photo',
              style: blackMonstadtTextFont.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Container(
              child: (_imageFile != null)
                  ? InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text('Next', style: blackMonstadtTextFont.copyWith(fontSize: 15)),
                      ),
                      onTap: () {
                        Get.to(CreatePost2(imageFile: _imageFile));
                      })
                  : Container(),
            )
          ]),
      body: Container(
        color: Colors.white70,
        child: Column(
          children: [
            SizedBox(height: 7),
            Container(
              //margin: EdgeInsets.only(bottom: 100),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.grey),
              child: (_imageFile == null)
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.width - 20,
                      child: Center(child: Text('No image selected')))
                  : Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.grey),
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.width - 20,
                      child: Image.file(_imageFile)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Icon(Icons.crop, color: Colors.black),
                    onTap: (_imageFile != null) ? _cropImage : null,
                  ),
                  InkWell(
                    child: Icon(Icons.clear, color: Colors.black),
                    onTap: clear,
                  ),
                ],
              ),
            ),
            // Center(
            //   child: InkWell(
            //     child: Container(
            //       width: 50,
            //       height: 50,
            //       decoration: BoxDecoration(
            //         border: Border.all(color: Colors.white),
            //         shape: BoxShape.circle,
            //         color: HexColor('#707070'),
            //       ),
            //     ),
            //     onTap: _cropImage,
            //   ),
            // ),
            //
          ],
        ),
      ),
      bottomSheet: Container(
        height: 88,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Container(
            width: MediaQuery.of(context).size.width - (2 * defaultMargin),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  child: Text(
                    'Galery',
                    style: blackMonstadtTextFont.copyWith(),
                  ),
                  onTap: () => getImage(ImageSource.gallery),
                ),
                InkWell(
                  child: Text(
                    'Camera',
                    style: blackMonstadtTextFont.copyWith(),
                  ),
                  onTap: () => getImage(ImageSource.camera),
                )
              ],
            )),
      ),
    );
  }
}
