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
        idOrder: data['id_order'],
        idProduct: data['id_product'],
        amount: data['amount'],
        subtotal: data['subtotal'],
      );
      
}
