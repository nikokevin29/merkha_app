part of 'models.dart';

class ReviewProduct extends Equatable {
  final int id;
  final int idProduct;
  final String username;
  final String urlPhoto;
  final String isHiddenName;
  final double stars;
  final String description;
  final String createdAt;
  ReviewProduct({
    this.id,
    this.idProduct,
    this.username,
    this.urlPhoto,
    this.isHiddenName,
    this.stars,
    this.description,
    this.createdAt,
  });

  @override
  List<Object> get props => [
        id,
        idProduct,
        username,
        urlPhoto,
        isHiddenName,
        stars,
        description,
        createdAt,
      ];

  factory ReviewProduct.fromJson(Map<String, dynamic> data) => ReviewProduct(
        id: data['id'],
        idProduct: int.parse(data['id_product'].toString()),
        username: data['username'],
        urlPhoto: data['url_photo'],
        isHiddenName: data['is_hidden_name'],
        stars: double.parse(data['stars'].toString()),
        description: data['description'],
        createdAt: data['created_at'],
      );

  ReviewProduct copyWith({
    int id,
    int idProduct,
    String username,
    String urlPhoto,
    String isHiddenName,
    double stars,
    String description,
    String createdAt,
  }) {
    return ReviewProduct(
      id: id ?? this.id,
      idProduct: idProduct ?? this.idProduct,
      username: username ?? this.username,
      urlPhoto: urlPhoto ?? this.urlPhoto,
      isHiddenName: isHiddenName ?? this.isHiddenName,
      stars: stars ?? this.stars,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
