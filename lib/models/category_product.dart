part of 'models.dart';

class CategoryProduct extends Equatable {
  final int id;
  // ignore: non_constant_identifier_names
  final String url_icon;
  // ignore: non_constant_identifier_names
  final String category_name;

  // ignore: non_constant_identifier_names
  CategoryProduct({this.id, this.url_icon, this.category_name});

  factory CategoryProduct.fromJson(Map<String, dynamic> data) => CategoryProduct(
        id: data['id'],
        url_icon: data['url_icon'],
        category_name: data['category_name'],
      );

  @override
  List<Object> get props => [id, url_icon, category_name];
}
