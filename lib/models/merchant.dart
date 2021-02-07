part of 'models.dart';

class Merchant extends Equatable {
  final String idUser;
  final String merchantId;
  final String merchantName;
  final String merchantLogo;
  final String description;
  final String phoneNumber;
  final String province;
  final String city;
  final String country;
  final String website;
  final String followersCount;
  final String lastAccess;
  final String activeStatus;
  final String urlPhoto;
  final String createdAt;
  final String updatedAt;

  Merchant({
    this.idUser,
    this.merchantId,
    this.merchantName,
    this.merchantLogo,
    this.description,
    this.phoneNumber,
    this.province,
    this.city,
    this.country,
    this.website,
    this.followersCount,
    this.lastAccess,
    this.activeStatus,
    this.urlPhoto,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object> get props => [
        idUser,
        merchantId,
        merchantName,
        merchantLogo,
        description,
        phoneNumber,
        province,
        city,
        country,
        website,
        followersCount,
        lastAccess,
        activeStatus,
        urlPhoto,
        createdAt,
        updatedAt,
      ];

  // "id_user": 8,
  // "id_merchant": 2,
  // "name": "UD Mansur",
  // "merchant_logo": "https://firebasestorage.googleapis.com/v0/b/merkha-firebase.appspot.com/o/Merchant%2F11%2FMerchant_files%2FLogo?alt=media&token=afccadf0-ffb4-45f6-9c37-4dfd5078d56a",
  // "description": "Quo error aperiam rem recusandae.",
  // "province": "Bengkulu",
  // "city": "Solok",
  // "country": "Amerika Serikat",
  // "followers_count": 8632,
  // "created_at": "2021-01-23 18:24:52",
  // "updated_at": "2021-01-23 18:24:52",
  // "last_access": "2021-01-27 15:26:47",
  // "active_status": 0

  factory Merchant.fromJson(Map<String, dynamic> data) => Merchant(
        idUser: data['id_user'].toString(),
        merchantId: data['id_merchant'].toString(),
        merchantName: data['name'],
        merchantLogo: data['merchant_logo'],
        description: data['description'],
        province: data['province'],
        city: data['city'],
        country: data['country'],
        website: data['website'],
        followersCount: data['followers_count'].toString(),
        lastAccess: data['last_access'],
        activeStatus: data['active_status'].toString(),
        createdAt: data['created_at'],
        updatedAt: data['updated_at'],
      );
}
