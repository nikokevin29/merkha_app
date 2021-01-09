part of 'models.dart';

class Merchant extends Equatable {
  final String idUser;
  final String merchantId;
  final String businessType;
  final String merchantCategory;
  final String merchantName;
  final String address;
  final String email;
  final String phoneNumber;
  final String status;
  final String bio;
  final String followersCount;
  final String followingCount;
  final String urlPhoto;
  final String createdAt;
  final String updatedAt;

  Merchant(
      {this.idUser,
      this.merchantId,
      this.businessType,
      this.merchantCategory,
      this.merchantName,
      this.address,
      this.email,
      this.phoneNumber,
      this.status,
      this.bio,
      this.followersCount,
      this.followingCount,
      this.urlPhoto,
      this.createdAt,
      this.updatedAt});

  @override
  List<Object> get props => [
        idUser,
        merchantId,
        businessType,
        merchantName,
        address,
        email,
        phoneNumber,
        status,
        bio,
        followersCount,
        followingCount,
        urlPhoto,
        createdAt,
        updatedAt,
      ];

  factory Merchant.fromJson(Map<String, dynamic> data) => Merchant(
        idUser: data['id_user'].toString(),
        merchantId: data['merchant_id'],
        businessType: data['business_type'],
        merchantCategory: data['merchant_category'],
        merchantName: data['merchant_name'],
        address: data['address'],
        email: data['email'],
        phoneNumber: data['phone_number'],
        status: data['status'],
        bio: data['bio'],
        followersCount: data['followers_count'].toString(),
        followingCount: data['following_count'].toString(),
        urlPhoto: data['url_photo'],
        createdAt: data['created_at'],
        updatedAt: data['updated_at'],
      );
}
