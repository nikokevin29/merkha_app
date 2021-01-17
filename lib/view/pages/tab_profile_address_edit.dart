part of 'pages.dart';

class EditAddress extends StatefulWidget {
  final Address address;
  EditAddress({this.address});
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  TextEditingController addressSaveNameController;
  TextEditingController addressController;
  TextEditingController postalCodeController;
  bool isaddressSN = false, isaddress = false, ispostal = false, iscity = false, isprovince = false;
  var _valueProvince, _valueCity, _provinceName, _cityName;
  List<dynamic> _dataProvince = List();
  List<dynamic> _dataCity = List();

  @override
  void initState() {
    super.initState();
    addressSaveNameController = TextEditingController(text: widget.address.addressSaveName);
    addressController = TextEditingController(text: widget.address.address);
    postalCodeController = TextEditingController(text: widget.address.postalCode);
    _valueProvince = widget.address.idProvince;
    _valueCity = widget.address.idCity;

    _cityName = widget.address.city;
  }

  getProvince() async {
    final response = await http.get(apiRajaOngkir + 'province', headers: {"key": apiKeyOngkir});
    var jsonObject = jsonDecode(response.body);
    if (response.statusCode == 400) {
      print('Quota RajaOngkir has reached the daily limit.');
      Get.snackbar('Limit Quota', 'Quota has reached the daily limit.');
    }
    var listProvince = (jsonObject as Map<String, dynamic>)['rajaongkir']['results'];
    _dataProvince = listProvince;
    print(_dataProvince);
    return listProvince;
  }

  getCity(var idProvince) async {
    final response = await http
        .get(apiRajaOngkir + 'city?province=' + _valueProvince, headers: {"key": apiKeyOngkir});
    var jsonObject = jsonDecode(response.body);
    var listCity = await (jsonObject as Map<String, dynamic>)['rajaongkir']['results'];
    setState(() {
      _dataCity = listCity;
    });
    print('city Getter');
    return _dataCity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Edit Address', style: blackTextFont.copyWith()),
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
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: addressSaveNameController,
                  decoration: InputDecoration(labelText: "Address Save Name"),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 4,
                  controller: addressController,
                  decoration: InputDecoration(labelText: "Address"),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: postalCodeController,
                  decoration: InputDecoration(labelText: "Postal Code (5 Digit)"),
                ),
                buildProvince(),
                buildCity(),
                SizedBox(height: 15),
                SizedBox(height: 15),
                FlatButton(
                  disabledColor: Color(0xFFE4E4E4),
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  color: accentColor2,
                  child: Text(
                    "Submit",
                    style: blackTextFont.copyWith(
                        fontSize: 16, color: accentColor3, fontWeight: FontWeight.bold),
                  ),
                  onPressed: addressSaveNameController.text.length != 0 &&
                          addressController.text.length != 0 &&
                          postalCodeController.text.length == 5
                      ? () async {
                          //Action Here
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              });
                          await context.read<AddressCubit>().editAddress(
                                widget.address.id,
                                Address(
                                    addressSaveName: addressSaveNameController.text,
                                    address: addressController.text,
                                    postalCode: postalCodeController.text,
                                    city: _cityName,
                                    province: _provinceName,
                                    idCity: _valueCity,
                                    idProvince: _valueProvince),
                              );
                          await context.read<AddressCubit>().showAddress(); //Reload Address
                          Navigator.pop(context);
                          Get.back();
                          Get.snackbar('Success', 'Success Edit Address');
                        }
                      : null,
                )
              ],
            )),
      ),
    );
  }

  DropdownButton buildCity() {
    return DropdownButton(
        isExpanded: true,
        hint: Text(_cityName),
        value: _valueCity,
        items: _dataCity.map((item) {
          return DropdownMenuItem(
            child: Text(item['city_name']),
            value: item['city_id'],
            onTap: () {
              _cityName = item['city_name']; //Get City Name
            },
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _valueCity = value;

            print("City id :" + _valueCity.toString());
          });
        });
  }

  Widget buildProvince() {
    return FutureBuilder(
        future: getProvince(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonFormField(
                isExpanded: true,
                hint: Text('Select Province'),
                value: _valueProvince,
                items: _dataProvince
                    .map((item) => DropdownMenuItem(
                          child: Text(item['province']),
                          value: item['province_id'],
                          onTap: () {
                            _provinceName = item['province']; //Get Province Name
                          },
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _valueProvince = value;
                    // _valueCity and iscity reset after province changed
                    _valueCity = null;
                    iscity = false;
                    print("Province ID " + _valueProvince);
                  });
                  getCity(value);
                });
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
