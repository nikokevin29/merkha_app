part of 'pages.dart';

typedef void CallbackAddressFeed(Address address);

class AddressFeedPick extends StatelessWidget {
  final CallbackAddressFeed onSonChanged;
  AddressFeedPick({this.onSonChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text('Pick Your Address', style: blackTextFont.copyWith()),
            backgroundColor: Colors.white,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context); //Close PopMenu Button in Profile Tab
                Get.back();
              },
            )),
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
                                      child: GestureDetector(
                                          onTap: () {
                                            onSonChanged(Address(
                                                id: e.id,
                                                idProvince: e.idProvince,
                                                idCity: e.idCity,
                                                addressSaveName: e.addressSaveName,
                                                address: e.address,
                                                postalCode: e.postalCode,
                                                city: e.city,
                                                province: e.province));
                                            Get.back();
                                          },
                                          child: AddressPickCard(e)),
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
