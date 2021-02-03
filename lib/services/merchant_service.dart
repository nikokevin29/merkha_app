part of 'services.dart';

class MerchantService {
  static Future<ApiReturnValue<List<Merchant>>> showMerchantByRandom(
      {String limit, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'merchant/showbyrandom/' + limit;
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
    print(data['meta']['message']);
    List<Merchant> merchant = (data['data'] as Iterable).map((e) => Merchant.fromJson(e)).toList();
    return ApiReturnValue(value: merchant, message: data['meta']['message']);
  }

  static Future<ApiReturnValue<List<Merchant>>> searchFilterMerchant(
      {String keyword, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'merchant/searchbymerchant/' + keyword;
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
    List<Merchant> merchant = (data['data'] as Iterable).map((e) => Merchant.fromJson(e)).toList();

    return ApiReturnValue(value: merchant, message: data['meta']['message']);
  }

  static Future<ApiReturnValue<Merchant>> showByMerchantId(
      {String merchantId, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'merchant/showbymerchantid/' + merchantId;
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

    Merchant value = Merchant.fromJson(data['data']);
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<List<MerchantCategory>>> showAllMerchantCategory(
      {http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'merchant_category/showall';
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode Merchant Category : ${response.statusCode}');
      //print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    List<MerchantCategory> merchantcat =
        (data['data'] as Iterable).map((e) => MerchantCategory.fromJson(e)).toList();
    return ApiReturnValue(value: merchantcat);
  }
}
