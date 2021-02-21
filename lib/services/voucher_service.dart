part of 'services.dart';

class VoucherServices {
  static Future<ApiReturnValue<List<Voucher>>> showVoucher({http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'voucher/showall';
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
    List<Voucher> voucher = (data['data'] as Iterable).map((e) => Voucher.fromJson(e)).toList();
    return ApiReturnValue(value: voucher);
  }

  static Future<ApiReturnValue<Voucher>> useVoucher({String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'voucher/usevoucher/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode == 404) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'Not Found');
    } else if (response.statusCode == 406) {
      return ApiReturnValue(message: 'Voucher Sold Out or Reach Max Usage');
    } else if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Something Wrong');
    }
    var data = jsonDecode(response.body);

    Voucher voucher = Voucher.fromJson(data['data']);
    return ApiReturnValue(value: voucher);
  }

  static Future<ApiReturnValue<Voucher>> checkVoucher({String id, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'voucher/check/' + id;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });

    if (response.statusCode == 404) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'Not Found');
    } else if (response.statusCode == 406) {
      return ApiReturnValue(message: 'Voucher Sold Out or Reach Max Usage');
    } else if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Something Wrong');
    }
    var data = jsonDecode(response.body);
    print(data);
    Voucher voucher = Voucher.fromJson(data['data']);
    return ApiReturnValue(value: voucher);
  }

  
}
