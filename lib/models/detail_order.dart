part of 'models.dart';

class DetailOrder extends Equatable {
  final int id;
  final int idOrder;
  final int idProduct;
  final int amount;
  final double subtotal;
  final String productName;
  final double productPrice;
  //final double price;

  DetailOrder({
    this.id,
    this.idOrder,
    this.idProduct,
    this.amount,
    this.subtotal,
    this.productName,
    this.productPrice,
  });

  @override
  List<Object> get props => [id, idOrder, idProduct, amount, subtotal, productName, productPrice];

  factory DetailOrder.fromJson(Map<String, dynamic> data) => DetailOrder(
        id: data['id'],
        idOrder: int.parse(data['id_order'].toString()),
        idProduct: int.parse(data['id_product'].toString()),
        amount: int.parse(data['amount'].toString()),
        subtotal: double.parse(data['subtotal'].toString()),
        productName: data['product_name'],
        productPrice: double.parse(data['product_price'].toString()),
      );
}
