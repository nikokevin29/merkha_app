part of 'models.dart';

class UserInterest extends Equatable {
  final String idCategory;
  final String category;
  final String urlIcon;

  UserInterest({this.idCategory, this.category, this.urlIcon});

  factory UserInterest.fromJson(Map<String, dynamic> data) => UserInterest(
        idCategory: data['id_category'].toString(),
        category: data['category'],
        urlIcon: data['url_icon'],
      );

  @override
  List<Object> get props => [idCategory, category, urlIcon];
}
