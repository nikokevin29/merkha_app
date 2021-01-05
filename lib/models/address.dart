part of 'models.dart';

class Address extends Equatable {
  final String id;
  final int idUser;
  final String addressSaveName;
  final String address;
  final String postalCode;
  final String city;
  final String province;
  final String createdAt;
  final String updatedAt;

  Address(
      {this.id,
      this.idUser,
      this.addressSaveName,
      this.address,
      this.postalCode,
      this.city,
      this.province,
      this.createdAt,
      this.updatedAt});

  factory Address.fromJson(Map<String, dynamic> data) => Address(
        id: data['id'].toString(),
        idUser: data['id_user'],
        addressSaveName: data['address_save_name'],
        address: data['address'],
        postalCode: data['postal_code'],
        city: data['city'],
        province: data['province'],
        createdAt: data['created_at'],
        updatedAt: data['updated_at'],
      );

  @override
  List<Object> get props => [
        id,
        idUser,
        addressSaveName,
        address,
        postalCode,
        city,
        province,
        createdAt,
        updatedAt,
      ];
}
