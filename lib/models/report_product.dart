part of 'models.dart';

class ReportProduct extends Equatable {
  final int id;
  final int idProduct;
  final int idUser;
  ReportProduct({
    this.id,
    this.idProduct,
    this.idUser,
  });

  @override
  List<Object> get props => [
        id,
        idProduct,
        idUser,
      ];

  factory ReportProduct.fromJson(Map<String, dynamic> data) => ReportProduct(
        id: data['id'],
        idProduct: int.parse(data['id_product'].toString()),
        idUser: int.parse(data['id_user'].toString()),
      );
}
