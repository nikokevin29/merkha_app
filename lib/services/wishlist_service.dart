part of 'services.dart';

class WishlistService {
  static Future<ApiReturnValue<List<Product>>> showWishlist({http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'wishlist/show';
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    List<Product> wishlist = (data['data'] as Iterable).map((e) => Product.fromJson(e)).toList();
    return ApiReturnValue(value: wishlist, message: data['meta']['message']);
  }

  static Future<ApiReturnValue<Wishlist>> addWishlist(Wishlist wishlist,
      {http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'wishlist/add';
    var response = await client.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + User.token,
      },
      body: jsonEncode(<String, String>{
        'id_product': wishlist.idProduct.toString(),
      }),
    );

    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    Wishlist value = Wishlist.fromJson(data['data']);
    return ApiReturnValue(value: value, message: data['meta']['message']);
  }

  static Future<ApiReturnValue<Wishlist>> deleteWishlist(String id, {http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'wishlist/delete/' + id;
    var response = await client.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + User.token,
      },
    );

    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: response.body);
    }
    var data = jsonDecode(response.body);
    return ApiReturnValue(message: data['meta']['message']);
  }
}
