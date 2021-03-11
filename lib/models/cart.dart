part of 'models.dart';

class Cart {
  int id;
  String productName;
  String urlPreview;
  double price;
  double weight;
  int qty;

  int idMerchant;
  String merchantName;
  String merchantLogo;
  String idProvinceM;
  String idCityM;

  Cart(
      {this.id,
      this.productName,
      this.urlPreview,
      this.price,
      this.weight,
      this.qty,
      this.idMerchant,
      this.merchantName,
      this.merchantLogo,
      this.idProvinceM,
      this.idCityM});

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
      'weight': weight,
      'idMerchant': idMerchant,
      'merchantName': merchantName,
      'merchantLogo': merchantLogo,
      'idProvinceM': idProvinceM,
      'idCityM': idCityM,
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
      weight: double.parse(map['weight']),
      idMerchant: int.parse(map['idMerchant']),
      merchantName: map['merchantName'],
      merchantLogo: map['merchantLogo'],
      idProvinceM: map['idProvinceM'],
      idCityM: map['idCityM'],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));
}
