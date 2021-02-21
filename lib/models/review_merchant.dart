part of 'models.dart';

class ReviewMerchant extends Equatable {
  final int id;
  final int idOrder;
  final int idMerchant;
  final String username;
  final String urlPhoto;
  final String isHiddenName;
  final double stars;
  final String description;
  final String createdAt;
  ReviewMerchant({
    this.id,
    this.idOrder,
    this.idMerchant,
    this.username,
    this.urlPhoto,
    this.isHiddenName,
    this.stars,
    this.description,
    this.createdAt,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        idOrder,
        username,
        idMerchant,
        urlPhoto,
        isHiddenName,
        stars,
        description,
        createdAt,
      ];

  factory ReviewMerchant.fromJson(Map<String, dynamic> data) => ReviewMerchant(
        id: data['id'],
        idOrder: int.parse(data['id_order'].toString()),
        username: data['username'],
        urlPhoto: data['url_photo'],
        isHiddenName: data['is_hidden_name'],
        stars: double.parse(data['stars'].toString()),
        description: data['description'],
        createdAt: data['created_at'],
      );
}
