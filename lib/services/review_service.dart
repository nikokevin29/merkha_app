part of 'services.dart';

class ReviewServices {
  static Future<ApiReturnValue<List<ReviewMerchant>>> showReviewMerchant(
      {String merchantId, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'review_merchant/showbyidmerchant/' + merchantId;
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
    List<ReviewMerchant> value =
        (data['data'] as Iterable).map((e) => ReviewMerchant.fromJson(e)).toList();
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<ReviewMerchant>> createReviewMerchant(ReviewMerchant review,
      {http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'review_merchant/create';
    var response = await client.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + User.token,
      },
      body: jsonEncode(<String, String>{
        'id_order': review.idOrder.toString(),
        'id_merchant': review.idMerchant.toString(),
        'is_hidden_name': review.isHiddenName,
        'stars': review.stars.toString(),
        'description': review.description,
      }),
    );

    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    ReviewMerchant value = ReviewMerchant.fromJson(data['data']);
    return ApiReturnValue(value: value, message: data['meta']['message']);
  }

  static Future<double> avgReviewMerchant({String idMerchant, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'review_merchant/avgreview/' + idMerchant;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode AVG Review Merchant: ${response.statusCode}');
      return 0;
    }
    var data = jsonDecode(response.body);
    return data;
  }

  static Future<int> checkReviewMerchant({String idOrder, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'check_review_merchant/' + idOrder;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode check_review_merchant: ${response.statusCode}');
      return 0;
    }
    var data = jsonDecode(response.body);
    return data;
  }

  static Future<ApiReturnValue<ReviewProduct>> createReviewProduct(ReviewProduct review,
      {http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'review_product/create';
    var response = await client.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + User.token,
      },
      body: jsonEncode(<String, String>{
        'id_product': review.idProduct.toString(),
        'is_hidden_name': review.isHiddenName,
        'stars': review.stars.toString(),
        'description': review.description,
      }),
    );

    if (response.statusCode != 200) {
      print('StatusCode create Review Product : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    ReviewProduct value = ReviewProduct.fromJson(data['data']);
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<List<ReviewProduct>>> showReviewProduct(
      {String productId, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'review_product/showbyidproduct/' + productId;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode Show Review Product: ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    List<ReviewProduct> value =
        (data['data'] as Iterable).map((e) => ReviewProduct.fromJson(e)).toList();
    return ApiReturnValue(value: value);
  }

  static Future<String> avgReviewProduct({String productId, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'review_product/avg/' + productId;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode: ${response.statusCode}');
      print('data : ${response.body}');
      return response.body;
    }
    return response.body;
  }
}
