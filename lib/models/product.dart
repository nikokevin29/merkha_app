part of 'models.dart';

class Product extends Equatable {
  final int id;
  final String category;
  final int merchantId;
  final String merchant;
  final String productName;
  final String description;
  final double price;
  final String color;
  final String size;
  final int stock;
  final double weight;
  final int reportCount;
  final String createdAt;
  final String updatedAt;
  final String preview;
  final List<String> photo;

  Product({
    this.id,
    this.category,
    this.merchantId,
    this.merchant,
    this.productName,
    this.description,
    this.price,
    this.color,
    this.size,
    this.stock,
    this.weight,
    this.reportCount,
    this.createdAt,
    this.updatedAt,
    this.preview,
    this.photo,
  });

  @override
  List<Object> get props => [
        id,
        category,
        merchantId,
        merchant,
        productName,
        description,
        price,
        color,
        size,
        stock,
        weight,
        reportCount,
        createdAt,
        updatedAt,
        preview,
        photo
      ];

  factory Product.fromJson(Map<String, dynamic> data) => Product(
        id: data['id'],
        category: data['category'],
        merchantId: data['merchant_id'],
        merchant: data['merchant'],
        productName: data['product_name'],
        description: data['description'],
        price: double.parse(data['price']),
        color: data['color'],
        size: data['size'],
        stock: int.parse(data['stock'].toString()),
        weight: double.parse(data['weight'].toString()),
        preview: data['preview'],
        photo: List<String>.from(data['photo']),
        createdAt: data['created_at'],
        updatedAt: data['updated_at'],
      );
}
