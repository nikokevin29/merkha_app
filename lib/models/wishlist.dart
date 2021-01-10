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
        idProduct: data['id_product'],
      );

  @override
  List<Object> get props => [id, idUser, idProduct];
}
