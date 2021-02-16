part of 'models.dart';

class Order extends Equatable {
  final int id;
  final int idMerchant;
  final int idDestination;
  final int idVoucher;
  final String orderNumber;

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
  final String preview;

  Order({
    this.id,
    this.idMerchant,
    this.idDestination,
    this.orderNumber,
    this.idVoucher,
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
    this.preview,
  });

  @override
  List<Object> get props => [
        id,
        idMerchant,
        idDestination,
        orderNumber,
        idVoucher,
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
        preview,
      ];

  factory Order.fromJson(Map<String, dynamic> data) => Order(
        id: data['id'],
        idMerchant: int.parse(data['id_merchant'].toString()),
        orderNumber: data['order_number'],
        merchantName: data['merchant_name'],
        address: data['address'],
        province: data['province'],
        city: data['city'],
        receiveDate: data['received_date'],
        orderStatus: data['order_status'],
        shippingPrice: double.parse(data['shipping_price']),
        discountPrice: double.parse(data['discount_price']),
        totalPrice: double.parse(data['total_price']),
        createdAt: data['created_at'],
        updatedAt: data['updated_at'],
        preview: data['preview'],
      );
}
