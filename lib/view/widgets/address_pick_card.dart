part of 'widgets.dart';

class AddressPickCard extends StatelessWidget {
  final Address address;

  AddressPickCard(this.address);

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
              Text(
                address.address,
                maxLines: 5,
                style: blackTextFont.copyWith(),
              ),
              Row(
                children: [
                  Text(
                    address.city,
                    maxLines: 1,
                    style: blackTextFont.copyWith(),
                  ),
                  Text(', ', style: blackTextFont.copyWith()),
                  Text(
                    address.province,
                    maxLines: 1,
                    style: blackTextFont.copyWith(),
                  ),
                ],
              ),
              Text(
                address.postalCode,
                maxLines: 5,
                style: blackTextFont.copyWith(),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ]),
    );
  }
}