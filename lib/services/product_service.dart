part of 'services.dart';

class ProductServices {
  static Future<ApiReturnValue<List<Product>>> showProductByCategory(
      {String categoryId, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'product/showbycategory/' + categoryId;
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
    List<Product> product = (data['data'] as Iterable).map((e) => Product.fromJson(e)).toList();
    return ApiReturnValue(value: product, message: data['meta']['message']);
  }

  static Future<ApiReturnValue<List<Product>>> showProductDiscover(
      {String limit, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'product/showdiscover/' + limit;
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
    List<Product> product = (data['data'] as Iterable).map((e) => Product.fromJson(e)).toList();
    return ApiReturnValue(value: product, message: data['meta']['message']);
  }

  static Future<ApiReturnValue<List<Product>>> showProductbyMerchant(
      {int idMerhcant, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'product/showbymerchant/' + idMerhcant.toString();
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
    List<Product> product = (data['data'] as Iterable).map((e) => Product.fromJson(e)).toList();
    return ApiReturnValue(value: product, message: data['meta']['message']);
  }

  static Future<ApiReturnValue<List<Product>>> showProductbyOrder(
      {int limit, String order, http.Client client}) async {
    // Order asc/desc
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'product/showbyorder/' + limit.toString() + '/' + order;
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
    List<Product> product = (data['data'] as Iterable).map((e) => Product.fromJson(e)).toList();
    return ApiReturnValue(value: product, message: data['meta']['message']);
  }

  static Future<ApiReturnValue<List<Product>>> showProductbyBestSeller(
      {String limit, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'product/showbybestseller/' + limit;
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
    List<Product> product = (data['data'] as Iterable).map((e) => Product.fromJson(e)).toList();
    return ApiReturnValue(value: product, message: data['meta']['message']);
  }

  static Future<ApiReturnValue<List<Product>>> searchFilterProduct(
      {String keyword, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'product/searchbyproduct/' + keyword;
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
    print(data);
    List<Product> product = (data['data'] as Iterable).map((e) => Product.fromJson(e)).toList();
    
    return ApiReturnValue(value: product, message: data['meta']['message']);
  }
  static Future<ApiReturnValue<List<Product>>> getProductById(
      {String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'product/showbyid/' + id;
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
    print(data);
    List<Product> product = (data['data'] as Iterable).map((e) => Product.fromJson(e)).toList();
    
    return ApiReturnValue(value: product, message: data['meta']['message']);
  }
}
