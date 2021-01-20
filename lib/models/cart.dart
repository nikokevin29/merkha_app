part of 'models.dart';

class Cart {
  int id;
  String productName;
  String urlPreview;
  double price;
  int qty;

  int idMerchant;
  String merchantName;
  String merchantLogo;

  Cart({
    this.id,
    this.productName,
    this.urlPreview,
    this.price,
    this.qty,
    this.idMerchant,
    this.merchantName,
    this.merchantLogo,
  });

  // @override
  // List<Object> get props => [
  //       id,
  //       productName,
  //       urlPreview,
  //       price,
  //       qty,
  //       idMerchant,
  //       merchantName,
  //       merchantLogo,
  //     ];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'productName': productName,
      'urlPreview': urlPreview,
      'price': price,
      'qty': qty,
      'idMerchant': idMerchant,
      'merchantName': merchantName,
      'merchantLogo': merchantLogo,
    };

    if (id != null) {
      map[LocalStorage.id] = id;
    }

    return map;
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Cart(
      id: map['id'],
      productName: map['productName'],
      urlPreview: map['urlPreview'],
      price: double.parse(map['price']),
      qty: int.parse(map['qty']),
      idMerchant: int.parse(map['idMerchant']),
      merchantName: map['merchantName'],
      merchantLogo: map['merchantLogo'],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));
}
