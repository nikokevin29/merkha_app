part of 'models.dart';

class Payment extends Equatable {
  final int id;
  final int idOrder;
  final int paymentStatus; // 0 or 1 but stored in int
  final String urlBuktiTransfer;
  Payment({
    this.id,
    this.idOrder,
    this.paymentStatus,
    this.urlBuktiTransfer,
  });
  @override
  List<Object> get props => [id, idOrder, paymentStatus, urlBuktiTransfer];

  factory Payment.fromJson(Map<String, dynamic> data) => Payment(
        id: data['id'],
        idOrder: int.parse(data['id_order']),
        paymentStatus: int.parse(data['payment_status']),
        urlBuktiTransfer: data['url_bukti_transfer'],
      );
}
