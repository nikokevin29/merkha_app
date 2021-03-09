part of 'models.dart';

class Wishlist extends Equatable {
  final int id;
  final int idUser;
  final int idProduct;

  Wishlist({
    this.id,
    this.idUser,
    this.idProduct,
  });

  factory Wishlist.fromJson(Map<String, dynamic> data) => Wishlist(
        id: data['id'],
        idUser: data['id_user'],
        idProduct: int.parse(data['id_product'].toString()),
      );

  @override
  List<Object> get props => [id, idUser, idProduct];
}
