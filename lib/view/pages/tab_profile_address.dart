part of 'pages.dart';

class AddressSettings extends StatefulWidget {
  @override
  _AddressSettingsState createState() => _AddressSettingsState();
}

class _AddressSettingsState extends State<AddressSettings> {
  @override
  void initState() {
    super.initState();
    context.read<AddressCubit>().showAddress();
  }

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
