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

    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    Voucher voucher = Voucher.fromJson(data['data']);
    return ApiReturnValue(value: voucher);
  }
}
