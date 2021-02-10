part of 'services.dart';

class OrderServices {
  static Future<ApiReturnValue<Order>> createOrder({Order order, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'order/create';
    var response = await client.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + User.token,
      },
      body: jsonEncode(<String, String>{
        'id_merchant': order.idMerchant.toString(),
        'id_destination': order.idDestination.toString(),
        'shipping_price': order.shippingPrice.toString(),
        'discount_price': order.discountPrice.toString(),
        'total_price': order.totalPrice.toString(),
      }),
    );
    if (response.statusCode != 200) {
      print('StatusCode Order Create : ${response.statusCode}');
      //print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    Order value = Order.fromJson(data['data']);
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<List<Order>>> showOrder({Order order, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'order/show';
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    List<Order> value = (data['data'] as Iterable).map((e) => Order.fromJson(e)).toList();
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<List<Order>>> showFinishedOrder(
      {Order order, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'feed/showownfeed';
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    List<Order> value = (data['data'] as Iterable).map((e) => Order.fromJson(e)).toList();
    return ApiReturnValue(value: value);
  }
}
