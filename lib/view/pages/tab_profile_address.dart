part of 'pages.dart';

class AddressSettings extends StatefulWidget {
  @override
  _AddressSettingsState createState() => _AddressSettingsState();
}

class _AddressSettingsState extends State<AddressSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text('Address Settings', style: blackTextFont.copyWith()),
            backgroundColor: Colors.white,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context); //Close PopMenu Button in Profile Tab
                Get.back();
              },
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Get.to(AddAddress());
                },
                child: Text(
                  "Add",
                  style: blackTextFont.copyWith(color: Colors.blue),
                ),
              ),
            ]),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.84,
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder<AddressCubit, AddressState>(
                builder: (_, state) => (state is AddressListLoaded)
                    ? ListView(
                        children: [
                          Column(
                            children: state.address
                                .map((e) => Padding(
                                      padding: EdgeInsets.only(
                                          top: (e == state.address.first) ? defaultMargin : 0,
                                          bottom: (e == state.address.last) ? defaultMargin : 0),
                                      child: AddressCard(e),
                                    ))
                                .toList(),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
              ),
            ),
          ),
        ));
  }
}

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

  Future<void> getProvince() async {
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

  Future<void> getCity(var idProvince) async {
    final response = await http
        .get(apiRajaOngkir + 'city?province=' + _valueProvince, headers: {"key": apiKeyOngkir});
    var jsonObject = jsonDecode(response.body);
    var listCity = await (jsonObject as Map<String, dynamic>)['rajaongkir']['results'];
    setState(() {
      _dataCity = listCity;
    });

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
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.text,
              controller: addressSaveNameController,
              decoration: InputDecoration(labelText: "Address Save Name"),
              onChanged: (text) {
                setState(() {
                  text != '' ? isaddressSN = true : isaddressSN = false;
                });
              },
            ),
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
            FutureBuilder(
                future: getProvince(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton(
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
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                }),
            Center(
                child: DropdownButton(
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
                    })),
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
                      await context.read<AddressCubit>().addAddress(
                            Address(
                              addressSaveName: addressSaveNameController.text,
                              address:
                                  addressController.text + ', ' + _cityName + ', ' + _provinceName,
                              postalCode: postalCodeController.text,
                              city: _valueCity,
                              province: _valueProvince,
                            ),
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
    );
  }
}

class EditAddress extends StatefulWidget {
  final String addressid;
  EditAddress({this.addressid});
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  TextEditingController addressSaveNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  bool isaddressSN = false, isaddress = false, ispostal = false, iscity = false, isprovince = false;
  var _valueProvince, _valueCity, _provinceName, _cityName;
  List<dynamic> _dataProvince = List();
  List<dynamic> _dataCity = List();

  Future<void> getProvince() async {
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

  Future<void> getCity(var idProvince) async {
    final response = await http
        .get(apiRajaOngkir + 'city?province=' + _valueProvince, headers: {"key": apiKeyOngkir});
    var jsonObject = jsonDecode(response.body);
    var listCity = await (jsonObject as Map<String, dynamic>)['rajaongkir']['results'];
    setState(() {
      _dataCity = listCity;
    });

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
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.text,
                controller: addressSaveNameController,
                decoration: InputDecoration(labelText: "Address Save Name"),
                onChanged: (text) {
                  setState(() {
                    text != '' ? isaddressSN = true : isaddressSN = false;
                  });
                },
              ),
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
              FutureBuilder(
                  future: getProvince(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButton(
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
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  }),
              Center(
                  child: DropdownButton(
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
                      })),
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
                        await context.read<AddressCubit>().editAddress(
                              widget.addressid,
                              Address(
                                addressSaveName: addressSaveNameController.text,
                                address: addressController.text +
                                    ', ' +
                                    _cityName +
                                    ', ' +
                                    _provinceName,
                                postalCode: postalCodeController.text,
                                city: _valueCity,
                                province: _valueProvince,
                              ),
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
    );
  }
}
