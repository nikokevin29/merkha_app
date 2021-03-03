part of 'models.dart';

class AppContent extends Equatable {
  final int id;
  final int idMerchant;
  final int idMerchantCategory;
  final String urlImage;
  AppContent({
    this.id,
    this.idMerchant,
    this.idMerchantCategory,
    this.urlImage,
  });

  @override
  List<Object> get props => [
        id,
        idMerchant,
        idMerchantCategory,
        urlImage,
      ];

  factory AppContent.fromJson(Map<String, dynamic> data) => AppContent(
        id: data['id'],
        idMerchant: data['id_merchant'],
        idMerchantCategory: data['id_merchant_category'],
        urlImage: data['url_image'],
      );
}
