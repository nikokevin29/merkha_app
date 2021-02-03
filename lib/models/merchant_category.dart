part of 'models.dart';

class MerchantCategory extends Equatable {
  final int id;
  final String categoryName;
  final String urlImage;
  MerchantCategory({
    this.id,
    this.categoryName,
    this.urlImage,
  });

  @override
  List<Object> get props => [
        id,
        categoryName,
        urlImage,
      ];
  factory MerchantCategory.fromJson(Map<String, dynamic> data) => MerchantCategory(
        id: data['id'],
        categoryName: data['category_name'],
        urlImage: data['url_image'],
      );
}
