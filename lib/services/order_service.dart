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
        'order_status': order.orderStatus,
        //'id_voucher': order.idVoucher.toString(),
      }),
    );

    if (response.statusCode != 200) {
      print('StatusCode Order Create : ${response.statusCode}  ${order.idVoucher}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    Order value = Order.fromJson(data['data']);

    if (order.idVoucher.toString() != null) {
      //note: Edit id Voucher Database
      String url = baseURL + 'order/editvoucher/' + value.id.toString();
      var response = await client.put(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ' + User.token,
        },
        body: jsonEncode(<String, String>{'id_voucher': order.idVoucher.toString()}),
      );
      if (response.statusCode != 200) {
        print('Voucher Id Update Error');
      } else {
        print('Voucher Id Update Success');
      }
      //note: Decrement Qty and Max Usage Voucher Database
      VoucherServices.useVoucher(id: order.idVoucher.toString());
    }
    print('Order Created');
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<Order>> updateStatusOrder({Order order, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'order/editstatus/' + order.id.toString();
    var response = await client.put(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + User.token,
      },
      body: jsonEncode(<String, String>{
        'order_status': order.orderStatus,
      }),
    );
    if (response.statusCode != 200) {
      print('StatusCode Update Status Order : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    Order value = Order.fromJson(data['data']);
    print('Order Status Edited');
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<Order>> updateIdVoucher({Order order, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'order/editvoucher/' + order.id.toString();
    var response = await client.put(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + User.token,
      },
      body: jsonEncode(<String, String>{'id_voucher': order.orderStatus}),
    );
    if (response.statusCode != 200) {
      print('StatusCode Id Voucher Edit : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    Order value = Order.fromJson(data['data']);
    print('Voucher Id Edited');
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<DetailOrder>> createDetailOrder(
      {DetailOrder detail, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    print('idOrder di Detail Order' + detail.idOrder.toString());
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

  static Future<ApiReturnValue<List<Order>>> showOrder({http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'order/show';
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode Show Order: ${response.statusCode}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    print(data);
    List<Order> value = (data['data'] as Iterable).map((e) => Order.fromJson(e)).toList();
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<List<Order>>> showFinishedOrder(
      {Order order, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'order/show/finished';
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode showFinishedOrder : ${response.statusCode}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    List<Order> value = (data['data'] as Iterable).map((e) => Order.fromJson(e)).toList();
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<List<DetailOrder>>> showDetailOrder(
      {String idOrder, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    print('id Order in DetailOrder API get ' + idOrder);
    String url = baseURL + 'orderdetail/show/' + idOrder;
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode} _  show Detail Order by ' + idOrder);
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    List<DetailOrder> value =
        (data['data'] as Iterable).map((e) => DetailOrder.fromJson(e)).toList();
    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<Order>> triggerOrderExpired({http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'order/isExpired';
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + User.token,
    });
    if (response.statusCode != 200) {
      print('StatusCode Trigger Order : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    Order value = Order.fromJson(data['data']);
    return ApiReturnValue(value: value);
  }
}
