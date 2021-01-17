part of 'pages.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController addressSaveNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  bool isaddressSN = false, isaddress = false, ispostal = false, iscity = false, isprovince = false;
  var _valueProvince, _valueCity, _provinceName, _cityName;
  List<dynamic> _dataProvince = List();
  List<dynamic> _dataCity = List();

  @override
  void initState() {
    super.initState();
    getProvince();
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
    print(listProvince);
    return listProvince;
  }

  getCity(var idProvince) async {
    final response = await http
        .get(apiRajaOngkir + 'city?province=' + idProvince, headers: {"key": apiKeyOngkir});
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
        title: Text('Create New Address', style: blackTextFont.copyWith()),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                return TextField(
                  keyboardType: TextInputType.text,
                  controller: addressSaveNameController,
                  decoration: InputDecoration(labelText: "Address Save Name"),
                  onChanged: (text) {
                    setState(() {
                      text != '' ? isaddressSN = true : isaddressSN = false;
                    });
                  },
                );
              }),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                minLines: 4,
                controller: addressController,
                decoration: InputDecoration(labelText: "Address"),
                onChanged: (text) {
                  setState(() {
                    text != '' ? isaddress = true : isaddress = false;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: postalCodeController,
                decoration: InputDecoration(labelText: "Postal Code (5 Digit)"),
                onChanged: (text) {
                  setState(() {
                    text.length == 5 ? ispostal = true : ispostal = false;
                  });
                },
              ),
              buildProvince(),
              buildCity(),
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
                onPressed: isaddressSN == true &&
                        isaddress == true &&
                        ispostal == true &&
                        iscity == true &&
                        isprovince == true
                    ? () async {
                        //Action Here
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        print(_valueCity + 'dan' + _valueProvince);
                        await context.read<AddressCubit>().addAddress(
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
                        Get.snackbar('Success', 'Success Adding New Address');
                      }
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCity() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return DropdownButton(
            isExpanded: true,
            hint: Text('Select City'),
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

                _valueCity != '' ? iscity = true : iscity = false;
                print("City id :" + _valueCity.toString());
              });
            });
      },
    );
  }

  Widget buildProvince() {
    // return FutureBuilder(
    //     future: getProvince(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return DropdownButton(
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
                _valueProvince != '' ? isprovince = true : isprovince = false;
                // _valueCity and iscity reset after province changed
                _valueCity = null;
                iscity = false;
                print("Province ID " + _valueProvince);
              });
              getCity(value);
            });
      },
    );
    //   } else {
    //     return Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Center(child: CircularProgressIndicator()),
    //     );
    //   }
    // });
  }
}
