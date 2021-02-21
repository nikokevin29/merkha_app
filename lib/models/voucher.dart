part of 'models.dart';

class Voucher extends Equatable {
  final int id;
  final int idMerchant;
  final String merchant;
  final String merchantLogo;
  final String voucherName;
  final String voucherCode;
  final String voucherType;
  final int voucherQuantity;
  final int minBasketSize;
  final int maxUsage;
  final double discAmount;
  final double discRate;
  final String validDate;

  Voucher({
    this.id,
    this.idMerchant,
    this.merchant,
    this.merchantLogo,
    this.voucherName,
    this.voucherCode,
    this.voucherType,
    this.voucherQuantity,
    this.minBasketSize,
    this.maxUsage,
    this.discAmount,
    this.discRate,
    this.validDate,
  });

  @override
  List<Object> get props => [
        id,
        idMerchant,
        merchant,
        merchantLogo,
        voucherName,
        voucherCode,
        voucherType,
        voucherQuantity,
        minBasketSize,
        maxUsage,
        discAmount,
        discRate,
        validDate
      ];

  factory Voucher.fromJson(Map<String, dynamic> data) => Voucher(
        id: data['id'],
        idMerchant: data['id_merchant'],
        merchant: data['merchant'],
        merchantLogo: data['merchant_logo'],
        voucherName: data['voucher_name'],
        voucherCode: data['voucher_code'],
        voucherType: data['voucher_type'],
        voucherQuantity: data['voucher_quantity'],
        minBasketSize: data['minBasket_size'],
        maxUsage: data['max_usage'],
        discAmount: double.parse(data['disc_amount'].toString()),
        discRate: double.parse(data['disc_rate'].toString()),
        validDate: data['valid_date'],
      );
}
