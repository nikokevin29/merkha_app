part of 'widgets.dart';

class AddressCard extends StatelessWidget {
  final Address address;

  AddressCard(this.address);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        ListTile(
          //Address Save Name
          title: Text(
            address.addressSaveName,
            style: blackTextFont.copyWith(),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              // Text(
              //   //User Name
              //   address.idUser.toString(),
              //   overflow: TextOverflow.ellipsis,
              //   style: blackTextFont.copyWith(fontWeight: FontWeight.bold),
              // ),
              SizedBox(height: 5),
              Text(
                address.address,
                maxLines: 5,
                style: blackTextFont.copyWith(),
              ),
              Text(
                /*address.city + ', ' + address.province + ', ' + */ address.postalCode,
                maxLines: 5,
                style: blackTextFont.copyWith(),
              ),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: Colors.redAccent,
                  onPressed: () async {
                    Widget cancelButton = FlatButton(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    );
                    Widget okButton = FlatButton(
                      child: Text("OK"),
                      onPressed: () async {
                        await context.read<AddressCubit>().deleteAddress(address.id.toString());
                        context.read<AddressCubit>().showAddress(); // For Refresh Get All
                        Get.back();
                      },
                    );
                    AlertDialog deleteAlert = AlertDialog(
                      title: Text("Delete Address"),
                      content: Text("Are you sure want to Delete this address ?"),
                      actions: [
                        cancelButton,
                        okButton,
                      ],
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return deleteAlert;
                        });
                  },
                  child: Text('Delete', style: blackTextFont.copyWith(color: Colors.white)),
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: Colors.greenAccent,
                  onPressed: () {
                    //Edit Button
                    Get.to(EditAddress(addressid: address.id));
                    print('edit' + address.id.toString());
                  },
                  child: Text('Edit', style: blackTextFont.copyWith(color: Colors.white)),
                ),
              ]),
            ],
          ),
        ),
      ]),
    );
  }
}
