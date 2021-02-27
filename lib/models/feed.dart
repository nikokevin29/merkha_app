part of 'models.dart';

class Feed extends Equatable {
  final int id;
  final String idUser;
  final String idProduct;
  final int idMerchant;
  final String username;
  final String merchantUsername;
  final String urlPhotoUser;
  final String merchantName;
  final String merchantLogo;
  final String merchantLastAccess;
  final String merchantDescription;
  final String merchantWebsite;
  final String productName;
  final double productPrice;
  final int likeCount;
  final String urlImage;
  final String caption;
  final String location;

  Feed({
    this.id,
    this.idUser,
    this.idProduct,
    this.idMerchant,
    this.username,
    this.urlPhotoUser,
    this.merchantUsername,
    this.merchantName,
    this.merchantLogo,
    this.merchantLastAccess,
    this.merchantDescription,
    this.merchantWebsite,
    this.productName,
    this.productPrice,
    this.likeCount,
    this.urlImage,
    this.caption,
    this.location,
  });

  factory Feed.fromJson(Map<String, dynamic> data) => Feed(
        id: data['id'],
        idProduct: data['id_product'].toString(),
        idUser: data['id_user'].toString() ?? '0',
        idMerchant: data['id_merchant'] ?? 0,
        username: data['username'],
        urlPhotoUser: data['url_photo'],
        merchantUsername: data['merchant_username'],
        merchantName: data['merchant_name'],
        merchantLogo: data['merchant_logo'],
        merchantLastAccess: data['last_access'],
        merchantDescription: data['description'],
        merchantWebsite: data['website'],
        productName: data['product_name'],
        productPrice: double.parse(data['price'].toString()),
        likeCount: data['like_count'],
        urlImage: data['url_image'],
        caption: data['caption'],
        location: data['location'],
      );

  @override
  List<Object> get props => [
        merchantLogo,
        productPrice,
        id,
        idProduct,
        idUser,
        idMerchant,
        username,
        urlPhotoUser,
        merchantName,
        merchantUsername,
        merchantLastAccess,
        merchantDescription,
        merchantWebsite,
        productName,
        likeCount,
        urlImage,
        caption,
        location,
      ];
}
