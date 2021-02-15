part of 'pages.dart';

class ConfirmPaymentPage extends StatefulWidget {
  final String idOrders;
  ConfirmPaymentPage({this.idOrders});
  @override
  _ConfirmPaymentPageState createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  File _imageFile;
  final ImagePicker _picker = ImagePicker();
  Future<void> getImage(ImageSource source) async {
    PickedFile pickedFile = await _picker.getImage(source: source, maxWidth: 1000, maxHeight: 1000);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Confirm Payment', style: blackTextFont.copyWith()),
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              // Get.offAll(MainPage(bottomNavBarIndex: 4));
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.grey[300],
                  ),
                  child: (_imageFile == null)
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width - 20,
                          height: MediaQuery.of(context).size.width - 20,
                          child: Center(child: Text('No image selected')))
                      : Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: MediaQuery.of(context).size.width - 20,
                          child: Image.file(_imageFile),
                        ),
                ),
                SizedBox(height: 50),
                Center(
                  child: Text(
                    'Pick Your evidence of transfer by :',
                    style: blackMonstadtTextFont.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                      child: Text(
                        'Camera',
                        style: blackMonstadtTextFont.copyWith(fontSize: 18),
                      ),
                      onPressed: () => getImage(ImageSource.camera),
                    ),
                    FlatButton(
                      child: Text(
                        'Gallery',
                        style: blackMonstadtTextFont.copyWith(fontSize: 18),
                      ),
                      onPressed: () => getImage(ImageSource.gallery),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                FlatButton(
                  color: Colors.greenAccent,
                  splashColor: Colors.green,
                  disabledColor: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.transparent, width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'Confirm Payment',
                    style: blackMonstadtTextFont.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    //TODO: Store Image to Datebassa
                    //require: id_order,payment_status,url_bukti_transfer
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                    SharedPreferences orders = await SharedPreferences.getInstance();
                    int lastId = orders.getInt('lastId'); // get idOrder from SharedPreferences
                    await PaymentService.createPayment(
                      urlphoto: _imageFile,
                      payment: Payment(
                        idOrder: lastId,
                        paymentStatus: 1,
                        //urlBuktiTransfer: '-',
                      ),
                    );
                    Get.offAll(MainPage(bottomNavBarIndex: 4));
                    Get.snackbar('Upload Success', 'Evidence Transfer Success');
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
