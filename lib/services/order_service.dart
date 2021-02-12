part of 'services.dart';

class OrderServices {
  static Future<ApiReturnValue<Order>> createOrder({Order order, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'order/create';
    //id_merchant, id_buyer(auto), id_destination, id_voucher,order_number(auto), order_status,shipping_price, discount_price, total_price
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
        (order.idVoucher.toString() != null) ? 'id_voucher' : order.idVoucher.toString(): null,
        'order_status': order.orderStatus,
      }),
    );
    if (response.statusCode != 200) {
      print('StatusCode Order Create : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    Order value = Order.fromJson(data['data']);
    print('Order Created');
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<DetailOrder>> createDetailOrder(
      {DetailOrder detail, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'orderdetail/create';
    var response = await client.post(url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ' + User.token,
        },
        body: jsonEncode(<String, String>{
          'id_order': detail.idOrder.toString(),
          'id_product': detail.idProduct.toString(),
          'amount': detail.amount.toString(),
          'subtotal': detail.subtotal.toString(),
        }));
    if (response.statusCode != 200) {
      print('StatusCode Detail Order : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    print('Create Detail Product Id : ' + detail.idProduct.toString());
    var data = jsonDecode(response.body);
    DetailOrder value = DetailOrder.fromJson(data['data']);
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
