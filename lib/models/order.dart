part of 'models.dart';

class Order extends Equatable {
  final int id;
  final int idMerchant;
  final int idDestination;

  final String merchantName;
  final String address;
  final String province;
  final String city;
  final String receiveDate;
  final String orderStatus;
  final double shippingPrice;
  final double discountPrice;
  final double totalPrice;
  final String createdAt;
  final String updatedAt;
  final String detail;

  Order({
    this.id,
    this.idMerchant,
    this.idDestination,
    this.merchantName,
    this.address,
    this.province,
    this.city,
    this.receiveDate,
    this.orderStatus,
    this.shippingPrice,
    this.discountPrice,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.detail,
  });

  @override
  List<Object> get props => [
        id,
        idMerchant,
        idDestination,
        merchantName,
        address,
        province,
        city,
        receiveDate,
        orderStatus,
        shippingPrice,
        discountPrice,
        totalPrice,
        createdAt,
        updatedAt,
        detail,
      ];

  factory Order.fromJson(Map<String, dynamic> data) => Order(
        id: data['id'],
        idMerchant: data['id_merchant'],
        merchantName: data['merchant_name'],
        address: data['address'],
        province: data['province'],
        city: data['city'],
        receiveDate: data['received_date'],
        orderStatus: data['order_status'],
        shippingPrice: data['shipping_price'],
        discountPrice: data['discount_price'],
        totalPrice: data['total_price'],
        createdAt: data['created_at'],
        updatedAt: data['updated_at'],
        detail: data['detail'],
      );
}
