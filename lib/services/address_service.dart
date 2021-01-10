part of 'services.dart';

class AddressService {
  static Future<ApiReturnValue<List<Address>>> showAddress({http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'user/address';
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
    List<Address> address = (data['data'] as Iterable).map((e) => Address.fromJson(e)).toList();
    return ApiReturnValue(value: address, message: data['meta']['message']);
  }

  static Future<ApiReturnValue<Address>> addAddress(Address address, {http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'user/address';
    var response = await client.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + User.token,
      },
      body: jsonEncode(<String, String>{
        'address_save_name': address.addressSaveName,
        'address': address.address,
        'postal_code': address.postalCode,
        'city': address.city,
        'province': address.province,
      }),
    );
    
    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    Address value = Address.fromJson(data['data']);
    return ApiReturnValue(value: value, message: data['meta']['message']);
  }

  static Future<ApiReturnValue<Address>> editAddress(
      {String idaddress, Address address, http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'user/address/' + idaddress.toString();
    var response = await client.put(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + User.token,
      },
      body: jsonEncode(<String, String>{
        'address_save_name': address.addressSaveName,
        'address': address.address,
        'postal_code': address.postalCode,
        'city': address.city,
        'province': address.province,
      }),
    );
    var data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: data['meta']['message']);
    }
    Address value = Address.fromJson(data['data']);
    return ApiReturnValue(value: value, message: data['meta']['message']);
  }

  static Future<ApiReturnValue<Address>> deleteAddress(String id, {http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'user/address/' + id;
    var response = await client.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + User.token,
      },
    );
    var data = jsonDecode(response.body);
    if (response.statusCode != 200) {
      print('StatusCode : ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: response.body);
    }

    Address value = Address.fromJson(data['data']);
    return ApiReturnValue(value: value, message: data['meta']['message']);
  }
}
