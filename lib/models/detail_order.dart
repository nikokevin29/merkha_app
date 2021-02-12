part of 'models.dart';

class DetailOrder extends Equatable {
  final int id;
  final int idOrder;
  final int idProduct;
  final int amount;
  final double subtotal;

  DetailOrder({
    this.id,
    this.idOrder,
    this.idProduct,
    this.amount,
    this.subtotal,
  });

  @override
  List<Object> get props => [id, idOrder, idProduct, amount, subtotal];

  factory DetailOrder.fromJson(Map<String, dynamic> data) => DetailOrder(
        id: data['id'],
        idOrder: int.parse(data['id_order']),
        idProduct: int.parse(data['id_product']),
        amount: int.parse(data['amount']),
        subtotal: double.parse(data['subtotal']),
      );
}
