part of 'models.dart';

class DetailOrder extends Equatable {
  final int id;
  final int idOrder;
  final int idProduct;
  final int amount;
  final double subtotal;
  final String productName;
  final double price;

  DetailOrder({
    this.id,
    this.idOrder,
    this.idProduct,
    this.amount,
    this.subtotal,
    this.productName,
    this.price,
  });

  @override
  List<Object> get props => [id, idOrder, idProduct, amount, subtotal, productName, price];

  factory DetailOrder.fromJson(Map<String, dynamic> data) => DetailOrder(
        id: data['id'],
        idOrder: data['id_order'],
        idProduct: data['id_product'],
        amount: data['amount'],
        subtotal: double.parse(data['subtotal']),
        productName: data['product_name'],
        price: double.parse(data['price']),
      );
}
